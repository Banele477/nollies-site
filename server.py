#!/usr/bin/env python3
"""Tiny server for Nollie's website. No pip installs needed.

Run:   ADMIN_KEY=your-secret python server.py
Open:  http://localhost:8080        (shop)
       http://localhost:8080/admin.html   (orders, needs ADMIN_KEY)
"""
import json, os, threading, time
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer

BASE = os.path.dirname(os.path.abspath(__file__))
PUBLIC = os.path.join(BASE, "public")
DATA = os.path.join(BASE, "data", "orders.json")
HOST = os.environ.get("HOST", "0.0.0.0")
PORT = int(os.environ.get("PORT", "8080"))
ADMIN_KEY = os.environ.get("ADMIN_KEY", "")
LOCK = threading.Lock()
MAX_BODY = 20_000


def load():
    try:
        with open(DATA, encoding="utf-8") as f:
            return json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):
        return []


def save(rows):
    os.makedirs(os.path.dirname(DATA), exist_ok=True)
    tmp = DATA + ".tmp"
    with open(tmp, "w", encoding="utf-8") as f:
        json.dump(rows, f, ensure_ascii=False, indent=2)
    os.replace(tmp, DATA)


def clean(v, n=300):
    return str(v)[:n].strip()


class Handler(SimpleHTTPRequestHandler):
    extensions_map = {**SimpleHTTPRequestHandler.extensions_map, ".webmanifest": "application/manifest+json"}

    def __init__(self, *a, **kw):
        super().__init__(*a, directory=PUBLIC, **kw)

    def send_json(self, code, obj):
        body = json.dumps(obj).encode()
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(body)

    def do_POST(self):
        if self.path != "/api/order":
            return self.send_json(404, {"error": "not found"})
        try:
            size = int(self.headers.get("Content-Length", 0))
            if size <= 0 or size > MAX_BODY:
                return self.send_json(413, {"error": "bad size"})
            d = json.loads(self.rfile.read(size))
        except (ValueError, json.JSONDecodeError):
            return self.send_json(400, {"error": "bad json"})
        if d.get("type") not in ("order", "bulk") or not clean(d.get("name")) or not clean(d.get("phone")):
            return self.send_json(400, {"error": "missing fields"})
        row = {"received": time.strftime("%Y-%m-%d %H:%M:%S"), "status": "new"}
        for k in ("type", "id", "name", "phone", "method", "address", "notes", "item", "date", "day", "slot"):
            if k in d:
                row[k] = clean(d[k])
        for k in ("subtotal", "delivery", "rushFee", "total", "qty"):
            if isinstance(d.get(k), (int, float)):
                row[k] = d[k]
        row["rush"] = bool(d.get("rush"))
        if isinstance(d.get("items"), list):
            row["items"] = [
                {"name": clean(i.get("name"), 80), "qty": int(i.get("qty", 0)), "price": float(i.get("price", 0))}
                for i in d["items"][:50] if isinstance(i, dict)
            ]
        with LOCK:
            rows = load()
            rows.append(row)
            save(rows)
        self.send_json(200, {"ok": True})

    def do_GET(self):
        if self.path.split("?")[0] == "/api/orders":
            if not ADMIN_KEY or self.headers.get("X-Admin-Key", "") != ADMIN_KEY:
                return self.send_json(401, {"error": "unauthorised"})
            with LOCK:
                return self.send_json(200, list(reversed(load())))
        return super().do_GET()

    def end_headers(self):
        self.send_header("X-Content-Type-Options", "nosniff")
        super().end_headers()


if __name__ == "__main__":
    if not ADMIN_KEY:
        print("NOTE: ADMIN_KEY is not set, so the admin page is disabled.")
        print("      Start with:  ADMIN_KEY=your-secret python server.py")
    print(f"Nollie's site running on http://localhost:{PORT}")
    ThreadingHTTPServer((HOST, PORT), Handler).serve_forever()

import datetime
def log_admin_action(action_desc):
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open("admin_activity.log", "a") as log_file:
        log_file.write(f"[{timestamp}] ADMIN ACTION: {action_desc}\n")
