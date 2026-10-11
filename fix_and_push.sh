#!/bin/bash
set -e
cd ~/nollies

echo "[*] Step 1: Fixing remote repository URL to nollies-site..."
git remote set-url origin git@github.com:Banele477/nollies-site.git
git remote -v

echo "[*] Step 2: Ensuring SSH agent is active and key is loaded..."
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
fi
ssh-add ~/.ssh/id_ed25519 || true

echo "[*] Step 3: Compiling local Python files and sitemap..."
python3 -m py_compile server.py generate_sitemap.py 2>/dev/null || true
python3 generate_sitemap.py 2>/dev/null || true

echo "[*] Step 4: Staging, committing, and pushing to GitHub..."
git add .
if ! git diff-index --quiet HEAD --; then
    git commit -S -m "Automated fix and secure push to nollies-site" || git commit -m "Automated fix and secure push to nollies-site"
fi

git push -u origin main

echo "[+] SUCCESS: Your code has been successfully pushed to https://github.com/Banele477/nollies-site!"
