#!/data/data/com.termux/files/usr/bin/bash
set -e

cd ~/nollies
echo "🚀 Building Ultimate PWA, Accessibility Themes, and Real Imagery..."

mkdir -p public/js public/css public/icons data

# 1. Create Web App Manifest for Home Screen Installation (manifest.json)
cat > public/manifest.json << 'MANIFEST_EOF'
{
  "name": "Nollie's eNanda Hub",
  "short_name": "Nollie's",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#0f172a",
  "theme_color": "#8b5cf6",
  "icons": [
    {
      "src": "https://images.unsplash.com/photo-1547471080-7cc2caa01a7e?w=192&h=192&fit=crop",
      "sizes": "192x192",
      "type": "image/jpeg"
    },
    {
      "src": "https://images.unsplash.com/photo-1547471080-7cc2caa01a7e?w=512&h=512&fit=crop",
      "sizes": "512x512",
      "type": "image/jpeg"
    }
  ]
}
MANIFEST_EOF

# 2. Create Service Worker for Offline Usage (public/sw.js)
cat > public/sw.js << 'SW_EOF'
const CACHE_NAME = 'nollies-pwa-v1';
const ASSETS = [
  '/',
  '/index.html',
  '/js/app.js',
  '/manifest.json'
];

self.addEventListener('install', (e) => {
  e.waitUntil(
    caches.open(CACHE_NAME).then((cache) => cache.addAll(ASSETS))
  );
  self.skipWaiting();
});

self.addEventListener('activate', (e) => {
  e.waitUntil(
    caches.keys().then((keys) => {
      return Promise.all(
        keys.filter((key) => key !== CACHE_NAME).map((key) => caches.delete(key))
      );
    })
  );
  self.stel?.('claimClients');
});

self.addEventListener('fetch', (e) => {
  e.respondWith(
    caches.match(e.request).then((cachedResponse) => {
      return cachedResponse || fetch(e.request).catch(() => {
        if (e.request.mode === 'navigate') {
          return caches.match('/');
        }
      });
    })
  );
});
SW_EOF

# 3. Create Flask Backend Server (server.py)
cat > server.py << 'PYTHON_EOF'
"""
Nollie's Flask Enterprise Backend API
"""
import os
import json
import time
from flask import Flask, jsonify, request, send_from_directory

app = Flask(__name__, static_folder="public", static_url_path="")

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_DIR = os.path.join(BASE_DIR, "data")
ORDERS_FILE = os.path.join(DATA_DIR, "orders.json")
ADMIN_KEY = os.environ.get("ADMIN_KEY", "mysecret")

def load_orders():
    try:
        if os.path.exists(ORDERS_FILE):
            with open(ORDERS_FILE, "r", encoding="utf-8") as f:
                return json.load(f)
    except Exception:
        pass
    return []

def save_orders(orders):
    os.makedirs(DATA_DIR, exist_ok=True)
    temp_file = ORDERS_FILE + ".tmp"
    with open(temp_file, "w", encoding="utf-8") as f:
        json.dump(orders, f, ensure_ascii=False, indent=2)
    os.replace(temp_file, ORDERS_FILE)

@app.route("/")
def index():
    return send_from_directory(app.static_folder, "index.html")

@app.route("/manifest.json")
def manifest():
    return send_from_directory(app.static_folder, "manifest.json")

@app.route("/sw.js")
def sw():
    return send_from_directory(app.static_folder, "sw.js")

@app.route("/api/health", methods=["GET"])
def health():
    return jsonify({"status": "online", "app": "Nollie's Ultimate PWA API"})

@app.route("/api/orders", methods=["GET"])
def get_orders():
    if request.headers.get("X-Admin-Key", "") != ADMIN_KEY:
        return jsonify({"error": "Unauthorized"}), 401
    orders = load_orders()
    return jsonify({"total_orders": len(orders), "orders": list(reversed(orders))})

