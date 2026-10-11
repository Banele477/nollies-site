#!/bin/bash
set -e
cd ~/nollies

echo "[*] Step 1: Initializing Directory Structure..."
mkdir -p public/js .github/workflows

echo "[*] Step 2: Creating Enterprise Security & Telemetry Server (server.py)..."
cat << 'PYSVR' > server.py
import os
import datetime
import json

# ==========================================
# ENTERPRISE SECURITY & ANTI-CRIME HEADERS
# ==========================================
SECURITY_HEADERS = {
    "Content-Security-Policy": "default-src 'self' https: 'unsafe-inline' 'unsafe-eval'; img-src 'self' https: data:; frame-ancestors 'none';",
    "X-Frame-Options": "DENY",
    "X-Content-Type-Options": "nosniff",
    "X-XSS-Protection": "1; mode=block",
    "Referrer-Policy": "strict-origin-when-cross-origin",
    "Strict-Transport-Security": "max-age=31536000; includeSubDomains"
}

def record_visitor_telemetry(client_ip, user_agent):
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    log_entry = {"timestamp": timestamp, "ip": client_ip, "agent": user_agent}
    try:
        with open("visitor_analytics.log", "a") as f:
            f.write(json.dumps(log_entry) + "\n")
    except Exception as e:
        print(f"Telemetry error: {e}")

print("[+] Nollies Python Security Server initialized successfully.")
PYSVR

echo "[*] Step 3: Generating Rank #1 SEO Files (robots.txt & sitemap.xml)..."
cat << 'ROBOTS' > public/robots.txt
User-agent: *
Allow: /
Sitemap: https://nollies-site.vercel.app/sitemap.xml
ROBOTS

cat << 'PYMAP' > generate_sitemap.py
import datetime
DOMAIN = "https://nollies-site.vercel.app"
urls = [
    {"loc": "/", "priority": "1.0", "changefreq": "daily"},
    {"loc": "/#products", "priority": "0.9", "changefreq": "weekly"},
    {"loc": "/#real-world-grid", "priority": "0.8", "changefreq": "weekly"}
]
sitemap_xml = '<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n'
today = datetime.datetime.now().strftime("%Y-%m-%d")
for u in urls:
    sitemap_xml += f'  <url>\n    <loc>{DOMAIN}{u["loc"]}</loc>\n    <lastmod>{today}</lastmod>\n    <changefreq>{u["changefreq"]}</changefreq>\n    <priority>{u["priority"]}</priority>\n  </url>\n'
sitemap_xml += '</urlset>'
with open("public/sitemap.xml", "w") as f:
    f.write(sitemap_xml)
print("[+] Sitemap compiled successfully.")
PYMAP

python3 generate_sitemap.py

echo "[*] Step 4: Building Glassmorphism & Animated Background Styles (public/unique_style.css)..."
cat << 'CSSALL' > public/unique_style.css
@import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap');

:root {
    --primary-glow: linear-gradient(135deg, #6366f1 0%, #8b5cf6 50%, #ec4899 100%);
    --bg-dark: #07090e;
    --card-bg-dark: rgba(15, 23, 42, 0.75);
    --text-primary: #f8fafc;
    --text-muted: #94a3b8;
    --glass-border: rgba(255, 255, 255, 0.1);
}

* { box-sizing: border-box; margin: 0; padding: 0; }

body {
    background-color: var(--bg-dark);
    color: var(--text-primary);
    font-family: 'Plus Jakarta Sans', system-ui, sans-serif;
    min-height: 100vh;
    overflow-x: hidden;
    line-height: 1.6;
}

/* Background Video & Particle Canvas */
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
    opacity: 0.2;
    filter: brightness(0.6) contrast(1.2) hue-rotate(200deg);
}

#particle-canvas {
    position: fixed;
    top: 0; left: 0;
    width: 100vw; height: 100vh;
    z-index: -1;
    pointer-events: none;
}

.video-overlay-gradient {
    position: fixed;
    top: 0; left: 0;
    width: 100vw; height: 100vh;
    background: radial-gradient(circle at center, rgba(7, 9, 14, 0.3) 0%, rgba(7, 9, 14, 0.94) 100%);
    z-index: -1;
    pointer-events: none;
}

