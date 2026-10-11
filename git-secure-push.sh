#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

REPO_DIR="$HOME/nollies"
cd "$REPO_DIR"

echo "[*] Step 1: Checking for accidental hardcoded secrets or keys..."
if command -v git-secrets &> /dev/null; then
    git secrets --scan || { echo "[!] ERROR: Potential secret detected! Aborting push."; exit 1; }
fi

echo "[*] Step 2: Ensuring SSH agent is running and key is loaded..."
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
fi

# Add key if not already loaded in the agent
if ! ssh-add -l | grep -q "ed25519"; then
    ssh-add ~/.ssh/id_ed25519
fi

echo "[*] Step 3: Staging and committing changes with signature..."
git add .

# Check if there is anything to commit
if git diff-index --quiet HEAD --; then
    echo "[*] No changes to commit. Proceeding to push..."
else
    # Prompts for commit message if not provided as argument
    MSG="${1:-Automated secure sync from Termux}"
    git commit -S -m "$MSG"
fi

echo "[*] Step 4: Securely pushing to GitHub via SSH..."
git push origin main

echo "[+] SUCCESS: Code securely pushed to GitHub with verified commit signature!"
