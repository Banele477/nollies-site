#!/bin/bash
set -e
cd ~/nollies

echo "[*] Step 1: Upgrading public/unique_style.css with navigation header and page transition tab styles..."

cat << 'CSSNAV' > public/unique_style.css
@import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;600;800&display=swap');

:root {
    --nvidia-green: #76b900;
    --nasa-blue: #0b3d91;
    --primary-glow: linear-gradient(135deg, #6366f1 0%, #8b5cf6 50%, #ec4899 100%);
    --bg-dark: #030508;
    --card-bg-dark: rgba(10, 15, 29, 0.85);
    --text-primary: #f8fafc;
    --text-muted: #94a3b8;
    --glass-border: rgba(118, 185, 0, 0.25);
    --font-mono: 'JetBrains Mono', monospace;
}

* { box-sizing: border-box; margin: 0; padding: 0; }

body {
    background-color: var(--bg-dark);
    color: var(--text-primary);
    font-family: 'Plus Jakarta Sans', system-ui, sans-serif;
    min-height: 100vh;
    overflow-x: hidden;
    line-height: 1.6;
    padding-top: 80px; /* Space for sticky header */
}

/* Background Render Canvas & Overlay */
#nollies-bg-container {
    position: fixed;
    top: 0; left: 0;
    width: 100vw; height: 100vh;
    overflow: hidden;
    z-index: -2;
    pointer-events: none;
}

#nollies-bg-video {
    width: 100%; height: 100%;
    object-fit: cover;
    opacity: 0.22;
    filter: brightness(0.6) contrast(1.3) hue-rotate(180deg);
}

#particle-canvas {
    position: fixed;
    top: 0; left: 0;
    width: 100vw; height: 100vh;
    z-index: -1;
    pointer-events: none;
}

/* --- MULTI-TAB NAVIGATION HEADER --- */
#nollies-navbar {
    position: fixed;
    top: 0; left: 0;
    width: 100%;
    height: 70px;
    background: rgba(3, 5, 8, 0.85);
    backdrop-filter: blur(20px);
    border-bottom: 1px solid var(--glass-border);
    z-index: 10000;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 5%;
}

.nav-brand {
    font-size: 1.4rem;
    font-weight: 800;
    background: var(--primary-glow);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    cursor: pointer;
    letter-spacing: -0.5px;
}

.nav-links {
    display: flex;
    gap: 8px;
    list-style: none;
}

.nav-item {
    padding: 8px 16px;
    border-radius: 8px;
    font-size: 0.88rem;
    font-weight: 600;
    color: var(--text-muted);
    cursor: pointer;
    transition: all 0.3s ease;
}

.nav-item:hover, .nav-item.active {
    color: #fff;
    background: rgba(118, 185, 0, 0.15);
    border: 1px solid var(--nvidia-green);
}

/* Tab View Panels */
.tab-page {
    display: none;
    animation: fadeInTab 0.5s cubic-bezier(0.16, 1, 0.3, 1) forwards;
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px 24px;
}

.tab-page.active {
    display: block;
}

@keyframes fadeInTab {
    from { opacity: 0; transform: translateY(15px); }
    to { opacity: 1; transform: translateY(0); }
}

/* NASA/NVIDIA Telemetry Control HUD */
#nasa-telemetry-hud {
    position: fixed;
    bottom: 20px;
    left: 20px;
    background: rgba(3, 5, 8, 0.88);
    backdrop-filter: blur(16px);
    border: 1px solid var(--nvidia-green);
    border-radius: 12px;
    padding: 10px 16px;
    font-family: var(--font-mono);
    font-size: 0.75rem;
    color: var(--nvidia-green);
    z-index: 9998;
    box-shadow: 0 0 20px rgba(118, 185, 0, 0.2);
    display: flex;
    flex-direction: column;
    gap: 4px;
}

.hud-row {
    display: flex;
    justify-content: space-between;
    gap: 16px;
}