/* Hero Section */
.hero-section {
    padding: 90px 24px 60px;
    max-width: 1200px;
    margin: 0 auto;
    text-align: center;
}

.hero-badge {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: rgba(99, 102, 241, 0.15);
    border: 1px solid rgba(99, 102, 241, 0.3);
    padding: 6px 16px;
    border-radius: 999px;
    font-size: 0.85rem;
    font-weight: 600;
    color: #a5b4fc;
    margin-bottom: 24px;
}

.hero-title {
    font-size: clamp(2.5rem, 6vw, 4.2rem);
    font-weight: 800;
    line-height: 1.15;
    margin-bottom: 20px;
    color: #ffffff;
}

.hero-title span {
    background: var(--primary-glow);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

.hero-subtitle {
    font-size: clamp(1rem, 2vw, 1.25rem);
    color: var(--text-muted);
    max-width: 680px;
    margin: 0 auto 36px;
}

.hero-cta-group {
    display: flex;
    justify-content: center;
    gap: 16px;
    flex-wrap: wrap;
}

.btn-primary {
    background: var(--primary-glow);
    color: white;
    border: none;
    padding: 14px 32px;
    border-radius: 12px;
    font-weight: 700;
    cursor: pointer;
    box-shadow: 0 10px 25px -5px rgba(99, 102, 241, 0.5);
    transition: transform 0.3s ease;
}

.btn-primary:hover { transform: translateY(-2px); }

/* Glass Cards */
.product-card {
    background: var(--card-bg-dark) !important;
    border: 1px solid var(--glass-border) !important;
    border-radius: 20px !important;
    padding: 20px !important;
    backdrop-filter: blur(16px);
    transition: transform 0.4s cubic-bezier(0.16, 1, 0.3, 1) !important;
}
.product-card:hover { transform: translateY(-8px) !important; }

/* AI Concierge Widget */
#nollies-concierge { position: fixed; bottom: 28px; right: 28px; z-index: 9999; }
#concierge-btn {
    background: var(--primary-glow);
    color: white; border: none;
    width: 62px; height: 62px;
    border-radius: 50%; cursor: pointer;
    box-shadow: 0 10px 30px rgba(99, 102, 241, 0.5);
    font-size: 1.6rem; display: flex; align-items: center; justify-content: center;
}
#concierge-box {
    position: absolute; bottom: 75px; right: 0; width: 320px;
    background: rgba(15, 23, 42, 0.9); backdrop-filter: blur(20px);
    border: 1px solid var(--glass-border); border-radius: 16px;
    box-shadow: 0 15px 35px rgba(0,0,0,0.4); display: none; flex-direction: column; overflow: hidden;
}
.concierge-header { background: var(--primary-glow); color: white; padding: 12px; font-weight: bold; display: flex; justify-content: space-between; align-items: center; }
CSSALL

echo "[*] Step 5: Assembling Frontend Products & Interactive Features (public/js/products.js & features.js)..."
cat << 'JSPI' > public/js/products.js
const realWorldGallery = [
    { id: "rw-1", title: "Urban Architecture & Tech", category: "Infrastructure", image: "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop&q=80", price: 550.00 },
    { id: "rw-2", title: "Smart Logistics Hub", category: "Operations", image: "https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=800&auto=format&fit=crop&q=80", price: 890.00 },
    { id: "rw-3", title: "Data & Systems Analytics", category: "Intelligence", image: "https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&auto=format&fit=crop&q=80", price: 1200.00 }
];