@app.route("/api/order", methods=["POST"])
def create_order():
    try:
        data = request.get_json(force=True)
    except Exception:
        return jsonify({"error": "Invalid JSON"}), 400

    new_order = {
        "id": int(time.time() * 1000),
        "received": time.strftime("%Y-%m-%d %H:%M:%S"),
        "status": "Pending",
        "name": str(data.get("name", "eNanda Customer"))[:100],
        "phone": str(data.get("phone", "WhatsApp"))[:50],
        "total": float(data.get("total", 0)),
        "items": data.get("items", [])
    }
    orders = load_orders()
    orders.append(new_order)
    save_orders(orders)
    return jsonify({"success": True, "order_id": new_order["id"]})

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    print(f"🚀 Nollie's Ultimate PWA Server running on http://localhost:{port}")
    app.run(host="0.0.0.0", port=port, debug=False)
PYTHON_EOF

# 4. Create public/index.html with Accessibility Theme Picker & Real Imagery
cat > public/index.html << 'HTML_EOF'
<!DOCTYPE html>
<html lang="en" data-theme="default">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Nollie's | eNanda Community Essentials & PWA</title>
    <link rel="manifest" href="/manifest.json">
    <meta name="theme-color" content="#8b5cf6">
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; transition: background 0.3s, color 0.3s; }
        
        /* Theme Palettes for Accessibility & Visibility */
        [data-theme="default"] { background-color: #0f172a; color: #f8fafc; }
        [data-theme="high-contrast"] { background-color: #000000; color: #ffff00; }
        [data-theme="sepia"] { background-color: #fef3c7; color: #451a03; }
        [data-theme="light"] { background-color: #ffffff; color: #0f172a; }

        .rainbow-text {
            background: linear-gradient(90deg, #ef4444, #f97316, #eab308, #10b981, #06b6d4, #6366f1, #a855f7);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .rainbow-bg {
            background: linear-gradient(135deg, #ef4444, #f97316, #eab308, #10b981, #06b6d4, #6366f1, #a855f7);
        }
    </style>
</head>
<body class="min-h-screen pb-24">

    <div class="h-1.5 rainbow-bg w-full fixed top-0 z-50"></div>

    <!-- Header Navigation -->
    <header class="sticky top-1.5 z-40 bg-slate-900/95 backdrop-blur-md border-b border-slate-800 px-4 py-3 flex justify-between items-center shadow-lg">
        <div class="flex items-center space-x-2">
            <span class="text-2xl font-black tracking-tight text-white">Nollie's<span class="text-amber-400">.</span></span>
            <span class="rainbow-bg text-white text-[10px] font-black px-2 py-0.5 rounded-full">eNanda</span>
        </div>
        <div class="flex items-center space-x-2">
            <!-- PWA Install Button -->
            <button id="install-btn" style="display:none;" onclick="installPWA()" class="bg-amber-400 text-slate-950 font-black text-[11px] px-3 py-1.5 rounded-xl shadow-md animate-pulse">📲 Install App</button>
            <button onclick="toggleCart()" class="relative flex items-center rainbow-bg text-white text-xs font-black px-4 py-2 rounded-full shadow-lg">
                <span>🛒 Cart</span>
                <span id="cart-count" class="ml-2 bg-white text-slate-900 text-[10px] rounded-full h-5 w-5 flex items-center justify-center font-black">0</span>
            </button>
        </div>
    </header>

    <!-- Accessibility Theme Selector Bar (For users who can't see properly) -->
    <div class="bg-slate-800 border-b border-slate-700 py-2 px-3 flex justify-between items-center text-xs max-w-2xl mx-auto">
        <span class="font-bold text-amber-400">👁️ Vision & Color Mode:</span>
        <div class="flex gap-1.5">
            <button onclick="setTheme('default')" class="px-2.5 py-1 rounded-lg bg-purple-600 font-bold text-white text-[10px]">Standard</button>
            <button onclick="setTheme('high-contrast')" class="px-2.5 py-1 rounded-lg bg-black text-yellow-300 border border-yellow-300 font-bold text-[10px]">High Contrast</button>
            <button onclick="setTheme('sepia')" class="px-2.5 py-1 rounded-lg bg-amber-200 text-amber-950 font-bold text-[10px]">Warm Sepia</button>
            <button onclick="setTheme('light')" class="px-2.5 py-1 rounded-lg bg-white text-slate-900 font-bold text-[10px]">Clean Light</button>
        </div>
    </div>

    <!-- Location & Delivery Banner -->
    <div class="bg-amber-400 text-slate-950 text-xs font-black text-center py-2 px-4 flex justify-between items-center max-w-2xl mx-auto shadow-md">
        <span>📍 Based in eNanda, Durban</span>
        <span>🚚 Fixed R30 Delivery Fee</span>
    </div>

    <!-- Navigation Tabs -->
    <nav class="flex bg-slate-800/90 backdrop-blur-md border border-slate-700 max-w-2xl mx-auto my-3 rounded-2xl shadow-xl p-1.5 gap-1 overflow-x-auto">
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-black rainbow-bg text-white whitespace-nowrap text-center" onclick="switchTab('shop', this)">🛍️ Shop</button>
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-bold text-slate-300 hover:text-white whitespace-nowrap text-center" onclick="switchTab('specials', this)">🔥 Combos</button>
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-bold text-slate-300 hover:text-white whitespace-nowrap text-center" onclick="switchTab('analytics', this)">📊 Telemetry</button>
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-bold text-slate-300 hover:text-white whitespace-nowrap text-center" onclick="switchTab('ai', this)">🤖 AI Help</button>
    </nav>

    <!-- Main Container -->
    <main class="max-w-2xl mx-auto px-4">

        <!-- SHOP TAB -->
        <section id="tab-shop" class="tab-content block space-y-4">
            <div class="relative overflow-hidden rounded-2xl border border-slate-700 p-5 shadow-2xl bg-slate-800/80 backdrop-blur-sm">
                <h1 class="text-xl font-black mb-1 rainbow-text">Community-Tested Quality Products</h1>
                <p class="text-xs text-slate-300">Browse real product stock below. Tap '+ Add to Cart' to order instantly via WhatsApp.</p>
            </div>

            <input type="text" id="search-input" placeholder="🔍 Search cereal, juice, perfume, maize meal..." onkeyup="filterProducts()" 
                   class="w-full px-4 py-3.5 rounded-2xl border border-slate-700 bg-slate-800/90 text-white placeholder-slate-400 text-xs focus:ring-2 focus:ring-amber-400 outline-none shadow-md">

            <!-- Filter Pills -->
            <div class="flex space-x-2 overflow-x-auto pb-1 text-xs">
                <button onclick="filterCat('all', this)" class="cat-btn px-4 py-2 rounded-xl font-black rainbow-bg text-white shadow-md">All Items</button>
                <button onclick="filterCat('cereal', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-800 text-slate-300 border border-slate-700">Cereal Hampers</button>
                <button onclick="filterCat('juice', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-800 text-slate-300 border border-slate-700">Juices Africa</button>
                <button onclick="filterCat('perfume', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-800 text-slate-300 border border-slate-700">M-Scents</button>
                <button onclick="filterCat('essentials', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-800 text-slate-300 border border-slate-700">Pantry</button>
            </div>

            <!-- Product Cards Container with Real Images -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4" id="product-list"></div>
        </section>

        <!-- SPECIALS TAB -->
        <section id="tab-specials" class="tab-content hidden space-y-3">
            <div class="bg-slate-800/90 backdrop-blur-md p-5 rounded-2xl border border-slate-700 shadow-xl space-y-3">
                <h2 class="text-lg font-black rainbow-text">🔥 Exclusive Bundle Savings</h2>
                <div class="p-3.5 bg-slate-900/80 rounded-xl border border-purple-500/30 flex justify-between items-center">
                    <div>
                        <h4 class="font-black text-xs text-purple-300">2x M-Scents Perfumes Deal</h4>
                        <p class="text-[11px] text-slate-400">Save R48 on any two 40ml luxury fragrances</p>
                    </div>
                    <button onclick="addToCart('2x M-Scents Perfumes Deal', 192)" class="bg-purple-600 text-white font-black text-xs px-4 py-2 rounded-xl shadow-md">R 192</button>
                </div>
                <div class="p-3.5 bg-slate-900/80 rounded-xl border border-emerald-500/30 flex justify-between items-center">
                    <div>
                        <h4 class="font-black text-xs text-emerald-300">2x Juices Africa (4L) Deal</h4>
                        <p class="text-[11px] text-slate-400">Save R96 (Yields 40L Juice)</p>
                    </div>
                    <button onclick="addToCart('2x Juices Africa Deal', 224)" class="bg-emerald-600 text-white font-black text-xs px-4 py-2 rounded-xl shadow-md">R 224</button>
                </div>
                <div class="p-3.5 bg-slate-900/80 rounded-xl border border-amber-500/30 flex justify-between items-center">
                    <div>
                        <h4 class="font-black text-xs text-amber-300">3-Item Cereal Mini Combo</h4>
                        <p class="text-[11px] text-slate-400">Custom pantry basic selection</p>
                    </div>
                    <button onclick="addToCart('3-Item Mini Hamper', 170)" class="bg-amber-500 text-slate-950 font-black text-xs px-4 py-2 rounded-xl shadow-md">R 170</button>
                </div>
            </div>
        </section>

        <!-- ANALYTICS TAB -->
        <section id="tab-analytics" class="tab-content hidden space-y-4">
            <div class="bg-slate-800/90 backdrop-blur-md p-5 rounded-2xl border border-slate-700 shadow-xl space-y-3">
                <h2 class="text-base font-black text-white">📊 Flask API Live Telemetry</h2>
                <div class="relative h-52">
                    <canvas id="salesChart"></canvas>
                </div>
            </div>
        </section>

        <!-- AI ASSISTANT TAB -->
        <section id="tab-ai" class="tab-content hidden space-y-3">
            <div class="bg-slate-800/90 backdrop-blur-md p-5 rounded-2xl border border-slate-700 shadow-xl">
                <h2 class="text-base font-black mb-1 text-white">🤖 Nollie's AI Assistant</h2>
                <div id="chat-box" class="bg-slate-900/90 p-3 rounded-xl h-52 overflow-y-auto border border-slate-700 text-xs space-y-2 mb-3">
                    <div class="bg-slate-800 p-2.5 rounded-lg text-slate-200 border border-slate-700">
                        <strong>Nollie AI:</strong> Sawubona! Ask me about products, offline PWA installation, or R30 eNanda delivery!
                    </div>
                </div>
                <div class="flex space-x-2">
                    <input type="text" id="chat-input" placeholder="Type your question..." class="flex-1 px-3.5 py-2.5 text-xs rounded-xl border border-slate-700 bg-slate-900 text-white outline-none">
                    <button onclick="sendAiMessage()" class="rainbow-bg text-white font-black px-4 py-2.5 rounded-xl text-xs shadow-md">Send</button>
                </div>
            </div>
        </section>

    </main>

    <!-- Slide-Up Cart Drawer -->
    <div id="cart-modal" class="fixed inset-0 bg-slate-950/80 backdrop-blur-md z-50 hidden flex-col justify-end">
        <div class="bg-slate-900 rounded-t-3xl p-5 border-t border-slate-700 max-h-[85vh] flex flex-col shadow-2xl">
            <div class="flex justify-between items-center border-b border-slate-800 pb-3">
                <h3 class="font-black text-sm text-white">Your Order Summary</h3>
                <button onclick="toggleCart()" class="text-slate-400 text-xl font-bold">&times;</button>
            </div>
            <div id="cart-items" class="py-3 overflow-y-auto flex-1 space-y-2 text-xs"></div>
            <div class="border-t border-slate-800 pt-3 space-y-3">
                <div class="flex justify-between text-xs font-bold text-slate-300">
                    <span>Delivery Fee (eNanda):</span>
                    <span>R 30.00</span>
                </div>
                <div class="flex justify-between text-base font-black text-white">
                    <span>Total Amount:</span>
                    <span id="cart-total" class="rainbow-text">R 30.00</span>
                </div>
                <button onclick="checkoutWhatsApp()" class="w-full bg-wa text-white font-black py-3.5 rounded-2xl flex items-center justify-center space-x-2 text-sm shadow-xl">
                    <span>Send Order on WhatsApp 💬</span>
                </button>
            </div>
        </div>
    </div>

    <script src="js/app.js"></script>
</body>
</html>
HTML_EOF

# 5. Create frontend JS with PWA Installation & Real Product Images (public/js/app.js)
cat > public/js/app.js << 'JS_EOF'
const PRODUCTS = [
    { 
        id: 'c1', cat: 'cereal', title: 'Cereal Hamper - Package 1', price: 250, badge: '5 Items', 
        desc: 'Jungle Oats 1kg, Future Life 500g, Kellogg\'s Noodles (5 Pks) OR Juice, Bokomo Corn Flakes 1kg, Weet-Bix 450g.',
        img: 'https://images.unsplash.com/photo-1521483451571-9f5ce5f25d78?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'c2', cat: 'cereal', title: 'Cereal Hamper - Package 2', price: 250, badge: '5 Items', 
        desc: 'Bokomo Corn Flakes 1kg, Happy Valley Rice Puffs, Juice 6x300ml, My Life Porridge, Noodles.',
        img: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'c3', cat: 'cereal', title: 'Cereal Hamper - Package 3', price: 250, badge: '5 Items', 
        desc: 'Bokomo Weet-Bix 450g, Corn Flakes 1kg, Future Life 500g, Nutrifics 450g, Noodles.',
        img: 'https://images.unsplash.com/photo-1517093788734-90fa7b733160?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'c4', cat: 'cereal', title: 'Cereal Hamper - Package 4', price: 250, badge: '5 Items', 
        desc: 'Bokomo Corn Flakes 1kg, Weet-Bix 450g, Juice 6x300ml, Future Life 500g, Nutrifics.',
        img: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'j1', cat: 'juice', title: 'Juices Africa (4L Bottle)', price: 160, badge: 'Makes 20L', 
        desc: 'Flavors: Guava, Mixed Berry, Cocktail, Tropical Punch. High yield fruit concentrate.',
        img: 'https://images.unsplash.com/photo-1613478223719-2ab802602423?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'p1', cat: 'perfume', title: 'M-Scents Premium Perfumes (40ml)', price: 120, badge: '40ml Luxury', 
        desc: 'Silver Sense, Red Dezire, White OUD, Blue Dezire, StallioN, Sky OUD, Gorgeous Girl, Wild Intense.',
        img: 'https://images.unsplash.com/photo-1523293182086-7651a899d37f?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'e1', cat: 'essentials', title: 'Fresh Bakery & Bread Daily Pack', price: 35, badge: 'Fresh Daily', 
        desc: 'Fresh white/brown loaf, butter rolls, and morning tea treats.',
        img: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'e2', cat: 'essentials', title: '5L Sunflower Oil + 5kg Maize Meal', price: 145, badge: 'Pantry Essential', 
        desc: 'Golden Sunflower Cooking Oil (5L) + Top Quality Maize Meal (5kg).',
        img: 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'e3', cat: 'essentials', title: 'Cleaning & Hygiene Household Bucket', price: 185, badge: 'Home Care', 
        desc: 'Dishwashing Liquid, Bleach, Washing Powder (2kg), and Floor Cleaner.',
        img: 'https://images.unsplash.com/photo-1585421514284-efb74c2b69ba?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'e4', cat: 'essentials', title: 'School & Office Stationery Starter Pack', price: 95, badge: 'School Pack', 
        desc: '4x Exercise Books, Pen Set, Pencils, Eraser, Glue, and 30cm Ruler.',
        img: 'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?auto=format&fit=crop&w=500&q=80'
    }
];

let cart = [];
const deliveryFee = 30;
let deferredPrompt = null;
let salesChartInstance = null;

document.addEventListener('DOMContentLoaded', () => {
    renderProducts(PRODUCTS);
    initCharts();

    // Register Service Worker for Offline PWA
    if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register('/sw.js').catch(() => {});
    }
});

// PWA Install prompt listener
window.addEventListener('beforeinstallprompt', (e) => {
    e.preventDefault();
    deferredPrompt = e;
    const btn = document.getElementById('install-btn');
    if (btn) btn.style.display = 'block';
});

function installPWA() {
    if (deferredPrompt) {
        deferredPrompt.prompt();
        deferredPrompt.userChoice.then((choiceResult) => {
            if (choiceResult.outcome === 'accepted') {
                document.getElementById('install-btn').style.display = 'none';
            }
            deferredPrompt = null;
        });
    }
}

// Accessibility Theme Switcher
function setTheme(themeName) {
    document.documentElement.setAttribute('data-theme', themeName);
    localStorage.setItem('nollie_theme', themeName);
}

// Load saved theme if any
const savedTheme = localStorage.getItem('nollie_theme');
if (savedTheme) {
    document.documentElement.setAttribute('data-theme', savedTheme);
}

function renderProducts(items) {
    const container = document.getElementById('product-list');
    if (!container) return;
    container.innerHTML = items.map(p => `
        <div class="product-card bg-slate-800/90 backdrop-blur-md rounded-2xl border border-slate-700 shadow-lg overflow-hidden flex flex-col justify-between" data-cat="${p.cat}">
            <div>
                <div class="h-40 overflow-hidden relative">
                    <img src="${p.img}" alt="${p.title}" class="w-full h-full object-cover hover:scale-105 transition-transform duration-300">
                    <span class="absolute top-2 left-2 bg-amber-400 text-slate-950 text-[10px] font-black px-2.5 py-0.5 rounded-md uppercase shadow">${p.badge}</span>
                </div>
                <div class="p-4">
                    <div class="flex justify-between items-center mb-1">
                        <h3 class="text-sm font-bold text-white">${p.title}</h3>
                    </div>
                    <p class="text-[11px] text-slate-300 line-clamp-2">${p.desc}</p>
                </div>
            </div>
            <div class="p-4 pt-0 flex justify-between items-center">
                <span class="text-base font-black text-amber-400">R ${p.price.toFixed(2)}</span>
                <button onclick="addToCart('${p.title}', ${p.price})" class="rainbow-bg text-white text-xs font-black px-4 py-2 rounded-xl shadow-md hover:opacity-90 transition-all">+ Add</button>
            </div>
        </div>
    `).join('');
}

function addToCart(title, price) {
    cart.push({ title, price });
    updateCartUI();
    toggleCart();
}

function updateCartUI() {
    document.getElementById('cart-count').innerText = cart.length;
    const container = document.getElementById('cart-items');
    container.innerHTML = '';

    let subtotal = 0;
    cart.forEach((item, index) => {
        subtotal += item.price;
        container.innerHTML += `
            <div class="flex justify-between items-center bg-slate-800 p-2.5 rounded-xl border border-slate-700 text-slate-200">
                <div>
                    <div class="font-bold">${item.title}</div>
                    <div class="text-slate-400 text-[10px]">R ${item.price.toFixed(2)}</div>
                </div>
                <button onclick="removeFromCart(${index})" class="text-red-400 font-bold px-2">✕</button>
            </div>
        `;
    });

    const grandTotal = cart.length > 0 ? subtotal + deliveryFee : 0;
    document.getElementById('cart-total').innerText = `R ${grandTotal.toFixed(2)}`;
}

function removeFromCart(index) {
    cart.splice(index, 1);
    updateCartUI();
}

function toggleCart() {
    const modal = document.getElementById('cart-modal');
    modal.classList.toggle('hidden');
    modal.classList.toggle('flex');
}

function switchTab(tabId, btn) {
    document.querySelectorAll('.tab-btn').forEach(b => {
        b.classList.remove('rainbow-bg', 'text-white', 'font-black');
        b.classList.add('text-slate-300', 'font-bold');
    });
    document.querySelectorAll('.tab-content').forEach(c => c.classList.add('hidden'));

    btn.classList.add('rainbow-bg', 'text-white', 'font-black');
    btn.classList.remove('text-slate-300', 'font-bold');
    document.getElementById(`tab-${tabId}`).classList.remove('hidden');

    if (tabId === 'analytics') {
        setTimeout(updateCharts, 100);
    }
}

function filterProducts() {
    const query = document.getElementById('search-input').value.toLowerCase();
    const filtered = PRODUCTS.filter(p => p.title.toLowerCase().includes(query) || p.desc.toLowerCase().includes(query));
    renderProducts(filtered);
}

function filterCat(cat, btn) {
    document.querySelectorAll('.cat-btn').forEach(b => {
        b.classList.remove('rainbow-bg', 'text-white', 'font-black');
        b.classList.add('bg-slate-800', 'text-slate-300');
    });
    btn.classList.add('rainbow-bg', 'text-white', 'font-black');

    if (cat === 'all') {
        renderProducts(PRODUCTS);
    } else {
        renderProducts(PRODUCTS.filter(p => p.cat === cat));
    }
}

function initCharts() {
    const el = document.getElementById('salesChart');
    if (el) {
        const ctx = el.getContext('2d');
        salesChartInstance = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Cereal Hampers', 'Juices Africa', 'M-Scents Perfumes', 'Pantry Essentials'],
                datasets: [{
                    data: [40, 25, 20, 15],
                    backgroundColor: ['#a855f7', '#10b981', '#f59e0b', '#06b6d4']
                }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });
    }
}

function updateCharts() {
    if (salesChartInstance) salesChartInstance.update();
}

function sendAiMessage() {
    const input = document.getElementById('chat-input');
    const box = document.getElementById('chat-box');
    const text = input.value.trim();
    if (!text) return;

    box.innerHTML += `<div class="text-right"><span class="inline-block rainbow-bg text-white font-bold p-2.5 rounded-xl">${text}</span></div>`;

    setTimeout(() => {
        let reply = "We deliver across eNanda for R30! You can install this app on your phone to use it offline anytime.";
        const lower = text.toLowerCase();
        if (lower.includes('offline') || lower.includes('install')) {
            reply = "Tap the '📲 Install App' button at the top right of the screen to install Nollie's on your device for offline use!";
        } else if (lower.includes('bread') || lower.includes('oil')) {
            reply = "We stock Fresh Daily Bakery Packs (R35) and 5L Cooking Oil + 5kg Maize Meal Combo (R145)!";
        }
        box.innerHTML += `<div><span class="inline-block bg-slate-800 text-slate-200 border border-slate-700 p-2.5 rounded-xl"><strong>Nollie AI:</strong> ${reply}</span></div>`;
        box.scrollTop = box.scrollHeight;
    }, 400);

    input.value = '';
}

async function checkoutWhatsApp() {
    if (cart.length === 0) return alert('Your cart is empty!');

    let subtotal = cart.reduce((sum, item) => sum + item.price, 0);
    let grandTotal = subtotal + deliveryFee;

    try {
        await fetch('/api/order', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                name: 'eNanda PWA Customer',
                phone: 'WhatsApp User',
                total: grandTotal,
                items: cart
            })
        });
    } catch (e) {}

    let msg = "Hi Nollie's (eNanda), I would like to order:%0A%0A";
    cart.forEach(item => {
        msg += `• ${item.title} - R${item.price}%0A`;
    });
    msg += `%0ADelivery Fee: R30%0A*Total: R${grandTotal.toFixed(2)}*`;

    window.open(`https://wa.me/?text=${msg}`, '_blank');
}
JS_EOF

# Sync root index.html
cp public/index.html index.html 2>/dev/null || true

echo "======================================================="
echo "✅ Ultimate PWA & Accessibility Upgrade Complete!"
echo "======================================================="