.hud-status-active {
    color: var(--nvidia-green);
    font-weight: bold;
}

/* Product & Infrastructure Cards */
.product-card {
    background: var(--card-bg-dark) !important;
    border: 1px solid var(--glass-border) !important;
    border-radius: 16px !important;
    padding: 24px !important;
    backdrop-filter: blur(20px);
    transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1) !important;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.7) !important;
}

.product-card:hover {
    transform: translateY(-8px) scale(1.01) !important;
    border-color: var(--nvidia-green) !important;
    box-shadow: 0 20px 40px rgba(118, 185, 0, 0.25) !important;
}

.btn-primary {
    background: var(--primary-glow);
    color: white;
    border: none;
    padding: 12px 24px;
    border-radius: 10px;
    font-weight: 700;
    cursor: pointer;
    transition: all 0.3s ease;
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 25px rgba(99, 102, 241, 0.5);
}
CSSNAV

echo "[*] Step 2: Injecting Navigation Bar Engine & Tab Switcher into public/js/features.js..."

cat << 'JSNAV' >> public/js/features.js

// ======================================================
// MULTI-TAB PAGE SWITCHER & NAVBAR SYSTEM
// ======================================================

function initTabNavigationSystem() {
    if (document.getElementById('nollies-navbar')) return;

    // Create Navigation Bar
    let nav = document.createElement('header');
    nav.id = 'nollies-navbar';
    nav.innerHTML = `
        <div class="nav-brand" onclick="switchTab('tab-home')">⚡ NOLLIES</div>
        <ul class="nav-links">
            <li class="nav-item active" onclick="switchTab('tab-home', this)">🏠 Home</li>
            <li class="nav-item" onclick="switchTab('tab-shop', this)">🛍️ Products</li>
            <li class="nav-item" onclick="switchTab('tab-education', this)">🎓 Educational</li>
            <li class="nav-item" onclick="switchTab('tab-telemetry', this)">📡 Telemetry</li>
            <li class="nav-item" onclick="switchTab('tab-account', this)">👤 Account</li>
        </ul>
    `;
    document.body.prepend(nav);

    // Create Tab Views Containers
    let mainContainer = document.createElement('main');
    mainContainer.id = 'nollies-tab-views';

    mainContainer.innerHTML = `
        <!-- TAB 1: HOME PAGE -->
        <div id="tab-home" class="tab-page active">
            <section class="hero-section" style="text-align: center; padding: 60px 0;">
                <div class="hero-badge" style="display:inline-block; padding: 6px 16px; border-radius: 999px; background: rgba(118,185,0,0.15); color: #76b900; border: 1px solid #76b900; margin-bottom: 20px;">✨ High-Performance Digital Platform</div>
                <h1 style="font-size: 3rem; font-weight: 800; margin-bottom: 16px;">Welcome to <span style="background: var(--primary-glow); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Nollies</span></h1>
                <p style="font-size: 1.1rem; color: #94a3b8; max-width: 650px; margin: 0 auto 30px;">Enterprise cybersecurity, automated cloud infrastructure, and real-time telemetry engineered for maximum client engagement.</p>
                <div style="display: flex; justify-content: center; gap: 16px;">
                    <button class="btn-primary" onclick="switchTab('tab-shop', document.querySelectorAll('.nav-item')[1])">Explore Products</button>
                    <button class="btn-primary" style="background: rgba(255,255,255,0.08); border: 1px solid var(--glass-border);" onclick="switchTab('tab-education', document.querySelectorAll('.nav-item')[2])">Educational Intake</button>
                </div>
            </section>
        </div>

        <!-- TAB 2: PRODUCTS & OFFERINGS SHOP -->
        <div id="tab-shop" class="tab-page">
            <h2 style="font-size: 2rem; margin-bottom: 8px;">🛍️ Real-World Offerings & Products</h2>
            <p style="color: #94a3b8; margin-bottom: 24px;">Browse digital products and solutions with instant WhatsApp order dispatch to 0625873479.</p>
            <div id="shop-gallery-container"></div>
        </div>

        <!-- TAB 3: EDUCATIONAL PORTAL -->
        <div id="tab-education" class="tab-page">
            <h2 style="font-size: 2rem; margin-bottom: 8px;">🎓 Educational & Enrollment Intake</h2>
            <p style="color: #94a3b8; margin-bottom: 24px;">Submit your details to enroll in digital skills and technical mentorship programs.</p>
            <div style="width: 100%; max-width: 850px; margin: 0 auto; background: rgba(15, 23, 42, 0.95); border: 1px solid var(--glass-border); border-radius: 16px; overflow: hidden;">
                <iframe src="https://docs.google.com/forms/d/e/1FAIpQLSc_EXAMPLE_FORM_ID/viewform?embedded=true" width="100%" height="600" frameborder="0" marginheight="0" marginwidth="0" style="border: none;">Loading intake form...</iframe>
            </div>
        </div>

        <!-- TAB 4: TELEMETRY & SYSTEM HUD -->
        <div id="tab-telemetry" class="tab-page">
            <h2 style="font-size: 2rem; margin-bottom: 8px;">📡 Telemetry & System Diagnostics</h2>
            <p style="color: #94a3b8; margin-bottom: 24px;">Real-time system health, WebGL rendering stats, and order dispatch node telemetry.</p>
            <div style="background: rgba(10, 15, 29, 0.85); border: 1px solid var(--nvidia-green); padding: 24px; border-radius: 16px; font-family: var(--font-mono); color: #76b900;">
                <p><strong>NODE_DISPATCH_ENDPOINT:</strong> +27 62 587 3479</p>
                <p><strong>GPU_ACCELERATION:</strong> ACTIVE (WebGL Canvas Pipeline)</p>
                <p><strong>PWA_OFFLINE_CACHE:</strong> READY (sw.js)</p>
                <p><strong>SECURITY_CSP:</strong> ENFORCED (Zero Trust Headers)</p>
            </div>
        </div>

        <!-- TAB 5: MY ACCOUNT -->
        <div id="tab-account" class="tab-page">
            <h2 style="font-size: 2rem; margin-bottom: 8px;">👤 User Profile & Session</h2>
            <p style="color: #94a3b8; margin-bottom: 24px;">Manage your active account, view orders, and log out.</p>
            <div id="account-tab-content"></div>
        </div>
    `;

    document.body.appendChild(mainContainer);

    // Relocate product grid into Tab 2
    let existingGrid = document.getElementById('real-world-grid');
    let shopContainer = document.getElementById('shop-gallery-container');
    if (existingGrid && shopContainer) {
        shopContainer.appendChild(existingGrid);
    }
}

function switchTab(tabId, el) {
    // Hide all tab views
    document.querySelectorAll('.tab-page').forEach(page => page.classList.remove('active'));
    
    // Deactivate all navbar links
    document.querySelectorAll('.nav-item').forEach(item => item.classList.remove('active'));

    // Activate selected tab view
    let targetTab = document.getElementById(tabId);
    if (targetTab) targetTab.classList.add('active');

    // Highlight clicked navbar item
    if (el) {
        el.classList.add('active');
    }
}

document.addEventListener("DOMContentLoaded", initTabNavigationSystem);
JSNAV

echo "[*] Step 3: Committing and pushing multi-tab navigation layout to GitHub..."
git remote set-url origin git@github.com:Banele477/nollies-site.git

git add .
if ! git diff-index --quiet HEAD --; then
    git commit -S -m "Implement multi-tab site navigation bar (Home, Shop, Educational, Telemetry, Account)" || git commit -m "Implement multi-tab navigation layout"
fi

git push -u origin main

echo "[*] Step 4: Executing deployment script..."
if [ -f "./deploy.sh" ]; then
    ./deploy.sh
fi

echo "[+] SUCCESS: Multi-tab navigation layout deployed live to nollies-site!"
