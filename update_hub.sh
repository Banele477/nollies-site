#!/data/data/com.termux/files/usr/bin/bash
cd ~/nollies
python3 automation/auto_update.py
git add .
git commit -m "Automated update via Nollie's template engine" || echo "No changes"
git push origin main || git push origin master
echo "✨ Auto-update routine completed and pushed to GitHub!"
