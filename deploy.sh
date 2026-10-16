#!/data/data/com.termux/files/usr/bin/bash
# deploy.sh - publish Nollie's site to GitHub Pages from Termux
cd "$(dirname "$0")" || exit 1
SITEFILE=.siteurl
VERFILE=.gverify

fix_seo() {
  if [ -f "$SITEFILE" ] && grep -rq "__SITE_URL__" public; then
    SITE=$(cat "$SITEFILE")
    sed -i "s#__SITE_URL__#$SITE#g" public/index.html public/sitemap.xml public/robots.txt 2>/dev/null || true
  fi
  if [ -f "$VERFILE" ] && ! grep -q google-site-verification public/index.html; then
    sed -i "s#<meta charset=\"utf-8\">#&\n<meta name=\"google-site-verification\" content=\"$(cat $VERFILE)\">#" public/index.html
  fi
}

push() {
  fix_seo
  git add -A
  if git diff --cached --quiet; then echo "Nothing new to publish."; return 0; fi
  git commit -qm "${1:-Update site $(date '+%F %H:%M')}"
  if git push -q origin main; then
    echo "Published. Live in about a minute at: $(cat $SITEFILE 2>/dev/null)"
    [ -f .gsc-key.json ] && { (sleep 90; python gsc.py sitemap >/dev/null 2>&1) & }
  else
    echo "Push failed. Check your internet connection or login credentials."
    return 1
  fi
}

init() {
  REPO="${1:-nollies-site}"
  pkg install -y git gh >/dev/null 2>&1 || true
  gh auth status >/dev/null 2>&1 || gh auth login -h github.com -p https -s workflow -w
  gh auth setup-git
  U=$(gh api user -q .login) || { echo "Login failed."; exit 1; }
  git config --global user.name  >/dev/null || git config --global user.name "$U"
  git config --global user.email >/dev/null || git config --global user.email "$U@users.noreply.github.com"
  if [ "$REPO" = "$U.github.io" ]; then echo "https://$U.github.io/" > $SITEFILE
  else echo "https://$U.github.io/$REPO/" > $SITEFILE; fi
  [ -d .git ] || git init -q -b main
  fix_seo
  git add -A
  git commit -qm "First version" 2>/dev/null || true
  gh repo create "$REPO" --public --source=. --remote=origin >/dev/null 2>&1 || true
  git remote get-url origin >/dev/null 2>&1 || git remote add origin "https://github.com/$U/$REPO.git"
  gh api -X POST "repos/$U/$REPO/pages" -f build_type=workflow >/dev/null 2>&1 \
    || gh api -X PUT "repos/$U/$REPO/pages" -f build_type=workflow >/dev/null 2>&1 || true
  git push -u origin main && {
    echo ""
    echo "Done. Your site will be live in 1-2 minutes at:"
    cat $SITEFILE
  }
}

watch() {
  command -v termux-wake-lock >/dev/null && termux-wake-lock
  echo "Watching for changes every 60 seconds. Press Ctrl+C to stop."
  while true; do
    if [ -n "$(git status --porcelain)" ]; then push "Auto update $(date '+%F %H:%M')"; fi
    sleep 60
  done
}

case "$1" in
  init)   shift; init "$@" ;;
  watch)  watch ;;
  google) python gsc.py setup "$2" ;;
  report) python gsc.py report ;;
  verify) [ -n "$2" ] || { echo "Usage: ./deploy.sh verify CODE"; exit 1; }
          echo "$2" > $VERFILE; push "Add Google verification" ;;
  *)      push "$1" ;;
esac
