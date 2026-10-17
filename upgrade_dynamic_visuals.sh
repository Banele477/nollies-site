#!/data/data/com.termux/files/usr/bin/bash
set -e

cd ~/nollies
echo "======================================================="
echo "⚡ Upgrading Nollie's with Dynamic Visual Displays..."
echo "======================================================="

mkdir -p public/js public/css

# 1. Update public/index.html with Dynamic Visual Widgets & Chart.js
cat > public/index.html << 'HTML_EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Nollie's | Dynamic eNanda Store & Analytics</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Chart.js for Visual Data Displays -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        brand: { 50: '#f5f3ff', 100: '#ede9fe', 500: '#8b5cf6', 600: '#7c3aed', 700: '#6d28d9', 800: '#5b21b6' },
                        wa: '#25D366'
                    }
                }
            }
        }
    </script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
        .pulse-dot { animation: pulse 2s infinite; }
        @keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.4; } }
    </style>
</head>
<body class="bg-slate-50 text-slate-900 dark:bg-slate-900 dark:text-slate-100 transition-colors duration-200 min-h-screen pb-24">

    <!-- Sticky Header -->
    <header class="sticky top-0 z-40 bg-white/90 dark:bg-slate-800/90 backdrop-blur-md border-b border-slate-200 dark:border-slate-700 px-4 py-3 flex justify-between items-center shadow-sm">
        <div class="flex items-center space-x-2">
            <span class="text-xl font-extrabold tracking-tight text-brand-700 dark:text-brand-400">Nollie's<span class="text-amber-500">.</span></span>
            <span class="bg-emerald-100 text-emerald-800 dark:bg-emerald-900/50 dark:text-emerald-300 text-[10px] font-bold px-2 py-0.5 rounded-full flex items-center gap-1">
                <span class="w-2 h-2 rounded-full bg-emerald-500 pulse-dot"></span> Dynamic Live
            </span>
        </div>
        <div class="flex items-center space-x-2">
            <button onclick="toggleTheme()" id="theme-btn" class="p-2 rounded-full bg-slate-100 dark:bg-slate-700 text-xs">🌙</button>
            <button onclick="toggleCart()" class="relative flex items-center bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-3.5 py-2 rounded-full shadow-md">
                <span>🛒 Cart</span>
                <span id="cart-count" class="ml-1.5 bg-amber-500 text-slate-900 text-[10px] rounded-full h-5 w-5 flex items-center justify-center font-black">0</span>
            </button>
        </div>
    </header>

    <!-- Location Notice -->
    <div class="bg-amber-500 text-slate-900 text-[11px] font-bold text-center py-1.5 px-4 shadow-inner flex justify-between items-center max-w-2xl mx-auto rounded-b-xl">
        <span>📍 Based in eNanda, Durban, KZN</span>
        <span>🚚 Local Delivery: R30</span>
    </div>

    <!-- Navigation Tabs -->
    <nav class="flex bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 max-w-2xl mx-auto my-3 rounded-2xl shadow-sm overflow-x-auto p-1.5 gap-1">
        <button class="tab-btn flex-1 py-2 px-3 rounded-xl text-xs font-bold bg-brand-600 text-white whitespace-nowrap shadow-sm" onclick="switchTab('shop', this)">🛍️ Shop</button>
        <button class="tab-btn flex-1 py-2 px-3 rounded-xl text-xs font-semibold text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-700 whitespace-nowrap" onclick="switchTab('specials', this)">🔥 Specials</button>
        <button class="tab-btn flex-1 py-2 px-3 rounded-xl text-xs font-semibold text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-700 whitespace-nowrap" onclick="switchTab('visuals', this)">📊 Live Analytics</button>
        <button class="tab-btn flex-1 py-2 px-3 rounded-xl text-xs font-semibold text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-700 whitespace-nowrap" onclick="switchTab('ai', this)">🤖 AI Assistant</button>
    </nav>

    <!-- Main Views -->
    <main class="max-w-2xl mx-auto px-4">

        <!-- SHOP TAB -->
        <section id="tab-shop" class="tab-content block space-y-4">
            
            <!-- Live Ticker Banner -->
            <div class="bg-gradient-to-r from-brand-600 to-indigo-700 text-white rounded-2xl p-4 shadow-lg flex justify-between items-center">
                <div>
                    <h1 class="text-base font-black">Dynamic Product Catalog</h1>
                    <p class="text-[11px] text-brand-100">Quality products & good services in eNanda</p>
                </div>
                <div class="text-right">
                    <span class="text-[10px] uppercase font-bold text-brand-200 block">Today's Orders</span>
                    <span id="live-order-counter" class="text-xl font-black text-amber-400">0</span>
                </div>
            </div>

            <!-- Dynamic Search -->
            <input type="text" id="search-input" placeholder="Search cereal, juices africa, m-scents..." onkeyup="filterProducts()" 
                   class="w-full px-4 py-3 rounded-xl border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs focus:ring-2 focus:ring-brand-500 outline-none shadow-sm">

            <!-- Category Filters -->
            <div class="flex space-x-2 overflow-x-auto pb-1 text-xs">
                <button onclick="filterCat('all', this)" class="cat-btn px-3 py-1.5 rounded-xl font-bold bg-slate-900 text-white">All Items</button>
                <button onclick="filterCat('cereal', this)" class="cat-btn px-3 py-1.5 rounded-xl font-semibold bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700">Cereal Hampers</button>
                <button onclick="filterCat('juice', this)" class="cat-btn px-3 py-1.5 rounded-xl font-semibold bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700">Juices Africa (4L)</button>
                <button onclick="filterCat('perfume', this)" class="cat-btn px-3 py-1.5 rounded-xl font-semibold bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700">M-Scents Perfumes</button>
            </div>

            <!-- Dynamic Product Container -->
            <div class="space-y-3" id="product-list">
                <!-- Dynamically generated via JavaScript -->
            </div>
        </section>

        <!-- SPECIALS TAB -->
        <section id="tab-specials" class="tab-content hidden space-y-3">
            <div class="bg-white dark:bg-slate-800 p-5 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm space-y-3">
                <h2 class="text-base font-extrabold text-brand-600">🔥 Dynamic Combo Deals</h2>
                <div class="p-3 bg-purple-50 dark:bg-slate-700/50 rounded-xl border border-purple-200 dark:border-purple-800 flex justify-between items-center">
                    <div>
                        <h4 class="font-bold text-xs">2x M-Scents Perfumes</h4>
                        <p class="text-[11px] text-slate-500">Save R48 on any two 40ml fragrances</p>
                    </div>
                    <button onclick="addToCart('2x M-Scents Perfumes Deal', 192)" class="bg-purple-600 text-white font-bold text-xs px-3 py-2 rounded-xl">R 192</button>
                </div>
                <div class="p-3 bg-emerald-50 dark:bg-slate-700/50 rounded-xl border border-emerald-200 dark:border-emerald-800 flex justify-between items-center">
                    <div>
                        <h4 class="font-bold text-xs">2x Juices Africa (4L)</h4>
                        <p class="text-[11px] text-slate-500">Save R96 (Yields 40L Juice)</p>
                    </div>
                    <button onclick="addToCart('2x Juices Africa Deal', 224)" class="bg-emerald-600 text-white font-bold text-xs px-3 py-2 rounded-xl">R 224</button>
                </div>
                <div class="p-3 bg-amber-50 dark:bg-slate-700/50 rounded-xl border border-amber-200 dark:border-amber-800 flex justify-between items-center">
                    <div>
                        <h4 class="font-bold text-xs">3-Item Mini Cereal Hamper</h4>
                        <p class="text-[11px] text-slate-500">Custom pantry basic combination</p>
                    </div>
                    <button onclick="addToCart('3-Item Mini Hamper', 170)" class="bg-amber-600 text-slate-900 font-bold text-xs px-3 py-2 rounded-xl">R 170</button>
                </div>
            </div>
        </section>

        <!-- LIVE ANALYTICS & VISUAL DISPLAYS TAB -->
        <section id="tab-visuals" class="tab-content hidden space-y-4">
            
            <!-- Real-time Metrics Grid -->
            <div class="grid grid-cols-2 gap-3 text-xs">
                <div class="bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm">
                    <span class="text-slate-400 block font-bold">Total Sales Logged</span>
                    <strong id="visual-revenue" class="text-lg font-black text-emerald-600">R 0.00</strong>
                </div>
                <div class="bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm">
                    <span class="text-slate-400 block font-bold">Estimated Net Profit</span>
                    <strong id="visual-profit" class="text-lg font-black text-brand-600">R 0.00</strong>
                </div>
            </div>

            <!-- Visual Chart 1: Revenue Breakdown -->
            <div class="bg-white dark:bg-slate-800 p-5 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm">
                <h3 class="text-xs font-bold text-slate-700 dark:text-slate-300 mb-3">📈 Sales Distribution by Category</h3>
                <div class="relative h-48">
                    <canvas id="salesChart"></canvas>
                </div>
            </div>

            <!-- Visual Chart 2: Operational Cost Breakdown -->
            <div class="bg-white dark:bg-slate-800 p-5 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm">
                <h3 class="text-xs font-bold text-slate-700 dark:text-slate-300 mb-3">🚚 eNanda Monthly Logistics & Transport Expenses</h3>
                <div class="relative h-48">
                    <canvas id="expensesChart"></canvas>
                </div>
            </div>

        </section>

        <!-- AI ASSISTANT TAB -->
        <section id="tab-ai" class="tab-content hidden space-y-3">
            <div class="bg-white dark:bg-slate-800 p-5 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm">
                <h2 class="text-base font-bold mb-1">🤖 Nollie's AI Assistant</h2>
                <p class="text-xs text-slate-500 mb-3">Ask about eNanda delivery fees (R30), Cereal hampers, or perfume fragrances!</p>

                <div id="chat-box" class="bg-slate-50 dark:bg-slate-900 p-3 rounded-xl h-48 overflow-y-auto border border-slate-200 dark:border-slate-700 text-xs space-y-2 mb-3">
                    <div class="bg-brand-100 dark:bg-brand-900/50 p-2 rounded-lg text-slate-800 dark:text-slate-200">
                        <strong>Nollie AI:</strong> Sawubona! Welcome to Nollie's in eNanda. How can I assist you today?
                    </div>
                </div>

                <div class="flex space-x-2">
                    <input type="text" id="chat-input" placeholder="Type a question..." class="flex-1 px-3 py-2 text-xs rounded-xl border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-900 outline-none">
                    <button onclick="sendAiMessage()" class="bg-brand-600 text-white font-bold px-4 py-2 rounded-xl text-xs">Send</button>
                </div>
            </div>
        </section>

    </main>

    <!-- Cart Overlay -->
    <div id="cart-modal" class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm z-50 hidden flex-col justify-end">
        <div class="bg-white dark:bg-slate-800 rounded-t-3xl p-5 max-h-[80vh] flex flex-col shadow-2xl">
            <div class="flex justify-between items-center border-b border-slate-200 dark:border-slate-700 pb-3">
                <h3 class="font-extrabold text-sm">Your Order Summary</h3>
                <button onclick="toggleCart()" class="text-slate-400 text-lg font-bold">&times;</button>
            </div>
            <div id="cart-items" class="py-3 overflow-y-auto flex-1 space-y-2 text-xs"></div>
            <div class="border-t border-slate-200 dark:border-slate-700 pt-3 space-y-2">
                <div class="flex justify-between text-xs font-bold">
                    <span>Delivery (eNanda):</span>
                    <span>R 30.00</span>
                </div>
                <div class="flex justify-between text-sm font-black">
                    <span>Total Amount:</span>
                    <span id="cart-total" class="text-brand-600 dark:text-brand-400">R 30.00</span>
                </div>
                <button onclick="checkoutWhatsApp()" class="w-full bg-wa text-white font-black py-3 rounded-xl flex items-center justify-center space-x-2 text-xs shadow-md">
                    <span>Send Order on WhatsApp 💬</span>
                </button>
            </div>
        </div>
    </div>

    <!-- Dynamic JavaScript Engine -->
    <script src="js/app.js"></script>
