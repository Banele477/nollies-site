#!/data/data/com.termux/files/usr/bin/bash
set -e

cd ~/nollies

echo "======================================================="
echo "🧹 Cleaning up scattered files and structuring Nollie's..."
echo "======================================================="

# 1. Ensure clean directory hierarchy
mkdir -p public/css public/js public/img data

# 2. Move any misplaced files into their correct folders if they exist
[ -f style.css ] && mv style.css public/css/
[ -f script.js ] && mv script.js public/js/
[ -f index.html ] && cp index.html public/index.html

# 3. Clean up unnecessary temporary or backup files
rm -f *.bak *.tmp *~ 2>/dev/null || true

# 4. Check git status and configure clean git ignore if missing
cat > .gitignore << 'GITIGNORE_EOF'
data/
.siteurl
.gverify
*.bak
*.tmp
__pycache__/
.gsc-key.json
vEnv/
venv/
GITIGNORE_EOF

echo "Files organized. Staging and committing changes to Git..."

# 5. Git status check & clean push
git add -A
if git diff --cached --quiet; then
    echo "Repository is already clean."
else
    git commit -m "Clean up scattered files and restructure Mzansi web app"
    echo "Pushing clean structure to GitHub..."
    git push origin main || git push origin master
fi

echo "======================================================="
echo "✅ GitHub repository cleaned and successfully synchronized!"
echo "======================================================="