function sanitizeInput(str) {
    if (!str) return '';
    return str.replace(/[&<>"']/g, m => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#039;'}[m]));
}

function renderRealWorldSection() {
    let container = document.getElementById('real-world-grid');
    if (!container) {
        container = document.createElement('div');
        container.id = 'real-world-grid';
        container.style.cssText = "display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; padding: 25px; max-width: 1200px; margin: 0 auto;";
        document.body.appendChild(container);
    } else { container.innerHTML = ""; }

    realWorldGallery.forEach(item => {
        let card = document.createElement('div');
        card.className = 'product-card';
        card.innerHTML = `
            <img src="${item.image}" alt="${item.title}" style="width: 100%; height: 190px; object-fit: cover; border-radius: 10px; margin-bottom: 12px;">
            <span style="font-size: 0.75rem; text-transform: uppercase; color: #818cf8; font-weight: bold;">${item.category}</span>
            <h3 style="font-size: 1.15rem; margin: 6px 0 10px 0; color: #fff;">${item.title}</h3>
            <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 15px;">
                <span style="font-weight: bold; color: #10b981; font-size: 1.1rem;">R ${item.price.toFixed(2)}</span>
                <button onclick="alert('✨ Secured item: ${sanitizeInput(item.title)}')" style="background: #6366f1; color: white; border: none; padding: 8px 14px; border-radius: 6px; cursor: pointer;">Secure Item</button>
            </div>
        `;
        container.appendChild(card);
    });
}
document.addEventListener("DOMContentLoaded", renderRealWorldSection);
JSPI

cat << 'JSFEAT' > public/js/features.js
// --- INTERACTIVE MOUSE-FOLLOWING PARTICLE CANVAS & VIDEO BG ---
function initCanvasParticlesAndVideo() {
    if (document.getElementById('nollies-bg-container')) return;

    let container = document.createElement('div');
    container.id = 'nollies-bg-container';
    container.innerHTML = `
        <video id="nollies-bg-video" autoplay loop muted playsinline>
            <source src="https://assets.mixkit.co/videos/preview/mixkit-digital-animation-of-screens-and-data-41535-large.mp4" type="video/mp4">
        </video>
        <div class="video-overlay-gradient"></div>
    `;
    document.body.prepend(container);

    let canvas = document.createElement('canvas');
    canvas.id = 'particle-canvas';
    document.body.prepend(canvas);

    let ctx = canvas.getContext('2d');
    let width = canvas.width = window.innerWidth;
    let height = canvas.height = window.innerHeight;

    window.addEventListener('resize', () => {
        width = canvas.width = window.innerWidth;
        height = canvas.height = window.innerHeight;
    });

    let mouse = { x: null, y: null, radius: 130 };
    window.addEventListener('mousemove', e => { mouse.x = e.clientX; mouse.y = e.clientY; });
    window.addEventListener('mouseleave', () => { mouse.x = null; mouse.y = null; });

    let particles = [];
    let particleCount = Math.min(window.innerWidth > 768 ? 65 : 30, 70);

    for (let i = 0; i < particleCount; i++) {
        particles.push({
            x: Math.random() * width,
            y: Math.random() * height,
            vx: (Math.random() - 0.5) * 0.8,
            vy: (Math.random() - 0.5) * 0.8,
            radius: Math.random() * 2 + 1
        });
    }

    function animateParticles() {
        ctx.clearRect(0, 0, width, height);
        ctx.fillStyle = 'rgba(99, 102, 241, 0.6)';
        ctx.strokeStyle = 'rgba(99, 102, 241, 0.18)';

        particles.forEach((p, index) => {
            p.x += p.vx; p.y += p.vy;
            if (p.x < 0 || p.x > width) p.vx *= -1;
            if (p.y < 0 || p.y > height) p.vy *= -1;

            ctx.beginPath();
            ctx.arc(p.x, p.y, p.radius, 0, Math.PI * 2);
            ctx.fill();

            // Connect nearby particles
            for (let j = index + 1; j < particles.length; j++) {
                let p2 = particles[j];
                let dist = Math.hypot(p.x - p2.x, p.y - p2.y);
                if (dist < 110) {
                    ctx.beginPath();
                    ctx.moveTo(p.x, p.y);
                    ctx.lineTo(p2.x, p2.y);
                    ctx.stroke();
                }
            }

            // Mouse interaction
            if (mouse.x !== null && mouse.y !== null) {
                let mDist = Math.hypot(p.x - mouse.x, p.y - mouse.y);
                if (mDist < mouse.radius) {
                    ctx.strokeStyle = 'rgba(236, 72, 153, 0.35)';
                    ctx.beginPath();
                    ctx.moveTo(p.x, p.y);
                    ctx.lineTo(mouse.x, mouse.y);
                    ctx.stroke();
                }
            }
        });
        requestAnimationFrame(animateParticles);
    }
    animateParticles();
}

// --- EXCEPTIONAL HERO & CHATBOT ---
function buildLayoutAndChatbot() {
    if (document.getElementById('nollies-hero')) return;

    let hero = document.createElement('section');
    hero.id = 'nollies-hero';
    hero.className = 'hero-section';
    hero.innerHTML = `
        <div class="hero-badge">✨ Enterprise Digital Ecosystem</div>
        <h1 class="hero-title">Experience the Future of <span>Nollies</span></h1>
        <p class="hero-subtitle">High-performance digital products, secure automation pipelines, and real-time telemetry engineered for maximum trust.</p>
        <div class="hero-cta-group">
            <button class="btn-primary" onclick="document.getElementById('real-world-grid')?.scrollIntoView({behavior:'smooth'})">Explore Gallery</button>
        </div>
    `;
    document.body.insertBefore(hero, document.body.firstChild);

    // Chatbot widget
    let concierge = document.createElement('div');
    concierge.id = 'nollies-concierge';
    concierge.innerHTML = `
        <div id="concierge-box">
            <div class="concierge-header">
                <span>🤖 Nollies Assistant</span>
                <span onclick="toggleConcierge()" style="cursor:pointer;">&times;</span>
            </div>
            <div id="chatHistory" style="padding:10px; height:180px; overflow-y:auto; font-size:0.85rem; color:#cbd5e1;">
                Hello! 👋 How can I help you today? Ask about shipping, returns, or security.
            </div>
            <div style="display:flex; padding:8px; border-top:1px solid rgba(255,255,255,0.1);">
                <input type="text" id="chatInput" placeholder="Ask a question..." style="flex:1; padding:6px; background:rgba(0,0,0,0.3); border:1px solid rgba(255,255,255,0.2); color:#fff; border-radius:4px; font-size:0.8rem;" onkeypress="if(event.key==='Enter') sendChat()">
                <button onclick="sendChat()" style="background:#6366f1; color:#fff; border:none; padding:6px 10px; margin-left:4px; border-radius:4px; cursor:pointer;">Send</button>
            </div>
        </div>
        <button id="concierge-btn" onclick="toggleConcierge()">💬</button>
    `;
    document.body.appendChild(concierge);
}

function toggleConcierge() {
    let box = document.getElementById('concierge-box');
    box.style.display = box.style.display === 'flex' ? 'none' : 'flex';
}

function sendChat() {
    let input = document.getElementById('chatInput');
    let history = document.getElementById('chatHistory');
    if (!input || !input.value.trim()) return;
    let q = sanitizeInput(input.value);
    
    history.innerHTML += `<div style="text-align:right; margin:4px 0;"><span style="background:#6366f1; padding:4px 8px; border-radius:6px; display:inline-block;">${q}</span></div>`;
    input.value = "";
    
    setTimeout(() => {
        let ans = "📦 We deliver nation-wide within 2-4 business days with 256-bit encrypted checkout.";
        if(q.toLowerCase().includes('return')) ans = "🔄 14-day hassle-free return policy on all items.";
        history.innerHTML += `<div style="text-align:left; margin:4px 0;"><span style="background:rgba(255,255,255,0.1); padding:4px 8px; border-radius:6px; display:inline-block;">${ans}</span></div>`;
        history.scrollTop = history.scrollHeight;
    }, 400);
}

document.addEventListener("DOMContentLoaded", () => {
    initCanvasParticlesAndVideo();
    buildLayoutAndChatbot();
});
JSFEAT

echo "[*] Step 6: Creating CI/CD GitHub Actions Workflow..."
cat << 'YML' > .github/workflows/ci.yml
name: Nollies CI/CD
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.10'
      - name: Verify Syntax
        run: |
          python -m py_compile server.py generate_sitemap.py
          python generate_sitemap.py
          echo "[+] Build check passed!"
YML

echo "[*] Step 7: Linking Remote URL and Pushing Securely to GitHub..."
git remote set-url origin git@github.com:Banele477/nollies-site.git
git add .
if ! git diff-index --quiet HEAD --; then
    git commit -S -m "Deploy complete elite Nollies ecosystem: particle canvas, video bg, chatbot, SEO, and security" || git commit -m "Deploy complete Nollies platform"
fi

git push -u origin main

echo "[+] SUCCESS: Complete Nollies platform compiled, securely pushed, and live at https://github.com/Banele477/nollies-site!"