</body>
</html>
HTML_EOF

# 2. Write public/js/app.js with Dynamic Product Rendering & Chart.js Integration
cat > public/js/app.js << 'JS_EOF'
const PRODUCTS = [
    { id: 'c1', cat: 'cereal', title: 'Cereal Hamper - Package 1', price: 250, badge: '5 Items', desc: 'Jungle Oats 1kg, Future Life 500g, Kellogg\'s Noodles (5 Pks) OR Juice (6x300ml), Bokomo Corn Flakes 1kg, Weet-Bix 450g.' },
    { id: 'c2', cat: 'cereal', title: 'Cereal Hamper - Package 2', price: 250, badge: '5 Items', desc: 'Bokomo Corn Flakes 1kg, Happy Valley (Rice Puffs), Juice 6x300ml, My Life Instant Porridge, Kellogg\'s Noodles (5 Pks).' },
    { id: 'c3', cat: 'cereal', title: 'Cereal Hamper - Package 3', price: 250, badge: '5 Items', desc: 'Bokomo Weet-Bix 450g, Corn Flakes 1kg, Future Life 500g, Nutrifics 450g, Kellogg\'s Noodles (5 Pks).' },
    { id: 'c4', cat: 'cereal', title: 'Cereal Hamper - Package 4', price: 250, badge: '5 Items', desc: 'Bokomo Corn Flakes 1kg, Weet-Bix 450g, Juice 6x300ml, Future Life 500g, Nutrifics 450g.' },
    { id: 'j1', cat: 'juice', title: 'Juices Africa (4L Bottle)', price: 160, badge: 'Makes 20L', desc: 'Flavors: Guava, Mixed Berry, Cocktail, Tropical Punch.' },
    { id: 'p1', cat: 'perfume', title: 'M-Scents Premium Perfumes (40ml)', price: 120, badge: '40ml Luxury', desc: 'Silver Sense, Red Dezire, White OUD, Blue Dezire, StallioN, Sky OUD, Gorgeous Girl, Wild Intense.' }
];

