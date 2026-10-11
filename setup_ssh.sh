echo "[*] Cleaning up any incorrect key files..."
rm -f ~/Ban123*#

echo "[*] Generating new SSH key (default path)..."
ssh-keygen -t ed25519 -C "somkhandabanele8@gmail.com" -N "Ban123*#" -f ~/.ssh/id_ed25519

echo "[*] Starting SSH agent..."
eval "$(ssh-agent -s)"

echo "[*] Adding SSH key to agent..."
ssh-add ~/.ssh/id_ed25519

echo "[*=============================================================*]"
echo "[+] SUCCESS! Your public SSH key is below. Copy it to GitHub:"
echo "[*=============================================================*]"
cat ~/.ssh/id_ed25519.pub
echo ""
echo "[*=============================================================*]"
