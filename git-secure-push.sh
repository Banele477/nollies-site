#!/bin/bash
set -e

REPO_DIR="$HOME/nollies"
LOG_FILE="$REPO_DIR/.git_push_audit.log"
cd "$REPO_DIR"

echo "[*] Step 1: Auditing session..."
echo "$(date '+%Y-%m-%d %H:%M:%S') - Initiating secure push" >> "$LOG_FILE"

echo "[*] Step 2: Scanning for hardcoded secrets..."
if command -v git-secrets &> /dev/null; then
    git secrets --scan || { echo "[!] ERROR: Potential secret detected!"; exit 1; }
fi

echo "[*] Step 3: Ensuring SSH agent is active..."
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
fi

if ! ssh-add -l | grep -q "ed25519"; then
    ssh-add ~/.ssh/id_ed25519
fi

echo "[*] Step 4: Staging, signing, and committing..."
git add .

if git diff-index --quiet HEAD --; then
    echo "[*] No pending changes to commit. Proceeding to push..."
else
    MSG="${1:-Automated secure sync with enhanced auditing}"
    git commit -S -m "$MSG"
fi

echo "[*] Step 5: Pushing to GitHub..."
git push origin main

echo "[+] SUCCESS: Pushed securely with full audit trail!"
