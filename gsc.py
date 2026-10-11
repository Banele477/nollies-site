#!/usr/bin/env python3
"""Google Search Console automation for Nollie's site (no pip installs needed).

  python gsc.py setup you@gmail.com   verify the site, add you as owner, submit sitemap
  python gsc.py sitemap               (re)submit sitemap.xml
  python gsc.py report                clicks and impressions, last 28 days

Needs .gsc-key.json (Google service account key) and .siteurl in this folder.
"""
import base64, datetime, json, os, subprocess, sys, tempfile, time
import urllib.error, urllib.parse, urllib.request

BASE = os.path.dirname(os.path.abspath(__file__))
KEYFILE = os.path.join(BASE, ".gsc-key.json")
SITEFILE = os.path.join(BASE, ".siteurl")
SCOPES = ["https://www.googleapis.com/auth/siteverification",
          "https://www.googleapis.com/auth/webmasters"]


def die(msg):
    print("ERROR:", msg)
    sys.exit(1)


def b64(b):
    return base64.urlsafe_b64encode(b).rstrip(b"=").decode()


def build_jwt(key, scopes, now=None):
    now = int(now or time.time())
    head = b64(json.dumps({"alg": "RS256", "typ": "JWT"}).encode())
    claim = b64(json.dumps({"iss": key["client_email"], "scope": " ".join(scopes),
                            "aud": "https://oauth2.googleapis.com/token",
                            "iat": now, "exp": now + 3600}).encode())
    unsigned = f"{head}.{claim}".encode()
    with tempfile.NamedTemporaryFile("w", suffix=".pem") as f:
        f.write(key["private_key"]); f.flush()
        sig = subprocess.run(["openssl", "dgst", "-sha256", "-sign", f.name],
                             input=unsigned, capture_output=True, check=True).stdout
    return f"{head}.{claim}.{b64(sig)}"


def http(method, url, headers=None, data=None):
    req = urllib.request.Request(url, data=data, method=method, headers=headers or {})
    try:
        with urllib.request.urlopen(req, timeout=30) as r:
            raw = r.read()
            return json.loads(raw) if raw else {}
    except urllib.error.HTTPError as e:
        body = e.read().decode("utf-8", "replace")
        try:
            body = json.loads(body)["error"]["message"]
        except Exception:
            pass
        raise RuntimeError(f"{e.code} {body}")


def get_token():
    if not os.path.exists(KEYFILE):
        die("Missing .gsc-key.json. Follow the Google Cloud steps first.")
    key = json.load(open(KEYFILE))
    form = urllib.parse.urlencode({"grant_type": "urn:ietf:params:oauth:grant-type:jwt-bearer",
                                   "assertion": build_jwt(key, SCOPES)}).encode()
    r = http("POST", "https://oauth2.googleapis.com/token",
             {"Content-Type": "application/x-www-form-urlencoded"}, form)
    return r["access_token"]


def api(method, url, tok, body=None):
    h = {"Authorization": "Bearer " + tok}
    data = None
    if body is not None:
        h["Content-Type"] = "application/json"
        data = json.dumps(body).encode()
    return http(method, url, h, data)


def site_url():
    if not os.path.exists(SITEFILE):
        die("Missing .siteurl. Run ./deploy.sh init first.")
    return open(SITEFILE).read().strip()


def enc(s):
    return urllib.parse.quote(s, safe="")


def wait_live(site, code, minutes=10):
    for i in range(minutes * 4):
        try:
            req = urllib.request.Request(f"{site}?t={int(time.time())}", headers={"Cache-Control": "no-cache"})
            if code in urllib.request.urlopen(req, timeout=20).read().decode("utf-8", "replace"):
                return True
        except Exception:
            pass
        time.sleep(15)
    return False


def submit_sitemap(tok, site):
    api("PUT", f"https://www.googleapis.com/webmasters/v3/sites/{enc(site)}/sitemaps/{enc(site + 'sitemap.xml')}", tok)
    print("Sitemap submitted:", site + "sitemap.xml")


def cmd_setup(email):
    site = site_url()
    tok = get_token()
    ident = {"identifier": site, "type": "SITE"}
    print("1/5 Asking Google for a verification code...")
    t = api("POST", "https://www.googleapis.com/siteVerification/v1/token", tok,
            {"site": ident, "verificationMethod": "META"})["token"]
    code = t.split('content="')[1].split('"')[0]
    print("2/5 Publishing the code on your site...")
    r = subprocess.run(["bash", os.path.join(BASE, "deploy.sh"), "verify", code], cwd=BASE)
    if r.returncode != 0:
        die("Publishing failed. Run ./deploy.sh and fix any message it shows.")
    print("3/5 Waiting for GitHub to show the code (up to 10 minutes)...")
    if not wait_live(site, code):
        die("The code is not live yet. Wait a few minutes and run this command again.")
    print("4/5 Verifying ownership...")
    body = {"site": ident, "owners": [email]}
    last = None
    for _ in range(4):
        try:
            api("POST", "https://www.googleapis.com/siteVerification/v1/webResource?verificationMethod=META", tok, body)
            last = None
            break
        except RuntimeError as e:
            last = e
            time.sleep(20)
    if last:
        die(f"Google could not verify: {last}")
    print("   Verified. You were added as an owner.")
    print("5/5 Adding the site to Search Console and sending the sitemap...")
    api("PUT", f"https://www.googleapis.com/webmasters/v3/sites/{enc(site)}", tok)
    submit_sitemap(tok, site)
    print("Done. Open search.google.com/search-console with", email, "to see your site.")


def cmd_sitemap():
    submit_sitemap(get_token(), site_url())


def cmd_report():
    site, tok = site_url(), get_token()
    end = datetime.date.today() - datetime.timedelta(days=2)
    start = end - datetime.timedelta(days=28)
    body = {"startDate": str(start), "endDate": str(end), "dimensions": ["query"], "rowLimit": 10}
    r = api("POST", f"https://www.googleapis.com/webmasters/v3/sites/{enc(site)}/searchAnalytics/query", tok, body)
    rows = r.get("rows", [])
    if not rows:
        print("No search data yet. Google needs days or weeks after indexing.")
        return
    print(f"Top searches {start} to {end}")
    for x in rows:
        print(f"{x['keys'][0][:40]:40} clicks {int(x['clicks']):4} views {int(x['impressions']):5}")


def main(argv):
    try:
        if len(argv) > 1 and argv[1] == "setup" and len(argv) > 2:
            cmd_setup(argv[2])
        elif len(argv) > 1 and argv[1] == "sitemap":
            cmd_sitemap()
        elif len(argv) > 1 and argv[1] == "report":
            cmd_report()
        else:
            print(__doc__)
    except RuntimeError as e:
        die(str(e))


if __name__ == "__main__":
    main(sys.argv)
