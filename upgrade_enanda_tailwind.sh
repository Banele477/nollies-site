#!/data/data/com.termux/files/usr/bin/bash
set -e

cd ~/nollies
echo "🚀 Upgrading Nollie's with Tailwind CSS & eNanda Catalog..."

mkdir -p public/css public/js data

# 1. Generate updated public/index.html with Tailwind CSS
cat << 'HTML' > public/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Nollie's | eNanda Essentials, Juices & Perfumes</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        brand: {
                            50: '#f5f3ff',
                            100: '#ede9fe',
                            500: '#8b5cf6',
                            600: '#7c3aed',
                            700: '#6d28d9',
                            800: '#5b21b6',
                        },
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
<body class="bg-slate-50 text-slate-900 dark:bg-slate-900 dark:text-slate-100 transition-colors duration-200 min-h-screen pb-20">

    <!-- Header Navigation -->
    <header class="sticky top-0 z-40 bg-white/80 dark:bg-slate-800/80 backdrop-blur-md border-b border-slate-200 dark:border-slate-700 px-4 py-3 flex justify-between items-center shadow-sm">
        <div class="flex items-center space-x-2">
            <span class="text-xl font-extrabold tracking-tight text-brand-700 dark:text-brand-500">Nollie's<span class="text-amber-500">.</span></span>
            <span class="bg-brand-100 text-brand-800 dark:bg-brand-900 dark:text-brand-300 text-xs font-semibold px-2.5 py-0.5 rounded-full">eNanda, KZN</span>
        </div>
        <div class="flex items-center space-x-3">
            <button onclick="toggleTheme()" id="theme-btn" class="p-2 rounded-full bg-slate-100 dark:bg-slate-700 text-slate-600 dark:text-slate-300 hover:bg-slate-200">🌙</button>
            <button onclick="toggleCart()" class="relative flex items-center bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-3.5 py-2 rounded-full shadow-md transition-all">
                <span>🛒 Cart</span>
                <span id="cart-count" class="ml-2 bg-amber-500 text-slate-900 text-xs rounded-full h-5 w-5 flex items-center justify-center font-black">0</span>
            </button>
        </div>
    </header>

    <!-- Sub Header Location Bar -->
    <div class="bg-amber-500 text-slate-900 text-xs font-bold text-center py-1.5 px-4 shadow-inner flex justify-between items-center max-w-2xl mx-auto rounded-b-lg">
        <span>📍 Based in eNanda, Durban</span>
        <span>🚚 R30 Local Delivery Fee</span>
    </div>

    <!-- Navigation Tabs -->
    <nav class="flex bg-white dark:bg-slate-800 border-b border-slate-200 dark:border-slate-700 max-w-2xl mx-auto my-3 rounded-xl shadow-sm overflow-x-auto p-1">
        <button class="tab-btn flex-1 py-2 px-3 rounded-lg text-xs font-bold text-brand-600 bg-brand-50 dark:bg-slate-700 dark:text-brand-400 whitespace-nowrap" onclick="switchTab('shop', this)">🛍️ Shop Products</button>
        <button class="tab-btn flex-1 py-2 px-3 rounded-lg text-xs font-semibold text-slate-500 dark:text-slate-400 hover:text-slate-800 whitespace-nowrap" onclick="switchTab('specials', this)">🔥 Special Combos</button>
        <button class="tab-btn flex-1 py-2 px-3 rounded-lg text-xs font-semibold text-slate-500 dark:text-slate-400 hover:text-slate-800 whitespace-nowrap" onclick="switchTab('ai', this)">🤖 Nollie AI</button>
        <button class="tab-btn flex-1 py-2 px-3 rounded-lg text-xs font-semibold text-slate-500 dark:text-slate-400 hover:text-slate-800 whitespace-nowrap" onclick="switchTab('telemetry', this)">📊 Financials</button>
    </nav>

    <!-- Main Views Container -->
    <main class="max-w-2xl mx-auto px-4">

        <!-- SHOP TAB VIEW -->
        <section id="tab-shop" class="tab-content block">
            <!-- Hero Card -->
            <div class="bg-gradient-to-r from-brand-600 to-indigo-700 text-white rounded-2xl p-5 mb-5 shadow-lg">
                <h1 class="text-xl font-black mb-1">Quality Products & Good Services in eNanda</h1>
                <p class="text-xs text-brand-100">5-Item Cereal Hampers, Juices Africa (4L Concentrates making 20L), and M-Scents Perfumes!</p>
            </div>

            <!-- Search Filter -->
            <div class="mb-4">
                <input type="text" id="search-input" placeholder="Search Cereal, Juices Africa, M-Scents..." onkeyup="filterProducts()" 
                       class="w-full px-4 py-2.5 rounded-xl border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs focus:ring-2 focus:ring-brand-500 outline-none shadow-sm">
            </div>

            <!-- Category Selector Buttons -->
            <div class="flex space-x-2 mb-4 overflow-x-auto pb-1">
                <button onclick="filterCategory('all')" class="cat-btn px-3 py-1.5 rounded-lg text-xs font-bold bg-slate-800 text-white">All</button>
                <button onclick="filterCategory('cereal')" class="cat-btn px-3 py-1.5 rounded-lg text-xs font-bold bg-slate-200 dark:bg-slate-700 text-slate-700 dark:text-slate-200">Cereal Hampers</button>
                <button onclick="filterCategory('juice')" class="cat-btn px-3 py-1.5 rounded-lg text-xs font-bold bg-slate-200 dark:bg-slate-700 text-slate-700 dark:text-slate-200">Juices Africa (4L)</button>
                <button onclick="filterCategory('perfume')" class="cat-btn px-3 py-1.5 rounded-lg text-xs font-bold bg-slate-200 dark:bg-slate-700 text-slate-700 dark:text-slate-200">M-Scents Perfumes</button>
            </div>

            <!-- Product Grid -->
            <div class="space-y-4" id="product-list">
                
                <!-- Cereal Package 1 -->
                <div class="product-card bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm" data-cat="cereal" data-name="cereal hamper package 1 jungle oats future life noodles juice corn flakes weet bix">
                    <span class="bg-amber-100 text-amber-800 text-[10px] font-extrabold px-2 py-0.5 rounded-md uppercase">Cereal Hamper • 5 Items</span>
                    <h3 class="text-base font-bold text-slate-800 dark:text-white mt-2">Cereal Hamper - Package 1</h3>
                    <p class="text-xs text-slate-500 dark:text-slate-400 my-2">Includes: Jungle Oats 1kg, Future Life 500g, Kellogg's Noodles (5 Packs) OR Juice (6x300ml), Bokomo Corn Flakes 1kg, Weet-Bix 450g.</p>
                    <div class="flex justify-between items-center border-t border-slate-100 dark:border-slate-700 pt-3">
                        <span class="text-lg font-black text-slate-900 dark:text-white">R 250.00</span>
                        <button onclick="addToCart('Cereal Hamper Package 1', 250)" class="bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-4 py-2 rounded-xl transition-all shadow-sm">+ Add to Cart</button>
                    </div>
                </div>

                <!-- Cereal Package 2 -->
                <div class="product-card bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm" data-cat="cereal" data-name="cereal hamper package 2 corn flakes happy valley rice puffs juice my life porridge noodles">
                    <span class="bg-amber-100 text-amber-800 text-[10px] font-extrabold px-2 py-0.5 rounded-md uppercase">Cereal Hamper • 5 Items</span>
                    <h3 class="text-base font-bold text-slate-800 dark:text-white mt-2">Cereal Hamper - Package 2</h3>
                    <p class="text-xs text-slate-500 dark:text-slate-400 my-2">Includes: Bokomo Corn Flakes 1kg, Happy Valley (Rice Puffs), Juice 6x300ml, My Life Instant Porridge, Kellogg's Noodles (5 Packs).</p>
                    <div class="flex justify-between items-center border-t border-slate-100 dark:border-slate-700 pt-3">
                        <span class="text-lg font-black text-slate-900 dark:text-white">R 250.00</span>
                        <button onclick="addToCart('Cereal Hamper Package 2', 250)" class="bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-4 py-2 rounded-xl transition-all shadow-sm">+ Add to Cart</button>
                    </div>
                </div>

                <!-- Cereal Package 3 -->
                <div class="product-card bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm" data-cat="cereal" data-name="cereal hamper package 3 weet bix corn flakes future life nutrifics noodles">
                    <span class="bg-amber-100 text-amber-800 text-[10px] font-extrabold px-2 py-0.5 rounded-md uppercase">Cereal Hamper • 5 Items</span>
                    <h3 class="text-base font-bold text-slate-800 dark:text-white mt-2">Cereal Hamper - Package 3</h3>
                    <p class="text-xs text-slate-500 dark:text-slate-400 my-2">Includes: Bokomo Weet-Bix 450g, Corn Flakes 1kg, Future Life 500g, Nutrifics 450g, Kellogg's Noodles (5 Packs).</p>
                    <div class="flex justify-between items-center border-t border-slate-100 dark:border-slate-700 pt-3">
                        <span class="text-lg font-black text-slate-900 dark:text-white">R 250.00</span>
                        <button onclick="addToCart('Cereal Hamper Package 3', 250)" class="bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-4 py-2 rounded-xl transition-all shadow-sm">+ Add to Cart</button>
                    </div>
                </div>

                <!-- Cereal Package 4 -->
                <div class="product-card bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm" data-cat="cereal" data-name="cereal hamper package 4 corn flakes weet bix juice future life nutrifics">
                    <span class="bg-amber-100 text-amber-800 text-[10px] font-extrabold px-2 py-0.5 rounded-md uppercase">Cereal Hamper • 5 Items</span>
                    <h3 class="text-base font-bold text-slate-800 dark:text-white mt-2">Cereal Hamper - Package 4</h3>
                    <p class="text-xs text-slate-500 dark:text-slate-400 my-2">Includes: Bokomo Corn Flakes 1kg, Weet-Bix 450g, Juice 6x300ml, Future Life 500g, Nutrifics 450g.</p>
                    <div class="flex justify-between items-center border-t border-slate-100 dark:border-slate-700 pt-3">
                        <span class="text-lg font-black text-slate-900 dark:text-white">R 250.00</span>
                        <button onclick="addToCart('Cereal Hamper Package 4', 250)" class="bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-4 py-2 rounded-xl transition-all shadow-sm">+ Add to Cart</button>
                    </div>
                </div>

                <!-- Juices Africa 4L -->
                <div class="product-card bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm" data-cat="juice" data-name="juices africa 4l concentrate guava mixed berry cocktail tropical punch 20l">
                    <span class="bg-emerald-100 text-emerald-800 text-[10px] font-extrabold px-2 py-0.5 rounded-md uppercase">4L Juice Concentrate (Makes 20L)</span>
                    <h3 class="text-base font-bold text-slate-800 dark:text-white mt-2">Juices Africa (4L Bottle)</h3>
                    <p class="text-xs text-slate-500 dark:text-slate-400 my-1">Yields up to 20 Litres! Choose your flavor upon order:</p>
                    <div class="text-[11px] font-bold text-emerald-600 dark:text-emerald-400 mb-2">• Guava &nbsp;• Mixed Berry &nbsp;• Cocktail &nbsp;• Tropical Punch</div>
                    <div class="flex justify-between items-center border-t border-slate-100 dark:border-slate-700 pt-3">
                        <span class="text-lg font-black text-slate-900 dark:text-white">R 160.00</span>
                        <button onclick="addToCart('Juices Africa 4L', 160)" class="bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-4 py-2 rounded-xl transition-all shadow-sm">+ Add to Cart</button>
                    </div>
                </div>

                <!-- M-Scents Perfumes -->
                <div class="product-card bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm" data-cat="perfume" data-name="m scents perfume 40ml silver sense red dezire white oud blue dezire stallion sky oud gorgeous girl wild intense">
                    <span class="bg-purple-100 text-purple-800 text-[10px] font-extrabold px-2 py-0.5 rounded-md uppercase">M-Scents Brand • 40ml</span>
                    <h3 class="text-base font-bold text-slate-800 dark:text-white mt-2">M-Scents Premium Perfumes (40ml)</h3>
                    <p class="text-xs text-slate-500 dark:text-slate-400 my-1">Long-lasting luxury fragrances. Available scents:</p>
                    <div class="text-[11px] text-purple-600 dark:text-purple-400 mb-2">Silver Sense, Red Dezire, White OUD, Blue Dezire, StallioN for Him, Sky OUD, Gorgeous Girl, Wild Intense.</div>
                    <div class="flex justify-between items-center border-t border-slate-100 dark:border-slate-700 pt-3">
                        <span class="text-lg font-black text-slate-900 dark:text-white">R 120.00</span>
                        <button onclick="addToCart('M-Scents Perfume (40ml)', 120)" class="bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-4 py-2 rounded-xl transition-all shadow-sm">+ Add to Cart</button>
                    </div>
                </div>

            </div>
        </section>

        <!-- SPECIAL COMBOS TAB -->
        <section id="tab-specials" class="tab-content hidden">
            <div class="bg-white dark:bg-slate-800 p-5 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm space-y-4">
                <h2 class="text-lg font-extrabold text-brand-700 dark:text-brand-400">🔥 Exclusive Bundle Discounts</h2>
                <p class="text-xs text-slate-500 dark:text-slate-400">Save big on multi-item purchases directly from Nollie's!</p>

                <div class="p-4 bg-amber-50 dark:bg-slate-700/50 rounded-xl border border-amber-200 dark:border-amber-800">
                    <h4 class="font-bold text-xs text-amber-900 dark:text-amber-300">🌸 2x M-Scents Perfumes Special</h4>
                    <p class="text-xs text-slate-600 dark:text-slate-300">Buy any 2 M-Scents perfumes for only R192 (Save R48!)</p>
                    <button onclick="addToCart('2x M-Scents Perfumes Deal', 192)" class="mt-2 bg-amber-600 text-white text-xs font-bold px-3 py-1.5 rounded-lg">+ Add Deal (R192)</button>
                </div>

                <div class="p-4 bg-emerald-50 dark:bg-slate-700/50 rounded-xl border border-emerald-200 dark:border-emerald-800">
                    <h4 class="font-bold text-xs text-emerald-900 dark:text-emerald-300">🧃 2x Juices Africa (4L) Special</h4>
                    <p class="text-xs text-slate-600 dark:text-slate-300">Buy 2 Juices Africa bottles for R224 (Save R96! Makes 40L Juice)</p>
                    <button onclick="addToCart('2x Juices Africa (4L) Deal', 224)" class="mt-2 bg-emerald-600 text-white text-xs font-bold px-3 py-1.5 rounded-lg">+ Add Deal (R224)</button>
                </div>

                <div class="p-4 bg-purple-50 dark:bg-slate-700/50 rounded-xl border border-purple-200 dark:border-purple-800">
                    <h4 class="font-bold text-xs text-purple-900 dark:text-purple-300">🥣 3-Item Mini Cereal Hamper</h4>
                    <p class="text-xs text-slate-600 dark:text-slate-300">Select any 3 cereal items for R170</p>
                    <button onclick="addToCart('3-Item Mini Cereal Hamper', 170)" class="mt-2 bg-purple-600 text-white text-xs font-bold px-3 py-1.5 rounded-lg">+ Add Deal (R170)</button>
                </div>
            </div>
        </section>

        <!-- AI ASSISTANT TAB -->
        <section id="tab-ai" class="tab-content hidden">
            <div class="bg-white dark:bg-slate-800 p-5 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm">
                <h2 class="text-lg font-bold mb-1">🤖 Nollie's eNanda AI Assistant</h2>
                <p class="text-xs text-slate-500 dark:text-slate-400 mb-3">Ask about products, eNanda delivery fees (R30), or Juices Africa flavors!</p>

                <div id="chat-box" class="bg-slate-50 dark:bg-slate-900 p-3 rounded-xl h-52 overflow-y-auto border border-slate-200 dark:border-slate-700 text-xs space-y-2 mb-3">
                    <div class="bg-brand-100 dark:bg-brand-900/50 p-2 rounded-lg text-slate-800 dark:text-slate-200">
                        <strong>Nollie AI:</strong> Sawubona! Welcome to Nollie's Small Business in eNanda. How can I help you today?
                    </div>
                </div>

                <div class="flex space-x-2">
                    <input type="text" id="chat-input" placeholder="Type a message..." class="flex-1 px-3 py-2 text-xs rounded-xl border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-900 outline-none">
                    <button onclick="sendAiMessage()" class="bg-brand-600 text-white font-bold px-4 py-2 rounded-xl text-xs">Send</button>
                </div>
            </div>
        </section>

        <!-- FINANCIAL & TELEMETRY TAB (FOR COMPETITION DEMO) -->
        <section id="tab-telemetry" class="tab-content hidden">
            <div class="bg-white dark:bg-slate-800 p-5 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm space-y-4">
                <h2 class="text-lg font-bold text-slate-800 dark:text-white">📊 Business Telemetry & Operational Costs</h2>
                <p class="text-xs text-slate-500">Live breakdown of eNanda supply chain dynamics and margin calculations.</p>

                <div class="grid grid-cols-2 gap-3 text-xs">
                    <div class="bg-slate-50 dark:bg-slate-700 p-3 rounded-xl border border-slate-200 dark:border-slate-600">
                        <span class="text-slate-500 dark:text-slate-300 block">Stocking Taxis</span>
                        <strong class="text-sm font-bold text-slate-800 dark:text-white">R 59.00 / trip</strong>
                    </div>
                    <div class="bg-slate-50 dark:bg-slate-700 p-3 rounded-xl border border-slate-200 dark:border-slate-600">
                        <span class="text-slate-500 dark:text-slate-300 block">Return Bolt ride</span>
                        <strong class="text-sm font-bold text-slate-800 dark:text-white">R 53.00 - R 100.00</strong>
                    </div>
                    <div class="bg-slate-50 dark:bg-slate-700 p-3 rounded-xl border border-slate-200 dark:border-slate-600">
                        <span class="text-slate-500 dark:text-slate-300 block">Relative's Car Petrol</span>
                        <strong class="text-sm font-bold text-slate-800 dark:text-white">R 150.00</strong>
                    </div>
                    <div class="bg-slate-50 dark:bg-slate-700 p-3 rounded-xl border border-slate-200 dark:border-slate-600">
                        <span class="text-slate-500 dark:text-slate-300 block">Marketing & Posters</span>
                        <strong class="text-sm font-bold text-slate-800 dark:text-white">R 300.00 / mo</strong>
                    </div>
                </div>

                <div class="p-3 bg-brand-50 dark:bg-brand-900/30 rounded-xl text-xs space-y-1">
                    <p><strong>Cereal Margin:</strong> Cost R180-R200 ➔ Sells R250 (Profit: R50 - R70 / hamper)</p>
                    <p><strong>Perfumes Margin:</strong> 10 Stock for R650 ➔ Sells R120 each (Profit: R55 / bottle)</p>
                    <p><strong>Customer Delivery:</strong> Fixed R30 fee per person in eNanda.</p>
                </div>
            </div>
        </section>

    </main>

    <!-- Cart Overlay Drawer -->
    <div id="cart-modal" class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm z-50 hidden flex-col justify-end">
        <div class="bg-white dark:bg-slate-800 rounded-t-3xl p-5 max-h-[80vh] flex flex-col shadow-2xl">
            <div class="flex justify-between items-center border-b border-slate-200 dark:border-slate-700 pb-3">
                <h3 class="font-extrabold text-base">Your Order Summary</h3>
                <button onclick="toggleCart()" class="text-slate-400 text-xl font-bold">&times;</button>
            </div>
            <div id="cart-items" class="py-4 overflow-y-auto flex-1 space-y-2 text-xs"></div>
            <div class="border-t border-slate-200 dark:border-slate-700 pt-3 space-y-3">
                <div class="flex justify-between text-xs font-bold">
                    <span>Delivery Fee (eNanda):</span>
                    <span>R 30.00</span>
                </div>
                <div class="flex justify-between text-base font-black">
                    <span>Total Amount:</span>
                    <span id="cart-total" class="text-brand-600 dark:text-brand-400">R 30.00</span>
                </div>
                <button onclick="checkoutWhatsApp()" class="w-full bg-wa text-white font-black py-3 rounded-xl flex items-center justify-center space-x-2 text-sm shadow-md">
                    <span>Send Order on WhatsApp 💬</span>
                </button>
            </div>
        </div>
    </div>

    <!-- JavaScript logic -->
    <script>
        let cart = [];
        const deliveryFee = 30;

        function switchTab(tabId, btn) {
            document.querySelectorAll('.tab-btn').forEach(b => {
                b.classList.remove('bg-brand-50', 'text-brand-600', 'font-bold');
                b.classList.add('text-slate-500', 'font-semibold');
            });
            document.querySelectorAll('.tab-content').forEach(c => c.classList.add('hidden'));

            btn.classList.add('bg-brand-50', 'text-brand-600', 'font-bold');
            btn.classList.remove('text-slate-500', 'font-semibold');
            document.getElementById(`tab-${tabId}`).classList.remove('hidden');
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

        function filterProducts() {
            const query = document.getElementById('search-input').value.toLowerCase();
            document.querySelectorAll('.product-card').forEach(card => {
                const name = card.getAttribute('data-name');
                card.style.display = name.includes(query) ? 'block' : 'none';
            });
        }

        function filterCategory(cat) {
            document.querySelectorAll('.cat-btn').forEach(b => {
                b.classList.remove('bg-slate-800', 'text-white');
                b.classList.add('bg-slate-200', 'text-slate-700');
            });
            event.target.classList.add('bg-slate-800', 'text-white');

            document.querySelectorAll('.product-card').forEach(card => {
                if (cat === 'all' || card.getAttribute('data-cat') === cat) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }

        function sendAiMessage() {
            const input = document.getElementById('chat-input');
            const box = document.getElementById('chat-box');
            const text = input.value.trim();
            if (!text) return;

            box.innerHTML += `<div class="text-right"><span class="inline-block bg-brand-600 text-white p-2 rounded-lg">${text}</span></div>`;

            setTimeout(() => {
                let reply = "We deliver across eNanda for R30! We sell 5-item Cereal Hampers (R250), Juices Africa 4L (R160, makes 20L), and M-Scents perfumes (R120).";
                const lower = text.toLowerCase();
                if (lower.includes('juice')) {
                    reply = "Juices Africa comes in 4L bottles for R160 (makes 20L). Flavors: Guava, Mixed Berry, Cocktail, Tropical Punch. Or get 2 for R224!";
                } else if (lower.includes('perfume') || lower.includes('m-scents')) {
                    reply = "M-Scents 40ml perfumes are R120 each or 2 for R192! Flavors include Silver Sense, Red Dezire, White OUD, Blue Dezire, StallioN, Sky OUD, Gorgeous Girl, Wild Intense.";
                } else if (lower.includes('cereal') || lower.includes('hamper')) {
                    reply = "We have 4 different 5-item Cereal Hamper packages for R250 each. We also have a 3-item deal for R170!";
                }
                box.innerHTML += `<div><span class="inline-block bg-slate-200 dark:bg-slate-700 text-slate-800 dark:text-slate-200 p-2 rounded-lg"><strong>Nollie AI:</strong> ${reply}</span></div>`;
                box.scrollTop = box.scrollHeight;
            }, 400);

            input.value = '';
        }

        function checkoutWhatsApp() {
            if (cart.length === 0) return alert('Your cart is empty!');
            let msg = "Hi Nollie's (eNanda), I would like to place an order:%0A%0A";
            let subtotal = 0;
            cart.forEach(item => {
                msg += `• ${item.title} - R${item.price}%0A`;
                subtotal += item.price;
            });
            msg += `%0ADelivery Fee (eNanda): R30%0A*Total Amount: R${(subtotal + 30).toFixed(2)}*`;

            window.open(`https://wa.me/?text=${msg}`, '_blank');
        }
    </script>
</body>
</html>
HTML

cp public/index.html index.html
echo "✅ eNanda catalog and Tailwind CSS upgrade finished!"
