#!/data/data/com.termux/files/usr/bin/bash
set -e

cd ~/nollies
echo "🚀 Upgrading Nollie's with Real-World Community Products & High-Impact UI..."

mkdir -p public/js public/css data

# 1. Generate public/index.html
cat > public/index.html << 'HTML_EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Nollie's | eNanda Community Essentials</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Chart.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        wa: '#25D366'
                    }
                }
            }
        }
    </script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
        
        .rainbow-text {
            background: linear-gradient(90deg, #ef4444, #f97316, #eab308, #10b981, #06b6d4, #6366f1, #a855f7);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .rainbow-bg {
            background: linear-gradient(135deg, #ef4444, #f97316, #eab308, #10b981, #06b6d4, #6366f1, #a855f7);
        }

        .bg-community {
            background-image: linear-gradient(rgba(15, 23, 42, 0.88), rgba(15, 23, 42, 0.94)), 
                              url('https://images.unsplash.com/photo-1547471080-7cc2caa01a7e?auto=format&fit=crop&w=1200&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }
    </style>
</head>
<body class="bg-slate-900 text-slate-100 min-h-screen pb-24 bg-community">

    <!-- Rainbow Top Accent Bar -->
    <div class="h-1.5 rainbow-bg w-full fixed top-0 z-50"></div>

    <!-- Header Navigation -->
    <header class="sticky top-1.5 z-40 bg-slate-900/90 backdrop-blur-md border-b border-slate-800 px-4 py-3 flex justify-between items-center shadow-lg">
        <div class="flex items-center space-x-2">
            <span class="text-2xl font-black tracking-tight text-white">Nollie's<span class="text-amber-400">.</span></span>
            <span class="rainbow-bg text-white text-[10px] font-black px-2.5 py-0.5 rounded-full shadow-sm">eNanda Hub</span>
        </div>
        <div class="flex items-center space-x-2">
            <button onclick="toggleCart()" class="relative flex items-center rainbow-bg text-white text-xs font-black px-4 py-2 rounded-full shadow-lg hover:opacity-90 transition-all">
                <span>🛒 Cart</span>
                <span id="cart-count" class="ml-2 bg-white text-slate-900 text-[10px] rounded-full h-5 w-5 flex items-center justify-center font-black">0</span>
            </button>
        </div>
    </header>

    <!-- Location & Delivery Banner -->
    <div class="bg-amber-400 text-slate-950 text-xs font-black text-center py-2 px-4 flex justify-between items-center max-w-2xl mx-auto shadow-md">
        <span>📍 Based in eNanda, Durban</span>
        <span>🚚 Fixed R30 Delivery Fee</span>
    </div>

    <!-- Navigation Tabs -->
    <nav class="flex bg-slate-800/90 backdrop-blur-md border border-slate-700 max-w-2xl mx-auto my-3 rounded-2xl shadow-xl p-1.5 gap-1 overflow-x-auto">
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-black rainbow-bg text-white whitespace-nowrap text-center" onclick="switchTab('shop', this)">🛍️ Shop Products</button>
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-bold text-slate-300 hover:text-white whitespace-nowrap text-center" onclick="switchTab('specials', this)">🔥 Special Combos</button>
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-bold text-slate-300 hover:text-white whitespace-nowrap text-center" onclick="switchTab('analytics', this)">📊 Live Telemetry</button>
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-bold text-slate-300 hover:text-white whitespace-nowrap text-center" onclick="switchTab('ai', this)">🤖 AI Assistant</button>
    </nav>

    <!-- Main Content Container -->
    <main class="max-w-2xl mx-auto px-4">

        <!-- SHOP TAB -->
        <section id="tab-shop" class="tab-content block space-y-4">
            
            <div class="relative overflow-hidden rounded-2xl border border-slate-700 p-5 shadow-2xl bg-slate-800/80 backdrop-blur-sm">
                <h1 class="text-xl font-black mb-1 rainbow-text">Community-Tested Quality Products</h1>
                <p class="text-xs text-slate-300">5-Item Cereal Hampers, Juices Africa (4L Makes 20L), M-Scents Perfumes, & Pantry Basics!</p>
            </div>

            <input type="text" id="search-input" placeholder="🔍 Search cereal, juices africa, m-scents, bread..." onkeyup="filterProducts()" 
                   class="w-full px-4 py-3.5 rounded-2xl border border-slate-700 bg-slate-800/90 text-white placeholder-slate-400 text-xs focus:ring-2 focus:ring-amber-400 outline-none shadow-md">

            <!-- Filter Pills -->
            <div class="flex space-x-2 overflow-x-auto pb-1 text-xs">
                <button onclick="filterCat('all', this)" class="cat-btn px-4 py-2 rounded-xl font-black rainbow-bg text-white shadow-md">All Items</button>
                <button onclick="filterCat('cereal', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-800 text-slate-300 border border-slate-700">Cereal Hampers</button>
                <button onclick="filterCat('juice', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-800 text-slate-300 border border-slate-700">Juices Africa (4L)</button>
                <button onclick="filterCat('perfume', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-800 text-slate-300 border border-slate-700">M-Scents Perfumes</button>
                <button onclick="filterCat('essentials', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-800 text-slate-300 border border-slate-700">Daily Pantry</button>
            </div>

            <!-- Product Cards Container -->
            <div class="space-y-3" id="product-list">
                <!-- Injected dynamically via JS -->
            </div>
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
                    <button onclick="addToCart('2x M-Scents Perfumes Deal', 192)" class="bg-purple-600 hover:bg-purple-500 text-white font-black text-xs px-4 py-2 rounded-xl shadow-md">R 192</button>
                </div>

                <div class="p-3.5 bg-slate-900/80 rounded-xl border border-emerald-500/30 flex justify-between items-center">
                    <div>
                        <h4 class="font-black text-xs text-emerald-300">2x Juices Africa (4L) Deal</h4>
                        <p class="text-[11px] text-slate-400">Save R96 (Yields 40L Juice for events & families)</p>
                    </div>
                    <button onclick="addToCart('2x Juices Africa Deal', 224)" class="bg-emerald-600 hover:bg-emerald-500 text-white font-black text-xs px-4 py-2 rounded-xl shadow-md">R 224</button>
                </div>

                <div class="p-3.5 bg-slate-900/80 rounded-xl border border-amber-500/30 flex justify-between items-center">
                    <div>
                        <h4 class="font-black text-xs text-amber-300">3-Item Cereal Mini Combo</h4>
                        <p class="text-[11px] text-slate-400">Custom pantry basic selection</p>
                    </div>
                    <button onclick="addToCart('3-Item Mini Hamper', 170)" class="bg-amber-500 hover:bg-amber-400 text-slate-950 font-black text-xs px-4 py-2 rounded-xl shadow-md">R 170</button>
                </div>
            </div>
        </section>

        <!-- ANALYTICS TAB -->
        <section id="tab-analytics" class="tab-content hidden space-y-4">
            <div class="bg-slate-800/90 backdrop-blur-md p-5 rounded-2xl border border-slate-700 shadow-xl space-y-3">
                <h2 class="text-base font-black text-white">📊 eNanda Live Store Telemetry</h2>
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
                        <strong>Nollie AI:</strong> Sawubona! Ask me about Juices Africa, Cereal Hampers, Daily Bakery, or R30 eNanda delivery!
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

# 2. Write JavaScript Application Logic (public/js/app.js)
cat > public/js/app.js << 'JS_EOF'
const PRODUCTS = [
    { id: 'c1', cat: 'cereal', title: 'Cereal Hamper - Package 1', price: 250, badge: '5 Items', desc: 'Jungle Oats 1kg, Future Life 500g, Kellogg\'s Noodles (5 Pks) OR Juice (6x300ml), Bokomo Corn Flakes 1kg, Weet-Bix 450g.' },
    { id: 'c2', cat: 'cereal', title: 'Cereal Hamper - Package 2', price: 250, badge: '5 Items', desc: 'Bokomo Corn Flakes 1kg, Happy Valley (Rice Puffs), Juice 6x300ml, My Life Instant Porridge, Kellogg\'s Noodles (5 Pks).' },
    { id: 'c3', cat: 'cereal', title: 'Cereal Hamper - Package 3', price: 250, badge: '5 Items', desc: 'Bokomo Weet-Bix 450g, Corn Flakes 1kg, Future Life 500g, Nutrifics 450g, Kellogg\'s Noodles (5 Pks).' },
    { id: 'c4', cat: 'cereal', title: 'Cereal Hamper - Package 4', price: 250, badge: '5 Items', desc: 'Bokomo Corn Flakes 1kg, Weet-Bix 450g, Juice 6x300ml, Future Life 500g, Nutrifics 450g.' },
    { id: 'j1', cat: 'juice', title: 'Juices Africa (4L Bottle)', price: 160, badge: 'Makes 20L', desc: 'Flavors: Guava, Mixed Berry, Cocktail, Tropical Punch.' },
    { id: 'p1', cat: 'perfume', title: 'M-Scents Premium Perfumes (40ml)', price: 120, badge: '40ml Luxury', desc: 'Silver Sense, Red Dezire, White OUD, Blue Dezire, StallioN, Sky OUD, Gorgeous Girl, Wild Intense.' },
    { id: 'e1', cat: 'essentials', title: 'Fresh Bakery & Bread Daily Pack', price: 35, badge: 'Fresh Daily', desc: 'Fresh white/brown loaf, butter rolls, and morning tea treats.' },
    { id: 'e2', cat: 'essentials', title: '5L Sunflower Oil + 5kg Maize Meal Combo', price: 145, badge: 'Pantry Essential', desc: 'Golden Sunflower Cooking Oil (5L) + Top Quality Iwisa/Ace Maize Meal (5kg).' },
    { id: 'e3', cat: 'essentials', title: 'Cleaning & Hygiene Household Bucket', price: 185, badge: 'Home Care', desc: 'Dishwashing Liquid, Bleach, Washing Powder (2kg), and Floor Cleaner.' },
    { id: 'e4', cat: 'essentials', title: 'School & Office Stationery Starter Pack', price: 95, badge: 'School Pack', desc: '4x Exercise Books, Pen Set, Pencils, Eraser, Glue, and 30cm Ruler.' }
];

let cart = [];
const deliveryFee = 30;
let salesChartInstance = null;

document.addEventListener('DOMContentLoaded', () => {
    renderProducts(PRODUCTS);
    initCharts();
});

function renderProducts(items) {
    const container = document.getElementById('product-list');
    if (!container) return;
    container.innerHTML = items.map(p => `
        <div class="product-card bg-slate-800/90 backdrop-blur-md p-4 rounded-2xl border border-slate-700 shadow-lg" data-cat="${p.cat}">
            <div class="flex justify-between items-center">
                <span class="bg-amber-400 text-slate-950 text-[10px] font-black px-2.5 py-0.5 rounded-md uppercase">${p.badge}</span>
                <span class="text-xs font-black text-amber-400">R ${p.price.toFixed(2)}</span>
            </div>
            <h3 class="text-sm font-bold mt-2 text-white">${p.title}</h3>
            <p class="text-[11px] text-slate-300 my-1.5">${p.desc}</p>
            <div class="border-t border-slate-700/80 pt-3 mt-2 flex justify-end">
                <button onclick="addToCart('${p.title}', ${p.price})" class="rainbow-bg text-white text-xs font-black px-4 py-2 rounded-xl shadow-md hover:opacity-90 transition-all">+ Add to Cart</button>
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
        let reply = "We deliver across eNanda for R30! We sell 5-item Cereal Hampers (R250), Juices Africa 4L (R160), M-Scents perfumes (R120), and daily bakery/pantry packs.";
        const lower = text.toLowerCase();
        if (lower.includes('bread') || lower.includes('oil') || lower.includes('pantry')) {
            reply = "We stock Fresh Daily Bakery Pack (R35) and 5L Cooking Oil + 5kg Maize Meal Combo (R145)!";
        } else if (lower.includes('juice')) {
            reply = "Juices Africa 4L is R160 (makes 20L). Flavors: Guava, Mixed Berry, Cocktail, Tropical Punch.";
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
                name: 'eNanda Web Customer',
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
echo "✅ Real-World Community Products & Infrastructure Connected!"
echo "======================================================="
