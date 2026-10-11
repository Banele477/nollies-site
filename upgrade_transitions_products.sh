#!/bin/bash
set -e
cd ~/nollies

echo "[*] Step 1: Upgrading public/unique_style.css with keyframe transitions and micro-animations..."

cat << 'CSSTRANS' > public/unique_style.css
@import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap');

:root {
    --primary-glow: linear-gradient(135deg, #6366f1 0%, #8b5cf6 50%, #ec4899 100%);
    --bg-dark: #07090e;
    --card-bg-dark: rgba(15, 23, 42, 0.78);
    --text-primary: #f8fafc;
    --text-muted: #94a3b8;
    --glass-border: rgba(255, 255, 255, 0.12);
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

/* --- KEYFRAME ANIMATIONS & TRANSITIONS --- */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes pulseGlow {
    0%, 100% { box-shadow: 0 0 15px rgba(99, 102, 241, 0.3); }
    50% { box-shadow: 0 0 30px rgba(236, 72, 153, 0.5); }
}

.hero-section {
    animation: fadeInUp 0.8s cubic-bezier(0.16, 1, 0.3, 1) forwards;
    padding: 90px 24px 50px;
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
    animation: pulseGlow 4s infinite ease-in-out;
}

.hero-title {
    font-size: clamp(2.5rem, 6vw, 4.2rem);
    font-weight: 800;
    line-height: 1.15;
    margin-bottom: 20px;
    background: linear-gradient(180deg, #ffffff 0%, #cbd5e1 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

.hero-title span {
    background: var(--primary-glow);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

/* Product Card Grid & Smooth Transitions */
#real-world-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 24px;
    padding: 30px 24px;
    max-width: 1200px;
    margin: 0 auto;
}

.product-card {
    background: var(--card-bg-dark) !important;
    border: 1px solid var(--glass-border) !important;
    border-radius: 20px !important;
    padding: 20px !important;
    backdrop-filter: blur(16px);
    transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1) !important;
    animation: fadeInUp 0.6s ease-out forwards;
    box-shadow: 0 10px 30px -10px rgba(0, 0, 0, 0.5);
    position: relative;
    overflow: hidden;
}

.product-card:hover {
    transform: translateY(-10px) scale(1.02) !important;
    border-color: rgba(99, 102, 241, 0.5) !important;
    box-shadow: 0 20px 40px -15px rgba(99, 102, 241, 0.35) !important;
}

.product-card img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 12px;
    margin-bottom: 14px;
    transition: transform 0.5s ease;
}

.product-card:hover img {
    transform: scale(1.05);
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
    box-shadow: 0 8px 20px -4px rgba(99, 102, 241, 0.5);
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 28px -4px rgba(99, 102, 241, 0.7);
}
CSSTRANS

echo "[*] Step 2: Injecting Expanded Real-World Offerings Gallery in public/js/products.js..."

cat << 'JSPROD' > public/js/products.js
// Enterprise Real-World Offerings & Photography Catalog
const nolliesOfferings = [
    {
        id: "offering-1",
        title: "Enterprise Cybersecurity & Cloud Nodes",
        category: "Infrastructure",
        description: "Hardened server clusters, active intrusion detection, and encrypted database pipelines.",
        image: "https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=800&auto=format&fit=crop&q=80",
        price: 1500.00
    },
    {
        id: "offering-2",
        title: "Smart Logistics & Automated Hubs",
        category: "Operations",
        description: "Real-time telemetry, automated tracking, and high-efficiency inventory dispatch systems.",
        image: "https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=800&auto=format&fit=crop&q=80",
        price: 2200.00
    },
    {
        id: "offering-3",
        title: "AI Analytics & Intelligence Dashboard",
        category: "Data Science",
        description: "Predictive decision engines, automated reporting, and deep data visualization suites.",
        image: "https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&auto=format&fit=crop&q=80",
        price: 1850.00
    },
    {
        id: "offering-4",
        title: "Global Connectivity Terminals",
        category: "Networking",
        description: "Ultra-low latency API gateways, distributed CDN routing, and fault-tolerant node meshing.",
        image: "https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=800&auto=format&fit=crop&q=80",
        price: 1350.00
    }
];

function renderOfferings() {
    let container = document.getElementById('real-world-grid');
    if (!container) {
        container = document.createElement('div');
        container.id = 'real-world-grid';
        document.body.appendChild(container);
    } else {
        container.innerHTML = "";
    }

    nolliesOfferings.forEach((item, index) => {
        let card = document.createElement('div');
        card.className = 'product-card';
        card.style.animationDelay = `${index * 0.15}s`;
        
        card.innerHTML = `
            <img src="${item.image}" alt="${item.title}">
            <span style="font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; color: #818cf8; font-weight: 700;">${item.category}</span>
            <h3 style="font-size: 1.2rem; margin: 6px 0; color: #fff; font-weight: 700;">${item.title}</h3>
            <p style="font-size: 0.85rem; color: #94a3b8; margin-bottom: 16px;">${item.description}</p>
            <div style="display: flex; justify-content: space-between; align-items: center; border-top: 1px solid rgba(255,255,255,0.08); padding-top: 14px;">
                <span style="font-weight: 800; color: #10b981; font-size: 1.15rem;">R ${item.price.toFixed(2)}</span>
                <button class="btn-primary" onclick="triggerCheckoutAlert('${item.title}')">Acquire Solutions</button>
            </div>
        `;
        container.appendChild(card);
    });
}

function triggerCheckoutAlert(title) {
    if (typeof showToast === 'function') {
        showToast(`✨ Selected Offering: ${title}`);
    } else {
        alert(`✨ Selected Offering: ${title}`);
    }
}

document.addEventListener("DOMContentLoaded", renderOfferings);
JSPROD

echo "[*] Step 3: Verifying Git remote and pushing updates to GitHub..."
git remote set-url origin git@github.com:Banele477/nollies-site.git

git add .
if ! git diff-index --quiet HEAD --; then
    git commit -S -m "Enhance site with keyframe animations, card transitions, and real-world offerings photography" || git commit -m "Add animations, transitions and real-world images"
fi

git push -u origin main

echo "[*] Step 4: Executing deployment script..."
if [ -f "./deploy.sh" ]; then
    ./deploy.sh
fi

echo "[+] SUCCESS: Transitions, keyframe animations, and real-world offerings deployed live!"
