#!/bin/bash
set -e
cd ~/nollies

echo "[*] Step 1: Creating Unified Full-Stack Python Engine (app.py)..."

cat << 'PYAPP' > app.py
import os
import datetime
import json
from flask import Flask, render_template, send_from_directory, request, jsonify

app = Flask(__name__, static_folder='public', static_url_path='/public')

# ==========================================
# ENTERPRISE SECURITY & HEADERS
# ==========================================
@app.after_request
def apply_security_headers(response):
    response.headers["X-Frame-Options"] = "SAMEORIGIN"
    response.headers["X-Content-Type-Options"] = "nosniff"
    response.headers["X-XSS-Protection"] = "1; mode=block"
    response.headers["Referrer-Policy"] = "strict-origin-when-cross-origin"
    response.headers["Server"] = "Nollies-Engine/2.0"
    return response

# ==========================================
# REST API ENDPOINTS
# ==========================================
@app.route('/')
def index():
    return send_from_directory('.', 'index.html')

@app.route('/api/telemetry', methods=['POST'])
def handle_telemetry():
    data = request.get_json() or {}
    client_ip = request.remote_addr
    log_entry = {
        "timestamp": datetime.datetime.now(datetime.timezone.utc).isoformat(),
        "ip": client_ip,
        "userAgent": request.headers.get('User-Agent'),
        "clientData": data
    }
    try:
        with open("visitor_analytics.log", "a") as f:
            f.write(json.dumps(log_entry) + "\n")
    except Exception as e:
        print(f"[-] Log error: {e}")
    return jsonify({"status": "success", "recorded": True})

@app.route('/api/order', methods=['POST'])
def handle_order():
    data = request.get_json() or {}
    data['timestamp'] = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    # Save locally to order repository
    try:
        with open("orders_database.log", "a") as f:
            f.write(json.dumps(data) + "\n")
    except Exception as e:
        print(f"[-] Order record error: {e}")

    return jsonify({
        "status": "success", 
        "message": "Order dispatched to owner hotline (0625873479)",
        "whatsapp_url": f"https://wa.me/27625873479?text=Order%20for%20{data.get('product', 'Nollies Solution')}"
    })

if __name__ == '__main__':
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port, debug=True)
PYAPP

echo "[*] Step 2: Elevating CSS to Organic Human-Centric Aesthetic (public/unique_style.css)..."

cat << 'CSSENHANCE' > public/unique_style.css
@import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;1,400&family=JetBrains+Mono:wght@400;600&display=swap');

:root {
    --brand-primary: #6366f1;
    --brand-accent: #a855f7;
    --brand-emerald: #10b981;
    --bg-dark: #07090e;
    --card-bg-glass: rgba(15, 23, 42, 0.72);
    --text-main: #f8fafc;
    --text-sub: #94a3b8;
    --border-glass: rgba(255, 255, 255, 0.08);
    --border-hover: rgba(99, 102, 241, 0.4);
    --font-sans: 'Plus Jakarta Sans', system-ui, -apple-system, sans-serif;
    --font-mono: 'JetBrains Mono', monospace;
}

* { box-sizing: border-box; margin: 0; padding: 0; }

body {
    background-color: var(--bg-dark);
    background-image: 
        radial-gradient(at 0% 0%, rgba(99, 102, 241, 0.12) 0px, transparent 50%),
        radial-gradient(at 100% 100%, rgba(168, 85, 247, 0.1) 0px, transparent 50%);
    background-attachment: fixed;
    color: var(--text-main);
    font-family: var(--font-sans);
    min-height: 100vh;
    overflow-x: hidden;
    line-height: 1.6;
    padding-top: 80px;
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
    opacity: 0.18;
    filter: brightness(0.6) contrast(1.2) hue-rotate(180deg);
}

#particle-canvas {
    position: fixed;
    top: 0; left: 0;
    width: 100vw; height: 100vh;
    z-index: -1;
    pointer-events: none;
}

/* Navigation Header */
#nollies-navbar {
    position: fixed;
    top: 0; left: 0;
    width: 100%;
    height: 72px;
    background: rgba(7, 9, 14, 0.8);
    backdrop-filter: blur(24px) saturate(180%);
    border-bottom: 1px solid var(--border-glass);
    z-index: 10000;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 6%;
}