let cart = [];
const deliveryFee = 30;
let salesChartInstance = null;
let expensesChartInstance = null;

document.addEventListener('DOMContentLoaded', () => {
    renderProducts(PRODUCTS);
    fetchTelemetryData();
    initCharts();
});

function renderProducts(items) {
    const container = document.getElementById('product-list');
    container.innerHTML = items.map(p => `
        <div class="product-card bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm" data-cat="${p.cat}">
            <span class="bg-amber-100 text-amber-800 text-[10px] font-extrabold px-2.5 py-0.5 rounded-md uppercase">${p.badge}</span>
            <h3 class="text-sm font-bold mt-2 text-slate-800 dark:text-white">${p.title}</h3>
            <p class="text-[11px] text-slate-500 dark:text-slate-400 my-1">${p.desc}</p>
            <div class="flex justify-between items-center border-t border-slate-100 dark:border-slate-700 pt-3 mt-2">
                <span class="text-base font-black text-slate-900 dark:text-white">R ${p.price.toFixed(2)}</span>
                <button onclick="addToCart('${p.title}', ${p.price})" class="bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-4 py-2 rounded-xl shadow-sm">+ Add to Cart</button>
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
            <div class="flex justify-between items-center bg-slate-50 dark:bg-slate-700/50 p-2.5 rounded-xl border border-slate-200 dark:border-slate-700">
                <div>
                    <div class="font-bold">${item.title}</div>
                    <div class="text-slate-500 text-[10px]">R ${item.price.toFixed(2)}</div>
                </div>
                <button onclick="removeFromCart(${index})" class="text-red-500 font-bold px-2">✕</button>
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

function toggleTheme() {
    document.documentElement.classList.toggle('dark');
}

function switchTab(tabId, btn) {
    document.querySelectorAll('.tab-btn').forEach(b => {
        b.classList.remove('bg-brand-600', 'text-white', 'shadow-sm');
        b.classList.add('text-slate-600', 'dark:text-slate-300');
    });
    document.querySelectorAll('.tab-content').forEach(c => c.classList.add('hidden'));

    btn.classList.add('bg-brand-600', 'text-white', 'shadow-sm');
    btn.classList.remove('text-slate-600', 'dark:text-slate-300');
    document.getElementById(`tab-${tabId}`).classList.remove('hidden');

    if (tabId === 'visuals') {
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
        b.classList.remove('bg-slate-900', 'text-white');
        b.classList.add('bg-white', 'dark:bg-slate-800');
    });
    btn.classList.add('bg-slate-900', 'text-white');

    if (cat === 'all') {
        renderProducts(PRODUCTS);
    } else {
        renderProducts(PRODUCTS.filter(p => p.cat === cat));
    }
}

async function fetchTelemetryData() {
    try {
        const res = await fetch('/api/orders', { headers: { 'X-Admin-Key': 'mysecret' } });
        if (res.ok) {
            const orders = await res.json();
            document.getElementById('live-order-counter').innerText = orders.length;
            let totalRev = orders.reduce((sum, o) => sum + (o.total || 0), 0);
            document.getElementById('visual-revenue').innerText = `R ${totalRev.toFixed(2)}`;
            document.getElementById('visual-profit').innerText = `R ${(totalRev * 0.28).toFixed(2)}`;
        }
    } catch (e) {}
}

function initCharts() {
    const ctx1 = document.getElementById('salesChart').getContext('2d');
    salesChartInstance = new Chart(ctx1, {
        type: 'doughnut',
        data: {
            labels: ['Cereal Hampers', 'Juices Africa', 'M-Scents Perfumes'],
            datasets: [{
                data: [50, 30, 20],
                backgroundColor: ['#8b5cf6', '#10b981', '#f59e0b']
            }]
        },
        options: { responsive: true, maintainAspectRatio: false }
    });

    const ctx2 = document.getElementById('expensesChart').getContext('2d');
    expensesChartInstance = new Chart(ctx2, {
        type: 'bar',
        data: {
            labels: ['Taxi (R59)', 'Bolt Return (R80)', 'Petrol (R150)', 'Marketing (R300)'],
            datasets: [{
                label: 'Cost (ZAR)',
                data: [59, 80, 150, 300],
                backgroundColor: '#ef4444'
            }]
        },
        options: { responsive: true, maintainAspectRatio: false }
    });
}

function updateCharts() {
    if (salesChartInstance) salesChartInstance.update();
    if (expensesChartInstance) expensesChartInstance.update();
}

function checkoutWhatsApp() {
    if (cart.length === 0) return alert('Your cart is empty!');
    let msg = "Hi Nollie's (eNanda), I would like to order:%0A%0A";
    let subtotal = 0;
    cart.forEach(item => {
        msg += `• ${item.title} - R${item.price}%0A`;
        subtotal += item.price;
    });
    msg += `%0ADelivery Fee: R30%0A*Total: R${(subtotal + 30).toFixed(2)}*`;

    fetch('/api/order', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name: 'Web Customer', phone: 'WhatsApp', total: subtotal + 30, items: cart })
    }).then(() => fetchTelemetryData()).catch(() => {});

    window.open(`https://wa.me/?text=${msg}`, '_blank');
}
JS_EOF

# 3. Sync public/index.html to root
cp public/index.html index.html 2>/dev/null || true

echo "======================================================="
echo "✅ Dynamic Visual Upgrade Complete!"
echo "======================================================="
