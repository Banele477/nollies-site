#!/bin/bash
set -e
cd ~/nollies

echo "[*] Injecting unique design system and interactive widgets..."

cat << 'CSS' > public/unique_style.css
/* --- UNIQUE NOLLIES CYBER-GLASS DESIGN SYSTEM --- */
:root {
    --primary-glow: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
    --glass-bg: rgba(255, 255, 255, 0.75);
    --glass-border: rgba(255, 255, 255, 0.3);
    --text-main: #0f172a;
}

body.dark-theme {
    --glass-bg: rgba(15, 23, 42, 0.85);
    --glass-border: rgba(255, 255, 255, 0.08);
    --text-main: #f8fafc;
}

body {
    background: radial-gradient(circle at top left, #f1f5f9, #e2e8f0);
    color: var(--text-main);
    font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    min-height: 100vh;
    margin: 0;
    transition: background 0.4s ease, color 0.4s ease;
}

body.dark-theme {
    background: radial-gradient(circle at top left, #090d16, #020617);
}

/* Glassmorphism Cards */
.product-card {
    background: var(--glass-bg) !important;
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border: 1px solid var(--glass-border) !important;
    border-radius: 16px !important;
    transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1), box-shadow 0.3s ease !important;
}

.product-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 30px rgba(99, 102, 241, 0.2) !important;
}

/* Floating AI Concierge Widget */
#nollies-concierge {
    position: fixed;
    bottom: 25px;
    right: 25px;
    z-index: 9999;
}

#concierge-btn {
    background: var(--primary-glow);
    color: white;
    border: none;
    width: 60px;
    height: 60px;
    border-radius: 50%;
    cursor: pointer;
    box-shadow: 0 6px 20px rgba(99, 102, 241, 0.4);
    font-size: 1.5rem;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: transform 0.2s ease;
}

#concierge-btn:hover {
    transform: scale(1.08);
}

#concierge-box {
    position: absolute;
    bottom: 75px;
    right: 0;
    width: 300px;
    background: var(--glass-bg);
    backdrop-filter: blur(16px);
    border: 1px solid var(--glass-border);
    border-radius: 14px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
    display: none;
    flex-direction: column;
    overflow: hidden;
}

.concierge-header {
    background: var(--primary-glow);
    color: white;
    padding: 12px;
    font-weight: bold;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.concierge-body {
    padding: 12px;
    font-size: 0.9rem;
    max-height: 200px;
    overflow-y: auto;
}
CSS

echo "[*] Injecting Unique UI Enhancements into public/js/features.js..."
cat << 'JSUNIQUE' >> public/js/features.js

// Inject stylesheet dynamically if not present
if (!document.getElementById('unique-theme-style')) {
    let link = document.createElement('link');
    link.id = 'unique-theme-style';
    link.rel = 'stylesheet';
    link.href = '/public/unique_style.css';
    document.head.appendChild(link);
}

// Inject Floating AI Concierge Widget UI
if (!document.getElementById('nollies-concierge')) {
    let conciergeDiv = document.createElement('div');
    conciergeDiv.id = 'nollies-concierge';
    conciergeDiv.innerHTML = `
        <div id="concierge-box">
            <div class="concierge-header">
                <span>🤖 Nollies Assistant</span>
                <span onclick="toggleConcierge()" style="cursor:pointer;">&times;</span>
            </div>
            <div class="concierge-body" id="conciergeText">
                Hi there! Welcome to Nollies. Looking for something specific or need help checking out?
            </div>
        </div>
        <button id="concierge-btn" onclick="toggleConcierge()">💬</button>
    `;
    document.body.appendChild(conciergeDiv);
}

function toggleConcierge() {
    let box = document.getElementById('concierge-box');
    box.style.display = box.style.display === 'flex' ? 'none' : 'flex';
}

// Enhanced Add to Cart with Micro-Feedback
const originalAddToCart = window.addToCart;
window.addToCart = function(id, name, price) {
    if (typeof originalAddToCart === 'function') {
        originalAddToCart(id, name, price);
    }
    showToast(`✨ Successfully secured: ${name}`);
};
JSUNIQUE

echo "[*] Pushing unique updates securely..."
if [ -f "./git-secure-push.sh" ]; then
    ./git-secure-push.sh "Make site unique: add glassmorphism, floating AI concierge, and micro-interactions"
else
    git add .
    git commit -m "Add unique design elements"
    git push origin main
fi

if [ -f "./deploy.sh" ]; then
    ./deploy.sh
fi

echo "[+] SUCCESS: Your site now features a unique glassmorphism design and interactive concierge!"