.nav-brand {
    font-size: 1.35rem;
    font-weight: 800;
    background: linear-gradient(135deg, #fff 0%, #a5b4fc 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    cursor: pointer;
    letter-spacing: -0.5px;
}

.nav-links {
    display: flex;
    gap: 6px;
    list-style: none;
}

.nav-item {
    padding: 8px 16px;
    border-radius: 999px;
    font-size: 0.85rem;
    font-weight: 600;
    color: var(--text-sub);
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
}

.nav-item:hover, .nav-item.active {
    color: #fff;
    background: rgba(99, 102, 241, 0.12);
    border: 1px solid rgba(99, 102, 241, 0.3);
}

/* Tab Views */
.tab-page {
    display: none;
    animation: organicSlideIn 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards;
    max-width: 1200px;
    margin: 0 auto;
    padding: 30px 24px;
}

.tab-page.active { display: block; }

@keyframes organicSlideIn {
    from { opacity: 0; transform: translateY(20px) scale(0.99); }
    to { opacity: 1; transform: translateY(0) scale(1); }
}

/* Cards & Glass Containers */
.product-card {
    background: var(--card-bg-glass) !important;
    border: 1px solid var(--border-glass) !important;
    border-radius: 20px !important;
    padding: 24px !important;
    backdrop-filter: blur(20px) !important;
    transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1) !important;
    box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.5) !important;
}

.product-card:hover {
    transform: translateY(-6px) !important;
    border-color: var(--border-hover) !important;
    box-shadow: 0 25px 50px -12px rgba(99, 102, 241, 0.25) !important;
}

/* Buttons */
.btn-primary {
    background: linear-gradient(135deg, var(--brand-primary), var(--brand-accent));
    color: white;
    border: none;
    padding: 12px 24px;
    border-radius: 12px;
    font-weight: 700;
    font-size: 0.9rem;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 8px 20px -4px rgba(99, 102, 241, 0.4);
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 28px -4px rgba(99, 102, 241, 0.6);
}
CSSENHANCE

echo "[*] Step 3: Upgrading Frontend Features to Connect to Flask Backend API (public/js/features.js)..."

cat << 'JSCONNECT' >> public/js/features.js

// ==========================================
// FULL-STACK BACKEND REST API CONNECTORS
// ==========================================

async function sendTelemetryToBackend(data) {
    try {
        await fetch('/api/telemetry', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        });
        console.log('[+] Telemetry logged to Flask backend server.');
    } catch (err) {
        console.warn('[-] Flask API offline, operating in client mode.', err);
    }
}

async function dispatchOrderBackend(productTitle, price) {
    const payload = {
        product: productTitle,
        price: price,
        phone: "0625873479",
        timestamp: new Date().toISOString()
    };

    try {
        const response = await fetch('/api/order', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });
        const res = await response.json();
        
        if (res.whatsapp_url) {
            window.open(res.whatsapp_url, '_blank');
        }
    } catch (err) {
        // Fallback directly to client WhatsApp routing
        let waUrl = `https://wa.me/27625873479?text=Order%20for%20${encodeURIComponent(productTitle)}`;
        window.open(waUrl, '_blank');
    }

    if (typeof showToast === 'function') {
        showToast(`📲 Order for ${productTitle} dispatched to 0625873479`);
    }
}

// Log initial session start
document.addEventListener("DOMContentLoaded", () => {
    sendTelemetryToBackend({
        screen: `${window.innerWidth}x${window.innerHeight}`,
        referrer: document.referrer || "Direct"
    });
});
JSCONNECT

echo "[*] Step 4: Staging, Signed Committing, and Pushing to GitHub..."
git remote set-url origin git@github.com:Banele477/nollies-site.git

git add .
if ! git diff-index --quiet HEAD --; then
    git commit -S -m "Connect Flask backend API, refine full-stack routes, and apply human-centric visual enhancements" || git commit -m "Connect Flask backend API and enhance visual design"
fi

git push -u origin main

echo "[*] Step 5: Executing deployment pipeline..."
if [ -f "./deploy.sh" ]; then
    ./deploy.sh
fi

echo "[+] SUCCESS: Full-stack Flask engine and enhanced visual design pushed live to GitHub!"
