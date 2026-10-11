#!/bin/bash
set -e
cd ~/nollies

echo "[*] Step 1: Adding admin action logger to server.py..."
if [ -f "server.py" ]; then
    if ! grep -q "log_admin_action" server.py; then
        cat << 'PYCODE' >> server.py

import datetime
def log_admin_action(action_desc):
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open("admin_activity.log", "a") as log_file:
        log_file.write(f"[{timestamp}] ADMIN ACTION: {action_desc}\n")
PYCODE
        echo "[+] Admin logger appended to server.py"
    fi
fi

echo "[*] Step 2: Creating frontend feature helper (public/js/features.js)..."
mkdir -p public/js
cat << 'JSCODE' > public/js/features.js
// Toast Notification System
function showToast(message) {
    let toast = document.getElementById("toast");
    if (!toast) {
        toast = document.createElement("div");
        toast.id = "toast";
        toast.style.cssText = "visibility: hidden; min-width: 250px; background-color: #333; color: #fff; text-align: center; border-radius: 4px; padding: 16px; position: fixed; z-index: 1000; left: 50%; bottom: 30px; transform: translateX(-50%); transition: visibility 0.5s, opacity 0.5s; opacity: 0;";
        document.body.appendChild(toast);
    }
    toast.innerText = message;
    toast.style.visibility = "visible";
    toast.style.opacity = "1";
    setTimeout(() => {
        toast.style.opacity = "0";
        toast.style.visibility = "hidden";
    }, 3000);
}

// Theme Toggle System
if (localStorage.getItem('theme') === 'dark') {
    document.body.classList.add('dark-theme');
}

function toggleTheme() {
    document.body.classList.toggle('dark-theme');
    let isDark = document.body.classList.contains('dark-theme');
    localStorage.setItem('theme', isDark ? 'dark' : 'light');
    showToast(isDark ? "Dark mode enabled" : "Light mode enabled");
}

// Product Search Filter
function filterProducts() {
    let input = document.getElementById('searchInput');
    if (!input) return;
    let filter = input.value.toLowerCase();
    let cards = document.querySelectorAll('.product-card');
    cards.forEach(card => {
        let title = card.innerText.toLowerCase();
        card.style.display = title.includes(filter) ? "" : "none";
    });
}
JSCODE

echo "[*] Step 3: Pushing updates securely..."
if [ -f "./git-secure-push.sh" ]; then
    ./git-secure-push.sh "Add advanced features: search, dark mode, toast, and backend logger"
else
    git add .
    git commit -m "Add advanced features"
    git push origin main
fi

echo "[*] Step 4: Triggering deployment..."
if [ -f "./deploy.sh" ]; then
    ./deploy.sh
fi

echo "[+] SUCCESS: All features installed, pushed, and deployed!"
