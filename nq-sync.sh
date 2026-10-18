#!/data/data/com.termux/files/usr/bin/bash
cd ~/nollies || exit 1
mkdir -p public/images ~/storage/shared/Nollies

# 1) import new photos from phone folder "Nollies"
for f in ~/storage/shared/Nollies/*; do
  case "${f,,}" in *.jpg|*.jpeg|*.png|*.webp) ;; *) continue;; esac
  n=$(basename "$f" | tr 'A-Z ' 'a-z-' | sed -E 's/\.[A-Za-z]+$//; s/[^a-z0-9._-]//g').jpg
  convert "$f" -auto-orient -resize '900x>' -quality 72 "public/images/$n" 2>/dev/null && echo "📥 $n"
done

# 2) shrink any heavy photo
for p in public/images/*.jpg; do
  [ -f "$p" ] || continue
  [ "$(stat -c%s "$p")" -gt 300000 ] && convert "$p" -auto-orient -resize '900x>' -quality 72 "$p" 2>/dev/null
done

N=$(ls public/images 2>/dev/null | grep -ciE '\.(jpe?g|png|webp)$')
if [ "$N" -eq 0 ]; then
  echo "❌ No photos found. Put your photos in the phone folder:  Nollies  (in internal storage), then run:  bash ~/nollies/nq-sync.sh"
  exit 1
fi

# 3) tell the website which photos exist
names=$(ls public/images | grep -iE '\.(jpe?g|png|webp)$' | sed 's/.*/"&"/' | paste -sd, -)
sed -i "s#^var NAMES=.*#var NAMES=[$names];#" public/img-handler.js

# 4) make sure photos are not git-ignored, link handler once
[ -f .gitignore ] && sed -i -E '/(images|\.jpe?g|\.png)/Id' .gitignore
grep -q 'img-handler.js' public/index.html || sed -i 's#</body>#<script src="img-handler.js" defer></script>\n</body>#' public/index.html

# 5) publish
if [ ! -d .github/workflows ]; then cp -r public/. .; mkdir -p docs; cp -r public/. docs/; fi
git add -A
git commit -q -m "Update photos ($N)" || echo "Nothing new to commit"
git push && echo "🚀 Pushed $N photos"

O=$(sed -n 's/^var OWNER="\(.*\)";/\1/p' public/img-handler.js)
R=$(sed -n 's/^var REPO="\(.*\)";/\1/p' public/img-handler.js)
F=$(ls public/images | head -1)
echo ""
echo "⏳ Wait 2 minutes, then open this test link:"
echo "https://$O.github.io/$R/images/$F"
echo "Photo shows = images work. Then refresh your site."
