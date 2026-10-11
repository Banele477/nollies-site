#!/bin/bash
set -e
cd ~/nollies

echo "[*] Step 1: Upgrading public/js/products.js with expanded real-world imagery and location tracing..."

mkdir -p public/js

cat << 'JSCORE' > public/js/products.js
// Expanded Real-World Photography Pool
const realWorldGallery = [
    {
        id: "rw-1",
        title: "Urban Architecture & Tech",
        category: "Infrastructure",
        image: "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop&q=80",
        price: 550.00
    },
    {
        id: "rw-2",
        title: "Smart Logistics Hub",
        category: "Operations",
        image: "https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=800&auto=format&fit=crop&q=80",
        price: 890.00
    },
    {
        id: "rw-3",
        title: "Data & Systems Analytics",
        category: "Intelligence",
        image: "https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&auto=format&fit=crop&q=80",
        price: 1200.00
    },
    {
        id: "rw-4",
        title: "Global Connectivity Terminal",
        category: "Networking",
        image: "https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=800&auto=format&fit=crop&q=80",
        price: 750.00
    }
];

// Automated Location & Telemetry Tracing System
async function initVisitorTelemetry() {
    try {
        let response = await fetch('https://ipapi.co/json/');
        let data = await response.json();
        
        console.log(`[Telemetry] Visitor located in ${data.city}, ${data.country_name} (${data.ip})`);
        
        // Display a subtle regional telemetry badge on the UI if container exists
        let badge = document.getElementById('telemetry-badge');
        if (badge) {
            badge.innerText = `📍 Connected from ${data.city}, ${data.country_name}`;
        }
    } catch (err) {
        console.log("[Telemetry] Regional lookup skipped or restricted.");
    }
}

function renderRealWorldSection() {
    let container = document.getElementById('real-world-grid');
    if (!container) {
        container = document.createElement('div');
        container.id = 'real-world-grid';
        container.style.cssText = "display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; padding: 25px; margin-top: 20px;";
        document.body.appendChild(container);
    } else {
        container.innerHTML = "";
    }

    realWorldGallery.forEach(item => {
        let card = document.createElement('div');
        card.className = 'product-card';
        card.style.cssText = "background: var(--glass-bg, #fff); border: 1px solid var(--glass-border, #ddd); border-radius: 14px; padding: 16px; box-shadow: 0 8px 20px rgba(0,0,0,0.08); text-align: left;";
        
        card.innerHTML = `
            <img src="${item.image}" alt="${item.title}" style="width: 100%; height: 190px; object-fit: cover; border-radius: 10px; margin-bottom: 12px;">
            <span style="font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; color: #6366f1; font-weight: bold;">${item.category}</span>
            <h3 style="font-size: 1.15rem; margin: 6px 0 10px 0;">${item.title}</h3>
            <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 15px;">
                <span style="font-weight: bold; color: #10b981; font-size: 1.1rem;">R ${item.price.toFixed(2)}</span>
                <button onclick="addToCart('${item.id}', '${item.title}', ${item.price})" style="background: #6366f1; color: white; border: none; padding: 8px 14px; border-radius: 6px; cursor: pointer; font-weight: 500;">Secure Item</button>
            </div>
        `;
        container.appendChild(card);
    });
}

document.addEventListener("DOMContentLoaded", () => {
    initVisitorTelemetry();
    renderRealWorldSection();
});
JSCORE

echo "[*] Step 2: Fixing remote URL to nollies-site and syncing..."
git remote set-url origin git@github.com:Banele477/nollies-site.git

echo "[*] Step 3: Staging, signing, and pushing securely..."
git add .
if ! git diff-index --quiet HEAD --; then
    git commit -S -m "Add expanded real-world imagery and automated IP location tracing" || git commit -m "Add real-world images and location tracing"
fi

git push -u origin main

echo "[*] Step 4: Triggering deployment script..."
if [ -f "./deploy.sh" ]; then
    ./deploy.sh
fi

echo "[+] SUCCESS: Real-world image library and location tracing deployed to nollies-site!"
