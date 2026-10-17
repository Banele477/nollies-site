#!/data/data/com.termux/files/usr/bin/bash
set -e

cd ~/nollies
echo "☀️ Switching background to clean white..."

# Update public/index.html with a clean white theme
cat > public/index.html << 'HTML_EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Nollie's | eNanda Community Store</title>
    <link rel="manifest" href="/manifest.json">
    <meta name="theme-color" content="#ffffff">
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        body { background-color: #ffffff; color: #0f172a; font-family: 'Inter', sans-serif; }
        .orange-gradient { background: linear-gradient(135deg, #f97316, #ea580c, #c2410c); }
        .orange-text {
            background: linear-gradient(90deg, #f97316, #ea580c, #c2410c);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
    </style>
</head>
<body class="min-h-screen pb-24">

    <!-- Top Orange Bar -->
    <div class="h-1.5 orange-gradient w-full fixed top-0 z-50"></div>

    <!-- Header -->
    <header class="sticky top-1.5 z-40 bg-white/95 backdrop-blur-md border-b border-slate-200 px-4 py-3 flex justify-between items-center shadow-sm">
        <div class="flex items-center space-x-2">
            <span class="text-2xl font-black tracking-tight text-slate-900">Nollie's<span class="text-orange-600">.</span></span>
            <span class="orange-gradient text-white text-[10px] font-black px-2.5 py-0.5 rounded-full shadow-sm">eNanda Hub</span>
        </div>
        <div class="flex items-center space-x-2">
            <button id="install-btn" style="display:none;" onclick="installPWA()" class="bg-orange-600 text-white font-black text-[11px] px-3 py-1.5 rounded-xl shadow-md animate-bounce">📲 Install App</button>
            <button onclick="toggleCart()" class="relative flex items-center orange-gradient text-white text-xs font-black px-4 py-2 rounded-full shadow-md">
                <span>🛒 Cart</span>
                <span id="cart-count" class="ml-2 bg-white text-orange-600 text-[10px] rounded-full h-5 w-5 flex items-center justify-center font-black">0</span>
            </button>
        </div>
    </header>

    <!-- Delivery Notice -->
    <div class="bg-orange-600 text-white text-xs font-black text-center py-2 px-4 flex justify-between items-center max-w-2xl mx-auto shadow-sm">
        <span>📍 eNanda, Durban, KZN</span>
        <span>🚚 Fixed R30 Delivery Fee</span>
    </div>

    <!-- Tabs -->
    <nav class="flex bg-slate-100 border border-slate-200 max-w-2xl mx-auto my-3 rounded-2xl shadow-sm p-1.5 gap-1 overflow-x-auto">
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-black orange-gradient text-white whitespace-nowrap text-center shadow-md" onclick="switchTab('shop', this)">🛍️ Shop</button>
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-bold text-slate-600 hover:text-slate-900 whitespace-nowrap text-center" onclick="switchTab('specials', this)">🔥 Combos</button>
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-bold text-slate-600 hover:text-slate-900 whitespace-nowrap text-center" onclick="switchTab('analytics', this)">📊 Telemetry</button>
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-bold text-slate-600 hover:text-slate-900 whitespace-nowrap text-center" onclick="switchTab('ai', this)">🤖 AI Help</button>
    </nav>

    <!-- Main Container -->
    <main class="max-w-2xl mx-auto px-4">

        <!-- SHOP TAB -->
        <section id="tab-shop" class="tab-content block space-y-4">
            <div class="rounded-2xl border border-slate-200 p-5 shadow-sm bg-slate-50">
                <h1 class="text-xl font-black mb-1 orange-text">Quality Products & Good Services</h1>
                <p class="text-xs text-slate-600">Tap '+ Add' to put items in your cart and check out instantly on WhatsApp.</p>
            </div>

            <input type="text" id="search-input" placeholder="🔍 Search cereal, juice, perfume, bread..." onkeyup="filterProducts()" 
                   class="w-full px-4 py-3.5 rounded-2xl border border-slate-300 bg-white text-slate-900 placeholder-slate-400 text-xs focus:ring-2 focus:ring-orange-500 outline-none shadow-sm">

            <!-- Filter Pills -->
            <div class="flex space-x-2 overflow-x-auto pb-1 text-xs">
                <button onclick="filterCat('all', this)" class="cat-btn px-4 py-2 rounded-xl font-black orange-gradient text-white shadow-sm">All Items</button>
                <button onclick="filterCat('cereal', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-100 text-slate-700 border border-slate-200">Cereal Hampers</button>
                <button onclick="filterCat('juice', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-100 text-slate-700 border border-slate-200">Juices Africa</button>
                <button onclick="filterCat('perfume', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-100 text-slate-700 border border-slate-200">M-Scents</button>
                <button onclick="filterCat('essentials', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-100 text-slate-700 border border-slate-200">Pantry</button>
            </div>

            <!-- Products Grid -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4" id="product-list"></div>
        </section>

        <!-- SPECIALS TAB -->
        <section id="tab-specials" class="tab-content hidden space-y-3">
            <div class="bg-slate-50 p-5 rounded-2xl border border-slate-200 shadow-sm space-y-3">
                <h2 class="text-lg font-black orange-text">🔥 Exclusive Bundle Savings</h2>
                <div class="p-3.5 bg-white rounded-xl border border-slate-200 flex justify-between items-center shadow-sm">
                    <div>
                        <h4 class="font-black text-xs text-orange-600">2x M-Scents Perfumes Deal</h4>
                        <p class="text-[11px] text-slate-500">Save R48 on any two 40ml luxury fragrances</p>
                    </div>
                    <button onclick="addToCart('2x M-Scents Perfumes Deal', 192)" class="orange-gradient text-white font-black text-xs px-4 py-2 rounded-xl">R 192</button>
                </div>
                <div class="p-3.5 bg-white rounded-xl border border-slate-200 flex justify-between items-center shadow-sm">
                    <div>
                        <h4 class="font-black text-xs text-orange-600">2x Juices Africa (4L) Deal</h4>
                        <p class="text-[11px] text-slate-500">Save R96 (Yields 40L Juice)</p>
                    </div>
                    <button onclick="addToCart('2x Juices Africa Deal', 224)" class="orange-gradient text-white font-black text-xs px-4 py-2 rounded-xl">R 224</button>
                </div>
                <div class="p-3.5 bg-white rounded-xl border border-slate-200 flex justify-between items-center shadow-sm">
                    <div>
                        <h4 class="font-black text-xs text-orange-600">3-Item Cereal Mini Combo</h4>
                        <p class="text-[11px] text-slate-500">Custom pantry basic selection</p>
                    </div>
                    <button onclick="addToCart('3-Item Mini Hamper', 170)" class="orange-gradient text-white font-black text-xs px-4 py-2 rounded-xl">R 170</button>
                </div>
            </div>
        </section>

        <!-- ANALYTICS TAB -->
        <section id="tab-analytics" class="tab-content hidden space-y-4">
            <div class="bg-slate-50 p-5 rounded-2xl border border-slate-200 shadow-sm space-y-3">
                <h2 class="text-base font-black text-slate-900">📊 Flask API Live Telemetry</h2>
                <div class="relative h-52">
                    <canvas id="salesChart"></canvas>
                </div>
            </div>
        </section>

        <!-- AI ASSISTANT TAB -->
        <section id="tab-ai" class="tab-content hidden space-y-3">
            <div class="bg-slate-50 p-5 rounded-2xl border border-slate-200 shadow-sm">
                <h2 class="text-base font-black mb-1 text-slate-900">🤖 Nollie's AI Assistant</h2>
                <div id="chat-box" class="bg-white p-3 rounded-xl h-52 overflow-y-auto border border-slate-200 text-xs space-y-2 mb-3 shadow-inner">
                    <div class="bg-slate-100 p-2.5 rounded-lg text-slate-800 border border-slate-200">
                        <strong>Nollie AI:</strong> Sawubona! Ask me about products, offline app installation, or eNanda delivery!
                    </div>
                </div>
                <div class="flex space-x-2">
                    <input type="text" id="chat-input" placeholder="Type your question..." class="flex-1 px-3.5 py-2.5 text-xs rounded-xl border border-slate-300 bg-white text-slate-900 outline-none shadow-sm">
                    <button onclick="sendAiMessage()" class="orange-gradient text-white font-black px-4 py-2.5 rounded-xl text-xs">Send</button>
                </div>
            </div>
        </section>

    </main>

    <!-- Cart Drawer -->
    <div id="cart-modal" class="fixed inset-0 bg-slate-950/60 backdrop-blur-sm z-50 hidden flex-col justify-end">
        <div class="bg-white rounded-t-3xl p-5 border-t border-slate-200 max-h-[85vh] flex flex-col shadow-2xl">
            <div class="flex justify-between items-center border-b border-slate-200 pb-3">
                <h3 class="font-black text-sm text-slate-900">Your Order Summary</h3>
                <button onclick="toggleCart()" class="text-slate-400 text-xl font-bold">&times;</button>
            </div>
            <div id="cart-items" class="py-3 overflow-y-auto flex-1 space-y-2 text-xs"></div>
            <div class="border-t border-slate-200 pt-3 space-y-3">
                <div class="flex justify-between text-xs font-bold text-slate-500">
                    <span>Delivery Fee (eNanda):</span>
                    <span>R 30.00</span>
                </div>
                <div class="flex justify-between text-base font-black text-slate-900">
                    <span>Total Amount:</span>
                    <span id="cart-total" class="orange-text">R 30.00</span>
                </div>
                <button onclick="checkoutWhatsApp()" class="w-full bg-emerald-600 text-white font-black py-3.5 rounded-2xl flex items-center justify-center space-x-2 text-sm shadow-md">
                    <span>Send Order on WhatsApp 💬</span>
                </button>
            </div>
        </div>
    </div>

    <script src="js/app.js"></script>
</body>
</html>
HTML_EOF

cp public/index.html index.html 2>/dev/null || true
echo "✅ Clean white theme applied!"
