#!/data/data/com.termux/files/usr/bin/bash
set -e

cd ~/nollies
echo "🍊 Perfecting Nollie's Orange Theme, Dynamic Auto-Images & Animations..."

mkdir -p public/js public/css data

# 1. Update public/index.html with Responsive Orange Theme & Dynamic Image Handling
cat > public/index.html << 'HTML_EOF'
<!DOCTYPE html>
<html lang="en" data-theme="default">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Nollie's | eNanda Community Store</title>
    <link rel="manifest" href="/manifest.json">
    <meta name="theme-color" content="#f97316">
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; transition: background 0.3s, color 0.3s; }
        
        [data-theme="default"] { background-color: #0f172a; color: #f8fafc; }
        [data-theme="high-contrast"] { background-color: #000000; color: #ffff00; }
        [data-theme="light"] { background-color: #ffffff; color: #0f172a; }

        .orange-gradient {
            background: linear-gradient(135deg, #f97316, #ea580c, #c2410c);
        }
        .orange-text {
            background: linear-gradient(90deg, #f97316, #fb923c, #fdba74);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-fade { animation: fadeIn 0.3s ease-out forwards; }
    </style>
</head>
<body class="min-h-screen pb-24">

    <!-- Top Orange Accent Bar -->
    <div class="h-1.5 orange-gradient w-full fixed top-0 z-50"></div>

    <!-- Header Navigation -->
    <header class="sticky top-1.5 z-40 bg-slate-900/95 backdrop-blur-md border-b border-slate-800 px-4 py-3 flex justify-between items-center shadow-lg">
        <div class="flex items-center space-x-2">
            <span class="text-2xl font-black tracking-tight text-white">Nollie's<span class="text-orange-500">.</span></span>
            <span class="orange-gradient text-white text-[10px] font-black px-2.5 py-0.5 rounded-full shadow-sm">eNanda Hub</span>
        </div>
        <div class="flex items-center space-x-2">
            <button id="install-btn" style="display:none;" onclick="installPWA()" class="bg-orange-500 text-white font-black text-[11px] px-3 py-1.5 rounded-xl shadow-md animate-bounce">📲 Install App</button>
            <button onclick="toggleCart()" class="relative flex items-center orange-gradient text-white text-xs font-black px-4 py-2 rounded-full shadow-lg hover:opacity-90 transition-all">
                <span>🛒 Cart</span>
                <span id="cart-count" class="ml-2 bg-white text-slate-900 text-[10px] rounded-full h-5 w-5 flex items-center justify-center font-black">0</span>
            </button>
        </div>
    </header>

    <!-- Vision Accessibility Bar -->
    <div class="bg-slate-800 border-b border-slate-700 py-2 px-3 flex justify-between items-center text-xs max-w-2xl mx-auto">
        <span class="font-bold text-orange-400">👁️ View Mode:</span>
        <div class="flex gap-1.5">
            <button onclick="setTheme('default')" class="px-2.5 py-1 rounded-lg bg-orange-600 font-bold text-white text-[10px]">Dark</button>
            <button onclick="setTheme('light')" class="px-2.5 py-1 rounded-lg bg-white text-slate-900 font-bold text-[10px]">Light</button>
            <button onclick="setTheme('high-contrast')" class="px-2.5 py-1 rounded-lg bg-black text-yellow-300 border border-yellow-300 font-bold text-[10px]">Contrast</button>
        </div>
    </div>

    <!-- Location & Delivery Banner -->
    <div class="bg-orange-500 text-slate-950 text-xs font-black text-center py-2 px-4 flex justify-between items-center max-w-2xl mx-auto shadow-md">
        <span>📍 eNanda, Durban, KZN</span>
        <span>🚚 Fixed R30 Delivery Fee</span>
    </div>

    <!-- Navigation Tabs -->
    <nav class="flex bg-slate-800/90 backdrop-blur-md border border-slate-700 max-w-2xl mx-auto my-3 rounded-2xl shadow-xl p-1.5 gap-1 overflow-x-auto">
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-black orange-gradient text-white whitespace-nowrap text-center shadow-md transition-all" onclick="switchTab('shop', this)">🛍️ Shop</button>
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-bold text-slate-300 hover:text-white whitespace-nowrap text-center transition-all" onclick="switchTab('specials', this)">🔥 Combos</button>
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-bold text-slate-300 hover:text-white whitespace-nowrap text-center transition-all" onclick="switchTab('analytics', this)">📊 Telemetry</button>
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-bold text-slate-300 hover:text-white whitespace-nowrap text-center transition-all" onclick="switchTab('ai', this)">🤖 AI Help</button>
    </nav>

    <!-- Main Container -->
    <main class="max-w-2xl mx-auto px-4">

        <!-- SHOP TAB -->
        <section id="tab-shop" class="tab-content block space-y-4 animate-fade">
            <div class="relative overflow-hidden rounded-2xl border border-slate-700 p-5 shadow-2xl bg-slate-800/80 backdrop-blur-sm">
                <h1 class="text-xl font-black mb-1 orange-text">Quality Products & Good Services</h1>
                <p class="text-xs text-slate-300">Browse real stock below with instant WhatsApp ordering and offline PWA capability.</p>
            </div>

            <input type="text" id="search-input" placeholder="🔍 Search cereal, juice, perfume, bread, maize meal..." onkeyup="filterProducts()" 
                   class="w-full px-4 py-3.5 rounded-2xl border border-slate-700 bg-slate-800/90 text-white placeholder-slate-400 text-xs focus:ring-2 focus:ring-orange-500 outline-none shadow-md">

            <!-- Filter Pills -->
            <div class="flex space-x-2 overflow-x-auto pb-1 text-xs">
                <button onclick="filterCat('all', this)" class="cat-btn px-4 py-2 rounded-xl font-black orange-gradient text-white shadow-md">All Items</button>
                <button onclick="filterCat('cereal', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-800 text-slate-300 border border-slate-700">Cereal Hampers</button>
                <button onclick="filterCat('juice', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-800 text-slate-300 border border-slate-700">Juices Africa</button>
                <button onclick="filterCat('perfume', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-800 text-slate-300 border border-slate-700">M-Scents</button>
                <button onclick="filterCat('essentials', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-800 text-slate-300 border border-slate-700">Pantry</button>
            </div>

            <!-- Product Cards Grid -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4" id="product-list"></div>
        </section>

        <!-- SPECIALS TAB -->
        <section id="tab-specials" class="tab-content hidden space-y-3 animate-fade">
            <div class="bg-slate-800/90 backdrop-blur-md p-5 rounded-2xl border border-slate-700 shadow-xl space-y-3">
                <h2 class="text-lg font-black orange-text">🔥 Exclusive Bundle Savings</h2>
                <div class="p-3.5 bg-slate-900/80 rounded-xl border border-orange-500/30 flex justify-between items-center">
                    <div>
                        <h4 class="font-black text-xs text-orange-300">2x M-Scents Perfumes Deal</h4>
                        <p class="text-[11px] text-slate-400">Save R48 on any two 40ml luxury fragrances</p>
                    </div>
                    <button onclick="addToCart('2x M-Scents Perfumes Deal', 192)" class="orange-gradient text-white font-black text-xs px-4 py-2 rounded-xl shadow-md">R 192</button>
                </div>
                <div class="p-3.5 bg-slate-900/80 rounded-xl border border-orange-500/30 flex justify-between items-center">
                    <div>
                        <h4 class="font-black text-xs text-orange-300">2x Juices Africa (4L) Deal</h4>
                        <p class="text-[11px] text-slate-400">Save R96 (Yields 40L Juice)</p>
                    </div>
                    <button onclick="addToCart('2x Juices Africa Deal', 224)" class="orange-gradient text-white font-black text-xs px-4 py-2 rounded-xl shadow-md">R 224</button>
                </div>
                <div class="p-3.5 bg-slate-900/80 rounded-xl border border-orange-500/30 flex justify-between items-center">
                    <div>
                        <h4 class="font-black text-xs text-orange-300">3-Item Cereal Mini Combo</h4>
                        <p class="text-[11px] text-slate-400">Custom pantry basic selection</p>
                    </div>
                    <button onclick="addToCart('3-Item Mini Hamper', 170)" class="orange-gradient text-white font-black text-xs px-4 py-2 rounded-xl shadow-md">R 170</button>
                </div>
            </div>
        </section>

        <!-- ANALYTICS TAB -->
        <section id="tab-analytics" class="tab-content hidden space-y-4 animate-fade">
            <div class="bg-slate-800/90 backdrop-blur-md p-5 rounded-2xl border border-slate-700 shadow-xl space-y-3">
                <h2 class="text-base font-black text-white">📊 Flask API Live Telemetry</h2>
                <div class="relative h-52">
                    <canvas id="salesChart"></canvas>
                </div>
            </div>
        </section>

        <!-- AI ASSISTANT TAB -->
        <section id="tab-ai" class="tab-content hidden space-y-3 animate-fade">
            <div class="bg-slate-800/90 backdrop-blur-md p-5 rounded-2xl border border-slate-700 shadow-xl">
                <h2 class="text-base font-black mb-1 text-white">🤖 Nollie's AI Assistant</h2>
                <div id="chat-box" class="bg-slate-900/90 p-3 rounded-xl h-52 overflow-y-auto border border-slate-700 text-xs space-y-2 mb-3">
                    <div class="bg-slate-800 p-2.5 rounded-lg text-slate-200 border border-slate-700">
                        <strong>Nollie AI:</strong> Sawubona! Ask me about products, offline installation, or R30 eNanda delivery!
                    </div>
                </div>
                <div class="flex space-x-2">
                    <input type="text" id="chat-input" placeholder="Type your question..." class="flex-1 px-3.5 py-2.5 text-xs rounded-xl border border-slate-700 bg-slate-900 text-white outline-none">
                    <button onclick="sendAiMessage()" class="orange-gradient text-white font-black px-4 py-2.5 rounded-xl text-xs shadow-md">Send</button>
                </div>
            </div>
        </section>

    </main>

    <!-- Cart Drawer -->
    <div id="cart-modal" class="fixed inset-0 bg-slate-950/80 backdrop-blur-md z-50 hidden flex-col justify-end">
        <div class="bg-slate-900 rounded-t-3xl p-5 border-t border-slate-700 max-h-[85vh] flex flex-col shadow-2xl animate-fade">
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
                    <span id="cart-total" class="orange-text">R 30.00</span>
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

# 2. Create frontend JS with Smart Auto-Fallback Images & Responsive Rendering (public/js/app.js)
cat > public/js/app.js << 'JS_EOF'
const PRODUCTS = [
    { 
        id: 'c1', cat: 'cereal', title: 'Cereal Hamper - Package 1', price: 250, badge: '5 Items', 
        desc: 'Jungle Oats 1kg, Future Life 500g, Kellogg\'s Noodles (5 Pks), Bokomo Corn Flakes 1kg, Weet-Bix 450g.',
        img: 'https://images.unsplash.com/photo-1521483451571-9f5ce5f25d78?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1517093788734-90fa7b733160?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'c2', cat: 'cereal', title: 'Cereal Hamper - Package 2', price: 250, badge: '5 Items', 
        desc: 'Bokomo Corn Flakes 1kg, Happy Valley Rice Puffs, Juice 6x300ml, My Life Porridge, Noodles.',
        img: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1521483451571-9f5ce5f25d78?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'c3', cat: 'cereal', title: 'Cereal Hamper - Package 3', price: 250, badge: '5 Items', 
        desc: 'Bokomo Weet-Bix 450g, Corn Flakes 1kg, Future Life 500g, Nutrifics 450g, Noodles.',
        img: 'https://images.unsplash.com/photo-1517093788734-90fa7b733160?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'c4', cat: 'cereal', title: 'Cereal Hamper - Package 4', price: 250, badge: '5 Items', 
        desc: 'Bokomo Corn Flakes 1kg, Weet-Bix 450g, Juice 6x300ml, Future Life 500g, Nutrifics.',
        img: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'j1', cat: 'juice', title: 'Juices Africa (4L Bottle)', price: 160, badge: 'Makes 20L', 
        desc: 'Guava, Mixed Berry, Cocktail, Tropical Punch. High yield fruit concentrate.',
        img: 'https://images.unsplash.com/photo-1613478223719-2ab802602423?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1546171753-97d7676eefa0?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'p1', cat: 'perfume', title: 'M-Scents Premium Perfumes (40ml)', price: 120, badge: '40ml Luxury', 
        desc: 'Silver Sense, Red Dezire, White OUD, Blue Dezire, StallioN, Sky OUD, Gorgeous Girl, Wild Intense.',
        img: 'https://images.unsplash.com/photo-1523293182086-7651a899d37f?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1594035910387-fea47794261f?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'e1', cat: 'essentials', title: 'Fresh Bakery & Bread Daily Pack', price: 35, badge: 'Fresh Daily', 
        desc: 'Fresh white/brown loaf, butter rolls, and morning tea treats.',
        img: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1549931319-a545dcf3bc73?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'e2', cat: 'essentials', title: '5L Sunflower Oil + 5kg Maize Meal', price: 145, badge: 'Pantry Essential', 
        desc: 'Golden Sunflower Cooking Oil (5L) + Top Quality Maize Meal (5kg).',
        img: 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'e3', cat: 'essentials', title: 'Cleaning & Hygiene Household Bucket', price: 185, badge: 'Home Care', 
        desc: 'Dishwashing Liquid, Bleach, Washing Powder (2kg), and Floor Cleaner.',
        img: 'https://images.unsplash.com/photo-1585421514284-efb74c2b69ba?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1563453392212-326f5e854473?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'e4', cat: 'essentials', title: 'School & Office Stationery Starter Pack', price: 95, badge: 'School Pack', 
        desc: '4x Exercise Books, Pen Set, Pencils, Eraser, Glue, and 30cm Ruler.',
        img: 'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=500&q=80'
    }
];

let cart = [];
const deliveryFee = 30;
let deferredPrompt = null;
let salesChartInstance = null;

document.addEventListener('DOMContentLoaded', () => {
    renderProducts(PRODUCTS);
    initCharts();

    if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register('/sw.js').catch(() => {});
    }
});

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

function setTheme(themeName) {
    document.documentElement.setAttribute('data-theme', themeName);
    localStorage.setItem('nollie_theme', themeName);
}

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
                <div class="h-40 overflow-hidden relative bg-slate-900">
                    <img src="${p.img}" alt="${p.title}" class="w-full h-full object-cover hover:scale-105 transition-transform duration-300" onerror="this.onerror=null; this.src='${p.fallback}';">
                    <span class="absolute top-2 left-2 bg-orange-500 text-white text-[10px] font-black px-2.5 py-0.5 rounded-md uppercase shadow">${p.badge}</span>
                </div>
                <div class="p-4">
                    <h3 class="text-sm font-bold text-white mb-1">${p.title}</h3>
                    <p class="text-[11px] text-slate-300 line-clamp-2">${p.desc}</p>
                </div>
            </div>
            <div class="p-4 pt-0 flex justify-between items-center">
                <span class="text-base font-black text-orange-400">R ${p.price.toFixed(2)}</span>
                <button onclick="addToCart('${p.title}', ${p.price})" class="orange-gradient text-white text-xs font-black px-4 py-2 rounded-xl shadow-md hover:opacity-90 transition-all">+ Add</button>
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
        b.classList.remove('orange-gradient', 'text-white', 'font-black', 'shadow-md');
        b.classList.add('text-slate-300', 'font-bold');
    });
    document.querySelectorAll('.tab-content').forEach(c => c.classList.add('hidden'));

    btn.classList.add('orange-gradient', 'text-white', 'font-black', 'shadow-md');
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
        b.classList.remove('orange-gradient', 'text-white', 'font-black', 'shadow-md');
        b.classList.add('bg-slate-800', 'text-slate-300');
    });
    btn.classList.add('orange-gradient', 'text-white', 'font-black', 'shadow-md');

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
                    backgroundColor: ['#f97316', '#ea580c', '#fb923c', '#c2410c']
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

    box.innerHTML += `<div class="text-right"><span class="inline-block orange-gradient text-white font-bold p-2.5 rounded-xl">${text}</span></div>`;

    setTimeout(() => {
        let reply = "We deliver across eNanda for R30! You can install our app to use it offline anytime.";
        const lower = text.toLowerCase();
        if (lower.includes('offline') || lower.includes('install')) {
            reply = "Tap the '📲 Install App' button at the top right to install Nollie's on your home screen!";
        } else if (lower.includes('bread') || lower.includes('oil')) {
            reply = "We stock Fresh Bakery Packs (R35) and 5L Cooking Oil + 5kg Maize Meal Combo (R145)!";
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

# 3. Sync root index.html
cp public/index.html index.html 2>/dev/null || true

echo "======================================================="
echo "✅ Orange Theme, Auto-Fallback Images & Responsive PWA Ready!"
echo "======================================================="
