#!/data/data/com.termux/files/usr/bin/bash
set -e

cd ~/nollies
echo "🛠️ Replacing broken layout with full Tailwind CSS web app..."

# Overwrite public/index.html with full Tailwind styling
cat > public/index.html << 'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Nollie's | eNanda Community Hub</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Chart.js CDN -->
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
    </style>
</head>
<body class="bg-slate-50 text-slate-900 dark:bg-slate-900 dark:text-slate-100 transition-colors duration-200 min-h-screen pb-24">

    <!-- Header Navigation -->
    <header class="sticky top-0 z-40 bg-white/90 dark:bg-slate-800/90 backdrop-blur-md border-b border-slate-200 dark:border-slate-700 px-4 py-3 flex justify-between items-center shadow-sm">
        <div class="flex items-center space-x-2">
            <span class="text-xl font-extrabold tracking-tight text-brand-700 dark:text-brand-400">Nollie's<span class="text-amber-500">.</span></span>
            <span class="bg-brand-100 text-brand-800 dark:bg-brand-900 dark:text-brand-300 text-[10px] font-bold px-2 py-0.5 rounded-full">eNanda, Durban</span>
        </div>
        <div class="flex items-center space-x-2">
            <button onclick="toggleTheme()" id="theme-btn" class="p-2 rounded-full bg-slate-100 dark:bg-slate-700 text-xs">🌙</button>
            <button onclick="toggleCart()" class="relative flex items-center bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-3.5 py-2 rounded-full shadow-md">
                <span>🛒 Cart</span>
                <span id="cart-count" class="ml-1.5 bg-amber-500 text-slate-900 text-[10px] rounded-full h-5 w-5 flex items-center justify-center font-black">0</span>
            </button>
        </div>
    </header>

    <!-- Location & Delivery Notice -->
    <div class="bg-amber-500 text-slate-900 text-[11px] font-bold text-center py-1.5 px-4 shadow-inner flex justify-between items-center max-w-2xl mx-auto rounded-b-xl">
        <span>📍 Based in eNanda, Durban, KZN</span>
        <span>🚚 Local Delivery: R30</span>
    </div>

    <!-- Navigation Tabs -->
    <nav class="flex bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 max-w-2xl mx-auto my-3 rounded-2xl shadow-sm overflow-x-auto p-1.5 gap-1">
        <button class="tab-btn flex-1 py-2 px-3 rounded-xl text-xs font-bold bg-brand-600 text-white whitespace-nowrap shadow-sm" onclick="switchTab('shop', this)">🛍️ Shop</button>
        <button class="tab-btn flex-1 py-2 px-3 rounded-xl text-xs font-semibold text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-700 whitespace-nowrap" onclick="switchTab('specials', this)">🔥 Deals</button>
        <button class="tab-btn flex-1 py-2 px-3 rounded-xl text-xs font-semibold text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-700 whitespace-nowrap" onclick="switchTab('analytics', this)">📊 Analytics</button>
        <button class="tab-btn flex-1 py-2 px-3 rounded-xl text-xs font-semibold text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-700 whitespace-nowrap" onclick="switchTab('ai', this)">🤖 AI Assistant</button>
    </nav>

    <!-- Main Container -->
    <main class="max-w-2xl mx-auto px-4">

        <!-- SHOP TAB -->
        <section id="tab-shop" class="tab-content block space-y-4">
            <div class="bg-gradient-to-r from-brand-600 to-indigo-700 text-white rounded-2xl p-5 shadow-lg">
                <h1 class="text-lg font-black mb-1">Quality Products & Good Services</h1>
                <p class="text-xs text-brand-100">5-Item Cereal Hampers, Juices Africa (4L making 20L), and M-Scents Perfumes.</p>
            </div>

            <!-- Search -->
            <input type="text" id="search-input" placeholder="Search cereal, juices africa, m-scents..." onkeyup="filterProducts()" 
                   class="w-full px-4 py-3 rounded-xl border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs focus:ring-2 focus:ring-brand-500 outline-none shadow-sm">

            <!-- Category Selector -->
            <div class="flex space-x-2 overflow-x-auto pb-1 text-xs">
                <button onclick="filterCat('all')" class="cat-btn px-3 py-1.5 rounded-xl font-bold bg-slate-900 text-white">All Items</button>
                <button onclick="filterCat('cereal')" class="cat-btn px-3 py-1.5 rounded-xl font-semibold bg-white dark:bg-slate-800 border">Cereal Hampers</button>
                <button onclick="filterCat('juice')" class="cat-btn px-3 py-1.5 rounded-xl font-semibold bg-white dark:bg-slate-800 border">Juices Africa (4L)</button>
                <button onclick="filterCat('perfume')" class="cat-btn px-3 py-1.5 rounded-xl font-semibold bg-white dark:bg-slate-800 border">M-Scents Perfumes</button>
            </div>

            <!-- Product Grid -->
            <div class="space-y-3" id="product-list">
                <!-- Package 1 -->
                <div class="product-card bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm" data-cat="cereal">
                    <span class="bg-amber-100 text-amber-800 text-[10px] font-extrabold px-2.5 py-0.5 rounded-md uppercase">Cereal Hamper • 5 Items</span>
                    <h3 class="text-sm font-bold mt-2">Cereal Hamper - Package 1</h3>
                    <p class="text-[11px] text-slate-500 dark:text-slate-400 my-1">Jungle Oats 1kg, Future Life 500g, Kellogg's Noodles (5 Pks) OR Juice (6x300ml), Bokomo Corn Flakes 1kg, Weet-Bix 450g.</p>
                    <div class="flex justify-between items-center border-t border-slate-100 dark:border-slate-700 pt-3 mt-2">
                        <span class="text-base font-black text-slate-900 dark:text-white">R 250.00</span>
                        <button onclick="addToCart('Cereal Hamper Package 1', 250)" class="bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-4 py-2 rounded-xl shadow-sm">+ Add to Cart</button>
                    </div>
                </div>

                <!-- Package 2 -->
                <div class="product-card bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm" data-cat="cereal">
                    <span class="bg-amber-100 text-amber-800 text-[10px] font-extrabold px-2.5 py-0.5 rounded-md uppercase">Cereal Hamper • 5 Items</span>
                    <h3 class="text-sm font-bold mt-2">Cereal Hamper - Package 2</h3>
                    <p class="text-[11px] text-slate-500 dark:text-slate-400 my-1">Bokomo Corn Flakes 1kg, Happy Valley (Rice Puffs), Juice 6x300ml, My Life Instant Porridge, Kellogg's Noodles (5 Pks).</p>
                    <div class="flex justify-between items-center border-t border-slate-100 dark:border-slate-700 pt-3 mt-2">
                        <span class="text-base font-black text-slate-900 dark:text-white">R 250.00</span>
                        <button onclick="addToCart('Cereal Hamper Package 2', 250)" class="bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-4 py-2 rounded-xl shadow-sm">+ Add to Cart</button>
                    </div>
                </div>

                <!-- Package 3 -->
                <div class="product-card bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm" data-cat="cereal">
                    <span class="bg-amber-100 text-amber-800 text-[10px] font-extrabold px-2.5 py-0.5 rounded-md uppercase">Cereal Hamper • 5 Items</span>
                    <h3 class="text-sm font-bold mt-2">Cereal Hamper - Package 3</h3>
                    <p class="text-[11px] text-slate-500 dark:text-slate-400 my-1">Bokomo Weet-Bix 450g, Corn Flakes 1kg, Future Life 500g, Nutrifics 450g, Kellogg's Noodles (5 Pks).</p>
                    <div class="flex justify-between items-center border-t border-slate-100 dark:border-slate-700 pt-3 mt-2">
                        <span class="text-base font-black text-slate-900 dark:text-white">R 250.00</span>
                        <button onclick="addToCart('Cereal Hamper Package 3', 250)" class="bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-4 py-2 rounded-xl shadow-sm">+ Add to Cart</button>
                    </div>
                </div>

                <!-- Package 4 -->
                <div class="product-card bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm" data-cat="cereal">
                    <span class="bg-amber-100 text-amber-800 text-[10px] font-extrabold px-2.5 py-0.5 rounded-md uppercase">Cereal Hamper • 5 Items</span>
                    <h3 class="text-sm font-bold mt-2">Cereal Hamper - Package 4</h3>
                    <p class="text-[11px] text-slate-500 dark:text-slate-400 my-1">Bokomo Corn Flakes 1kg, Weet-Bix 450g, Juice 6x300ml, Future Life 500g, Nutrifics 450g.</p>
                    <div class="flex justify-between items-center border-t border-slate-100 dark:border-slate-700 pt-3 mt-2">
                        <span class="text-base font-black text-slate-900 dark:text-white">R 250.00</span>
                        <button onclick="addToCart('Cereal Hamper Package 4', 250)" class="bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-4 py-2 rounded-xl shadow-sm">+ Add to Cart</button>
                    </div>
                </div>

                <!-- Juices Africa -->
                <div class="product-card bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm" data-cat="juice">
                    <span class="bg-emerald-100 text-emerald-800 text-[10px] font-extrabold px-2.5 py-0.5 rounded-md uppercase">4L Juice Concentrate (Makes 20L)</span>
                    <h3 class="text-sm font-bold mt-2">Juices Africa (4L Bottle)</h3>
                    <p class="text-[11px] text-slate-500 dark:text-slate-400 my-1">Flavors: Guava, Mixed Berry, Cocktail, Tropical Punch.</p>
                    <div class="flex justify-between items-center border-t border-slate-100 dark:border-slate-700 pt-3 mt-2">
                        <span class="text-base font-black text-slate-900 dark:text-white">R 160.00</span>
                        <button onclick="addToCart('Juices Africa 4L', 160)" class="bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-4 py-2 rounded-xl shadow-sm">+ Add to Cart</button>
                    </div>
                </div>

                <!-- M-Scents Perfumes -->
                <div class="product-card bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm" data-cat="perfume">
                    <span class="bg-purple-100 text-purple-800 text-[10px] font-extrabold px-2.5 py-0.5 rounded-md uppercase">M-Scents Brand • 40ml</span>
                    <h3 class="text-sm font-bold mt-2">M-Scents Premium Perfumes (40ml)</h3>
                    <p class="text-[11px] text-slate-500 dark:text-slate-400 my-1">Silver Sense, Red Dezire, White OUD, Blue Dezire, StallioN, Sky OUD, Gorgeous Girl, Wild Intense.</p>
                    <div class="flex justify-between items-center border-t border-slate-100 dark:border-slate-700 pt-3 mt-2">
                        <span class="text-base font-black text-slate-900 dark:text-white">R 120.00</span>
                        <button onclick="addToCart('M-Scents Perfume (40ml)', 120)" class="bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-4 py-2 rounded-xl shadow-sm">+ Add to Cart</button>
                    </div>
                </div>
            </div>
        </section>

        <!-- SPECIALS TAB -->
        <section id="tab-specials" class="tab-content hidden space-y-3">
            <div class="bg-white dark:bg-slate-800 p-5 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm space-y-3">
                <h2 class="text-base font-extrabold text-brand-600">🔥 Bundle Discounts</h2>
                <div class="p-3 bg-purple-50 dark:bg-slate-700/50 rounded-xl border flex justify-between items-center">
                    <div>
                        <h4 class="font-bold text-xs">2x M-Scents Perfumes</h4>
                        <p class="text-[11px] text-slate-500">Save R48 on any two 40ml bottles</p>
                    </div>
                    <button onclick="addToCart('2x M-Scents Perfumes Deal', 192)" class="bg-purple-600 text-white font-bold text-xs px-3 py-2 rounded-xl">R 192</button>
                </div>
                <div class="p-3 bg-emerald-50 dark:bg-slate-700/50 rounded-xl border flex justify-between items-center">
                    <div>
                        <h4 class="font-bold text-xs">2x Juices Africa (4L)</h4>
                        <p class="text-[11px] text-slate-500">Save R96 (Yields 40L Juice)</p>
                    </div>
                    <button onclick="addToCart('2x Juices Africa Deal', 224)" class="bg-emerald-600 text-white font-bold text-xs px-3 py-2 rounded-xl">R 224</button>
                </div>
                <div class="p-3 bg-amber-50 dark:bg-slate-700/50 rounded-xl border flex justify-between items-center">
                    <div>
                        <h4 class="font-bold text-xs">3-Item Mini Cereal Hamper</h4>
                        <p class="text-[11px] text-slate-500">Custom pantry basic combination</p>
                    </div>
                    <button onclick="addToCart('3-Item Mini Hamper', 170)" class="bg-amber-600 text-slate-900 font-bold text-xs px-3 py-2 rounded-xl">R 170</button>
                </div>
            </div>
        </section>

        <!-- ANALYTICS TAB -->
        <section id="tab-analytics" class="tab-content hidden space-y-4">
            <div class="bg-white dark:bg-slate-800 p-5 rounded-2xl border shadow-sm">
                <h2 class="text-base font-bold mb-3">📊 Live System Analytics</h2>
                <div class="relative h-48">
                    <canvas id="salesChart"></canvas>
                </div>
            </div>
        </section>

        <!-- AI ASSISTANT TAB -->
        <section id="tab-ai" class="tab-content hidden space-y-3">
            <div class="bg-white dark:bg-slate-800 p-5 rounded-2xl border shadow-sm">
                <h2 class="text-base font-bold mb-1">🤖 Nollie's AI Assistant</h2>
                <div id="chat-box" class="bg-slate-50 dark:bg-slate-900 p-3 rounded-xl h-48 overflow-y-auto border text-xs space-y-2 mb-3">
                    <div class="bg-brand-100 p-2 rounded-lg text-slate-800">
                        <strong>Nollie AI:</strong> Sawubona! How can I help you today?
                    </div>
                </div>
                <div class="flex space-x-2">
                    <input type="text" id="chat-input" placeholder="Ask a question..." class="flex-1 px-3 py-2 text-xs rounded-xl border outline-none">
                    <button onclick="sendAiMessage()" class="bg-brand-600 text-white font-bold px-4 py-2 rounded-xl text-xs">Send</button>
                </div>
            </div>
        </section>

    </main>

    <!-- Cart Overlay -->
    <div id="cart-modal" class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm z-50 hidden flex-col justify-end">
        <div class="bg-white dark:bg-slate-800 rounded-t-3xl p-5 max-h-[80vh] flex flex-col shadow-2xl">
            <div class="flex justify-between items-center border-b pb-3">
                <h3 class="font-extrabold text-sm">Your Cart Summary</h3>
                <button onclick="toggleCart()" class="text-slate-400 text-lg font-bold">&times;</button>
            </div>
            <div id="cart-items" class="py-3 overflow-y-auto flex-1 space-y-2 text-xs"></div>
            <div class="border-t pt-3 space-y-2">
                <div class="flex justify-between text-xs font-bold">
                    <span>Delivery (eNanda):</span>
                    <span>R 30.00</span>
                </div>
                <div class="flex justify-between text-sm font-black">
                    <span>Total Amount:</span>
                    <span id="cart-total" class="text-brand-600">R 30.00</span>
                </div>
                <button onclick="checkoutWhatsApp()" class="w-full bg-wa text-white font-black py-3 rounded-xl flex items-center justify-center space-x-2 text-xs shadow-md">
                    <span>Send Order on WhatsApp 💬</span>
                </button>
            </div>
        </div>
    </div>

    <script src="js/app.js"></script>
</body>
</html>
HTML

# Overwrite root index.html to eliminate cache mismatch
cp public/index.html index.html

echo "======================================================="
echo "✅ Layout fixed with Tailwind CSS & direct JS Engine!"
echo "======================================================="
