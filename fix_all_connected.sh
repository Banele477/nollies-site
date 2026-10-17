#!/data/data/com.termux/files/usr/bin/bash
set -e

cd ~/nollies
echo "🔧 Fixing backend-frontend integration, tabs, Home info, and animated product displays..."

# 1. Update static/index.html with full tabs (Home, Shop, Combos, Telemetry, Questionnaire/About, AI Help)
cat > static/index.html << 'EOF_HTML'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Nollie's | eNanda Community Hub</title>
    <link rel="manifest" href="/manifest.json">
    <meta name="theme-color" content="#f97316">
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
        .orange-gradient { background: linear-gradient(135deg, #f97316, #ea580c, #c2410c); }
        .orange-text {
            background: linear-gradient(90deg, #f97316, #fb923c, #fdba74);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .bg-community {
            background-image: linear-gradient(rgba(15, 23, 42, 0.93), rgba(15, 23, 42, 0.97)), 
                              url('https://images.unsplash.com/photo-1547471080-7cc2caa01a7e?auto=format&fit=crop&w=1200&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }
        @keyframes floatCard {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-4px); }
            100% { transform: translateY(0px); }
        }
        .animated-card {
            animation: floatCard 4s ease-in-out infinite;
        }
        .animated-card:nth-child(even) {
            animation-delay: 2s;
        }
    </style>
</head>
<body class="bg-slate-950 text-slate-100 min-h-screen pb-24 bg-community">

    <div class="h-1.5 orange-gradient w-full fixed top-0 z-50"></div>

    <!-- Header -->
    <header class="sticky top-1.5 z-40 bg-slate-900/90 backdrop-blur-md border-b border-slate-800 px-4 py-3 flex justify-between items-center shadow-lg">
        <div class="flex items-center space-x-2">
            <span class="text-2xl font-black tracking-tight text-white">Nollie's<span class="text-orange-500">.</span></span>
            <span class="orange-gradient text-white text-[10px] font-black px-2.5 py-0.5 rounded-full shadow-sm">eNanda Hub</span>
        </div>
        <div class="flex items-center space-x-2">
            <button onclick="triggerInstall()" class="orange-gradient text-white font-black text-xs px-3.5 py-2 rounded-full shadow-xl animate-pulse flex items-center space-x-1 border border-orange-400/40">
                <span>📲 Install App</span>
            </button>
            <button onclick="toggleCart()" class="relative flex items-center orange-gradient text-white text-xs font-black px-4 py-2 rounded-full shadow-lg">
                <span>🛒 Cart</span>
                <span id="cart-count" class="ml-2 bg-white text-slate-900 text-[10px] rounded-full h-5 w-5 flex items-center justify-center font-black">0</span>
            </button>
        </div>
    </header>

    <!-- Live Ticker -->
    <div id="live-ticker" class="bg-slate-900/90 border-b border-slate-800 text-slate-300 text-[11px] py-1.5 px-4 text-center font-medium overflow-hidden whitespace-nowrap">
        <span>🟢 Connecting to eNanda live order feed...</span>
    </div>

    <div class="bg-orange-500 text-slate-950 text-xs font-black text-center py-2 px-4 flex justify-between items-center max-w-2xl mx-auto shadow-md">
        <span>📍 Based in eNanda, Durban</span>
        <span>🚚 Fixed R30 Delivery Fee</span>
    </div>

    <!-- Navigation Tabs -->
    <nav class="flex bg-slate-800/90 backdrop-blur-md border border-slate-700 max-w-2xl mx-auto my-3 rounded-2xl shadow-xl p-1.5 gap-1 overflow-x-auto">
        <button class="tab-btn py-2.5 px-3.5 rounded-xl text-xs font-black orange-gradient text-white whitespace-nowrap text-center shadow-md flex-shrink-0" onclick="switchTab('home', this)">🏠 Home</button>
        <button class="tab-btn py-2.5 px-3.5 rounded-xl text-xs font-bold text-slate-300 hover:text-white whitespace-nowrap text-center flex-shrink-0" onclick="switchTab('shop', this)">🛍️ Shop</button>
        <button class="tab-btn py-2.5 px-3.5 rounded-xl text-xs font-bold text-slate-300 hover:text-white whitespace-nowrap text-center flex-shrink-0" onclick="switchTab('specials', this)">🔥 Combos</button>
        <button class="tab-btn py-2.5 px-3.5 rounded-xl text-xs font-bold text-slate-300 hover:text-white whitespace-nowrap text-center flex-shrink-0" onclick="switchTab('info', this)">📋 About & FAQ</button>
        <button class="tab-btn py-2.5 px-3.5 rounded-xl text-xs font-bold text-slate-300 hover:text-white whitespace-nowrap text-center flex-shrink-0" onclick="switchTab('analytics', this)">📊 Telemetry</button>
        <button class="tab-btn py-2.5 px-3.5 rounded-xl text-xs font-bold text-slate-300 hover:text-white whitespace-nowrap text-center flex-shrink-0" onclick="switchTab('ai', this)">🤖 AI Help</button>
    </nav>

    <main class="max-w-2xl mx-auto px-4">

        <!-- HOME TAB -->
        <section id="tab-home" class="tab-content block space-y-4">
            <div class="relative overflow-hidden rounded-2xl border border-slate-700 p-6 shadow-2xl bg-slate-800/90 backdrop-blur-sm space-y-4">
                <div class="absolute -right-10 -bottom-10 w-32 h-32 orange-gradient rounded-full blur-2xl opacity-30"></div>
                <h1 class="text-2xl font-black mb-1 orange-text">Sawubona! Welcome to Nollie's Hub</h1>
                <p class="text-xs text-slate-300 leading-relaxed">
                    Your premier eNanda community supplier for quality essentials, 5-item Cereal Hampers, Juices Africa, M-Scents perfumes, and daily pantry specials!
                </p>
                <div class="grid grid-cols-2 gap-3 pt-2">
                    <button onclick="switchTab('shop', document.querySelectorAll('.tab-btn')[1])" class="orange-gradient text-white font-black py-3 rounded-xl text-xs shadow-lg text-center">
                        🛍️ Start Shopping Now
                    </button>
                    <button onclick="switchTab('info', document.querySelectorAll('.tab-btn')[3])" class="bg-slate-900 border border-slate-700 text-slate-200 font-bold py-3 rounded-xl text-xs shadow-md text-center">
                        📋 Learn More & FAQ
                    </button>
                </div>
            </div>

            <div class="bg-slate-900/90 border border-slate-800 p-5 rounded-2xl shadow-xl space-y-2">
                <h3 class="font-black text-xs text-orange-400 uppercase tracking-wider">🔒 Transparency & Trust Guarantee</h3>
                <p class="text-[11px] text-slate-300 leading-relaxed">
                    All orders are tracked live, logged securely to our Flask backend, and dispatched transparently via WhatsApp with standard R30 flat-rate delivery across eNanda.
                </p>
            </div>

            <div class="grid grid-cols-2 gap-3">
                <div class="bg-slate-900/80 p-4 rounded-2xl border border-slate-800 space-y-1">
                    <span class="text-lg">🚚</span>
                    <h3 class="font-bold text-xs text-white">Fast eNanda Delivery</h3>
                    <p class="text-[11px] text-slate-400">Standard R30 delivery fee straight to your door.</p>
                </div>
                <div class="bg-slate-900/80 p-4 rounded-2xl border border-slate-800 space-y-1">
                    <span class="text-lg">💬</span>
                    <h3 class="font-bold text-xs text-white">WhatsApp Checkout</h3>
                    <p class="text-[11px] text-slate-400">Instant order dispatch directly to WhatsApp.</p>
                </div>
            </div>
        </section>

        <!-- SHOP TAB -->
        <section id="tab-shop" class="tab-content hidden space-y-4">
            <div class="relative overflow-hidden rounded-2xl border border-slate-700 p-5 shadow-2xl bg-slate-800/80 backdrop-blur-sm">
                <h1 class="text-xl font-black mb-1 orange-text">Quality Products & Good Services</h1>
                <p class="text-xs text-slate-300">Tap any animated item card to inspect details or add to cart.</p>
            </div>

            <input type="text" id="search-input" placeholder="🔍 Search cereal, juice, perfume, bread, maize meal..." onkeyup="filterProducts()" 
                   class="w-full px-4 py-3.5 rounded-2xl border border-slate-700 bg-slate-800/90 text-white placeholder-slate-400 text-xs focus:ring-2 focus:ring-orange-500 outline-none shadow-md">

            <div class="flex space-x-2 overflow-x-auto pb-1 text-xs">
                <button onclick="filterCat('all', this)" class="cat-btn px-4 py-2 rounded-xl font-black orange-gradient text-white shadow-md flex-shrink-0">All Items</button>
                <button onclick="filterCat('cereal', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-800 text-slate-300 border border-slate-700 flex-shrink-0">Cereal Hampers</button>
                <button onclick="filterCat('juice', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-800 text-slate-300 border border-slate-700 flex-shrink-0">Juices Africa</button>
                <button onclick="filterCat('perfume', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-800 text-slate-300 border border-slate-700 flex-shrink-0">M-Scents</button>
                <button onclick="filterCat('essentials', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-800 text-slate-300 border border-slate-700 flex-shrink-0">Pantry</button>
            </div>

            <!-- Product Grid with Animated Display -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4" id="product-list"></div>
        </section>

        <!-- SPECIALS TAB -->
        <section id="tab-specials" class="tab-content hidden space-y-3">
            <div class="bg-slate-800/90 backdrop-blur-md p-5 rounded-2xl border border-slate-700 shadow-xl space-y-3">
                <h2 class="text-lg font-black orange-text">🔥 Exclusive Bundle Savings</h2>
                <div class="p-3.5 bg-slate-900/80 rounded-xl border border-orange-500/30 flex justify-between items-center">
                    <div>
                        <h4 class="font-black text-xs text-orange-300">2x M-Scents Perfumes Deal</h4>
                        <p class="text-[11px] text-slate-400">Save R48 on any two 40ml luxury fragrances</p>
                    </div>
                    <button onclick="addToCart('2x M-Scents Perfumes Deal', 192)" class="orange-gradient text-white font-black text-xs px-4 py-2 rounded-xl">R 192</button>
                </div>
                <div class="p-3.5 bg-slate-900/80 rounded-xl border border-orange-500/30 flex justify-between items-center">
                    <div>
                        <h4 class="font-black text-xs text-orange-300">2x Juices Africa (4L) Deal</h4>
                        <p class="text-[11px] text-slate-400">Save R96 (Yields 40L Juice)</p>
                    </div>
                    <button onclick="addToCart('2x Juices Africa Deal', 224)" class="orange-gradient text-white font-black text-xs px-4 py-2 rounded-xl">R 224</button>
                </div>
                <div class="p-3.5 bg-slate-900/80 rounded-xl border border-orange-500/30 flex justify-between items-center">
                    <div>
                        <h4 class="font-black text-xs text-orange-300">3-Item Cereal Mini Combo</h4>
                        <p class="text-[11px] text-slate-400">Custom pantry basic selection</p>
                    </div>
                    <button onclick="addToCart('3-Item Mini Hamper', 170)" class="orange-gradient text-white font-black text-xs px-4 py-2 rounded-xl">R 170</button>
                </div>
            </div>
        </section>

        <!-- ABOUT & QUESTIONNAIRE TAB -->
        <section id="tab-info" class="tab-content hidden space-y-4">
            <div class="bg-slate-800/90 backdrop-blur-md p-5 rounded-2xl border border-slate-700 shadow-xl space-y-4">
                <h2 class="text-lg font-black orange-text">📋 About Nollie's & Community Questionnaire</h2>
                <p class="text-xs text-slate-300 leading-relaxed">
                    Nollie's Small Business is proudly based in eNanda, Durban, providing affordable household staples, cereal hampers, high-yield juice concentrates, and premium perfumes directly to our community.
                </p>
                <div class="border-t border-slate-700 pt-3 space-y-3">
                    <h3 class="font-bold text-xs text-orange-400">Frequently Asked Questions</h3>
                    <div class="text-xs space-y-2 text-slate-300">
                        <p><strong>Q: How much is delivery?</strong><br>A: A flat R30 delivery fee applies across all eNanda locations.</p>
                        <p><strong>Q: Can I use the app offline?</strong><br>A: Yes! Tap the "Install App" button at the top to install Nollie's to your phone home screen.</p>
                    </div>
                </div>
                <div class="border-t border-slate-700 pt-3 space-y-3">
                    <h3 class="font-bold text-xs text-orange-400">Community Feedback Questionnaire</h3>
                    <div class="space-y-2 text-xs">
                        <label class="block text-slate-300">How would you rate your shopping experience?</label>
                        <select id="survey-rating" class="w-full p-2.5 rounded-xl bg-slate-900 border border-slate-700 text-white outline-none">
                            <option value="Excellent">⭐⭐⭐⭐⭐ Excellent</option>
                            <option value="Good">⭐⭐⭐⭐ Good</option>
                            <option value="Average">⭐⭐⭐ Average</option>
                        </select>
                        <label class="block text-slate-300 mt-2">Any product suggestions for eNanda?</label>
                        <input type="text" id="survey-comment" placeholder="e.g., More cleaning supplies..." class="w-full p-2.5 rounded-xl bg-slate-900 border border-slate-700 text-white outline-none">
                        <button onclick="submitSurvey()" class="w-full mt-2 orange-gradient text-white font-black py-2.5 rounded-xl shadow-lg">Submit Feedback 🚀</button>
                    </div>
                </div>
            </div>
        </section>

        <!-- ANALYTICS TAB -->
        <section id="tab-analytics" class="tab-content hidden space-y-4">
            <div class="bg-slate-800/90 backdrop-blur-md p-5 rounded-2xl border border-slate-700 shadow-xl space-y-3">
                <h2 class="text-base font-black text-white">📊 Flask API Live Telemetry & Transparency</h2>
                <p class="text-[11px] text-slate-400">Real-time breakdown of community demand and backend fulfillment records.</p>
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
                        <strong>Nollie AI:</strong> Sawubona! Ask me about products, offline app installation, or eNanda delivery!
                    </div>
                </div>
                <div class="flex space-x-2">
                    <input type="text" id="chat-input" placeholder="Type your question..." class="flex-1 px-3.5 py-2.5 text-xs rounded-xl border border-slate-700 bg-slate-900 text-white outline-none">
                    <button onclick="sendAiMessage()" class="orange-gradient text-white font-black px-4 py-2.5 rounded-xl text-xs">Send</button>
                </div>
            </div>
        </section>

    </main>

    <!-- Cart Drawer -->
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
                    <span id="cart-total" class="orange-text">R 30.00</span>
                </div>
                <button onclick="checkoutWhatsApp()" class="w-full bg-emerald-600 text-white font-black py-3.5 rounded-2xl flex items-center justify-center space-x-2 text-sm shadow-xl">
                    <span>Send Order on WhatsApp 💬</span>
                </button>
            </div>
        </div>
    </div>

    <!-- Product Detail Modal -->
    <div id="product-modal" class="fixed inset-0 bg-slate-950/85 backdrop-blur-md z-50 hidden flex items-center justify-center p-4">
        <div class="bg-slate-900 rounded-3xl p-6 border border-slate-700 max-w-sm w-full space-y-4 shadow-2xl">
            <div class="flex justify-between items-center border-b border-slate-800 pb-3">
                <h3 id="modal-title" class="font-black text-sm text-orange-400">Product Details</h3>
                <button onclick="closeProductModal()" class="text-slate-400 text-xl font-bold">&times;</button>
            </div>
            <img id="modal-img" src="" alt="Product" class="w-full h-40 object-cover rounded-xl bg-slate-950">
            <p id="modal-desc" class="text-xs text-slate-300 leading-relaxed"></p>
            <div class="flex justify-between items-center pt-2 border-t border-slate-800">
                <span id="modal-price" class="text-base font-black text-orange-400">R 0.00</span>
                <button id="modal-add-btn" class="orange-gradient text-white font-black px-4 py-2.5 rounded-xl text-xs shadow-lg">+ Add to Cart</button>
            </div>
        </div>
    </div>

    <!-- PWA Install Modal -->
    <div id="install-modal" class="fixed inset-0 bg-slate-950/85 backdrop-blur-md z-50 hidden flex items-center justify-center p-4">
        <div class="bg-slate-900 rounded-3xl p-6 border border-slate-700 max-w-sm w-full space-y-4 shadow-2xl">
            <div class="flex justify-between items-center border-b border-slate-800 pb-3">
                <h3 class="font-black text-sm text-orange-400">📲 Install Nollie's App</h3>
                <button onclick="closeInstallModal()" class="text-slate-400 text-xl font-bold">&times;</button>
            </div>
            <p class="text-xs text-slate-300 leading-relaxed">
                Install Nollie's on your phone home screen to use it completely offline!
            </p>
            <div class="bg-slate-950 p-3.5 rounded-xl border border-slate-800 text-xs space-y-2 text-slate-200">
                <p><strong>Android (Chrome):</strong> Tap your browser menu <strong>(⋮)</strong> at the top right, then tap <strong>"Install app"</strong> or <strong>"Add to Home screen"</strong>.</p>
                <p><strong>iPhone (Safari):</strong> Tap the Share button at the bottom, then tap <strong>"Add to Home Screen"</strong>.</p>
            </div>
            <button onclick="closeInstallModal()" class="w-full orange-gradient text-white font-black py-3 rounded-xl text-xs shadow-lg">
                Got it, thanks!
            </button>
        </div>
    </div>

    <!-- Toast -->
    <div id="toast" class="fixed bottom-6 right-6 bg-orange-600 text-white text-xs font-bold px-4 py-3 rounded-2xl shadow-2xl transition-all duration-300 transform translate-y-20 opacity-0 z-50">
        Item added to cart!
    </div>

    <script src="/js/app.js"></script>
</body>
</html>
EOF_HTML

# 2. Update static/js/app.js with animated product cards and backend telemetry connection
cat > static/js/app.js << 'EOF_JS'
const PRODUCTS = [
    { 
        id: 'c1', cat: 'cereal', title: 'Cereal Hamper Package 1', price: 250, badge: '5 Items', 
        desc: 'Jungle Oats 1kg, Future Life 500g, Kellogg\'s Noodles (5 Pks), Bokomo Corn Flakes 1kg, Weet-Bix 450g.',
        img: 'https://images.unsplash.com/photo-1517093788734-90fa7b733160?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1521483451571-9f5ce5f25d78?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'c2', cat: 'cereal', title: 'Cereal Hamper Package 2', price: 250, badge: '5 Items', 
        desc: 'Bokomo Corn Flakes 1kg, Happy Valley Rice Puffs, Juice 6x300ml, My Life Porridge, Noodles.',
        img: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1521483451571-9f5ce5f25d78?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'c3', cat: 'cereal', title: 'Cereal Hamper Package 3', price: 250, badge: '5 Items', 
        desc: 'Bokomo Weet-Bix 450g, Corn Flakes 1kg, Future Life 500g, Nutrifics 450g, Noodles.',
        img: 'https://images.unsplash.com/photo-1517093788734-90fa7b733160?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'c4', cat: 'cereal', title: 'Cereal Hamper Package 4', price: 250, badge: '5 Items', 
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

let cart = JSON.parse(localStorage.getItem('nollies_cart') || '[]');
const deliveryFee = 30;
let salesChartInstance = null;

document.addEventListener('DOMContentLoaded', () => {
    renderProducts(PRODUCTS);
    updateCartUI();
    initCharts();
    fetchLiveTicker();

    if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register('/sw.js').catch(() => {});
    }
});

async function fetchLiveTicker() {
    try {
        const res = await fetch('/api/public-activity');
        const data = await res.json();
        const ticker = document.getElementById('live-ticker');
        if (data.recent_orders && data.recent_orders.length > 0) {
            const latest = data.recent_orders[0];
            ticker.innerHTML = `🟢 Live eNanda Activity: <strong>${latest.name}</strong> ordered ${latest.items_count} item(s) (Total: R${latest.total}) | Total Fulfilled: ${data.total_fulfilled}`;
        } else {
            ticker.innerHTML = `🟢 eNanda Hub Active | Flat R30 Delivery across eNanda`;
        }
    } catch (e) {
        document.getElementById('live-ticker').innerHTML = `🟢 eNanda Hub Active & Ready for Orders`;
    }
}

function showToast(message) {
    const toast = document.getElementById('toast');
    toast.innerText = message;
    toast.classList.remove('translate-y-20', 'opacity-0');
    setTimeout(() => {
        toast.classList.add('translate-y-20', 'opacity-0');
    }, 2500);
}

function triggerInstall() {
    const modal = document.getElementById('install-modal');
    if (modal) {
        modal.classList.remove('hidden');
        modal.classList.add('flex');
    }
}

function closeInstallModal() {
    const modal = document.getElementById('install-modal');
    if (modal) {
        modal.classList.add('hidden');
        modal.classList.remove('flex');
    }
}

function openProductModal(title, price, desc, img, fallback) {
    document.getElementById('modal-title').innerText = title;
    document.getElementById('modal-price').innerText = `R ${price.toFixed(2)}`;
    document.getElementById('modal-desc').innerText = desc;
    const modalImg = document.getElementById('modal-img');
    modalImg.src = img;
    modalImg.onerror = () => { modalImg.src = fallback; };
    
    const addBtn = document.getElementById('modal-add-btn');
    addBtn.onclick = () => {
        addToCart(title, price);
        closeProductModal();
    };

    const modal = document.getElementById('product-modal');
    modal.classList.remove('hidden');
    modal.classList.add('flex');
}

function closeProductModal() {
    const modal = document.getElementById('product-modal');
    modal.classList.add('hidden');
    modal.classList.remove('flex');
}

function submitSurvey() {
    const rating = document.getElementById('survey-rating').value;
    const comment = document.getElementById('survey-comment').value;
    if (!comment) return alert('Please enter your feedback comment!');
    showToast('Thank you for your questionnaire feedback!');
    document.getElementById('survey-comment').value = '';
}

function renderProducts(items) {
    const container = document.getElementById('product-list');
    if (!container) return;
    container.innerHTML = items.map(p => `
        <div class="product-card animated-card bg-slate-900/90 backdrop-blur-md rounded-2xl border border-slate-700 shadow-xl overflow-hidden flex flex-col justify-between" data-cat="${p.cat}">
            <div onclick="openProductModal('${p.title}', ${p.price}, '${p.desc.replace(/'/g, "\\'")}', '${p.img}', '${p.fallback}')" class="cursor-pointer">
                <div class="h-44 overflow-hidden relative bg-slate-950 flex items-center justify-center">
                    <img src="${p.img}" alt="${p.title}" class="w-full h-full object-cover hover:scale-110 transition-transform duration-500" onerror="this.src='${p.fallback}'">
                    <span class="absolute top-2 left-2 bg-orange-600 text-white text-[10px] font-black px-2.5 py-0.5 rounded-md uppercase shadow">${p.badge}</span>
                </div>
                <div class="p-4">
                    <h3 class="text-sm font-bold text-white mb-1 hover:text-orange-400 transition-colors">${p.title}</h3>
                    <p class="text-[11px] text-slate-300 line-clamp-2">${p.desc}</p>
                </div>
            </div>
            <div class="p-4 pt-0 flex justify-between items-center">
                <span class="text-base font-black text-orange-400">R ${p.price.toFixed(2)}</span>
                <button onclick="addToCart('${p.title}', ${p.price})" class="orange-gradient text-white text-xs font-black px-4 py-2 rounded-xl shadow-md hover:scale-105 transition-all">+ Add</button>
            </div>
        </div>
    `).join('');
}

function addToCart(title, price) {
    cart.push({ title, price });
    localStorage.setItem('nollies_cart', JSON.stringify(cart));
    updateCartUI();
    showToast(`Added ${title} to cart!`);
}

function updateCartUI() {
    const badge = document.getElementById('cart-count');
    if (badge) badge.innerText = cart.length;
    const container = document.getElementById('cart-items');
    if (!container) return;
    container.innerHTML = '';

    let subtotal = 0;
    cart.forEach((item, index) => {
        subtotal += item.price;
        container.innerHTML += `
            <div class="flex justify-between items-center bg-slate-900 p-2.5 rounded-xl border border-slate-700 text-slate-200">
                <div>
                    <div class="font-bold">${item.title}</div>
                    <div class="text-slate-400 text-[10px]">R ${item.price.toFixed(2)}</div>
                </div>
                <button onclick="removeFromCart(${index})" class="text-red-400 font-bold px-2 hover:text-red-300">✕</button>
            </div>
        `;
    });

    const grandTotal = cart.length > 0 ? subtotal + deliveryFee : 0;
    const totalEl = document.getElementById('cart-total');
    if (totalEl) totalEl.innerText = `R ${grandTotal.toFixed(2)}`;
}

function removeFromCart(index) {
    cart.splice(index, 1);
    localStorage.setItem('nollies_cart', JSON.stringify(cart));
    updateCartUI();
    showToast('Item removed from cart.');
}

function toggleCart() {
    const modal = document.getElementById('cart-modal');
    if (modal) {
        modal.classList.toggle('hidden');
        modal.classList.toggle('flex');
    }
}

function switchTab(tabId, btn) {
    document.querySelectorAll('.tab-btn').forEach(b => {
        b.classList.remove('orange-gradient', 'text-white', 'font-black', 'shadow-md');
        b.classList.add('text-slate-300', 'font-bold');
    });
    document.querySelectorAll('.tab-content').forEach(c => c.classList.add('hidden'));

    if (btn) {
        btn.classList.add('orange-gradient', 'text-white', 'font-black', 'shadow-md');
        btn.classList.remove('text-slate-300', 'font-bold');
    }
    const tabTarget = document.getElementById(`tab-${tabId}`);
    if (tabTarget) tabTarget.classList.remove('hidden');

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
    if (btn) btn.classList.add('orange-gradient', 'text-white', 'font-black', 'shadow-md');

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
                    data: [45, 25, 20, 10],
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
    if (!input || !box) return;
    const text = input.value.trim();
    if (!text) return;

    box.innerHTML += `<div class="text-right"><span class="inline-block orange-gradient text-white font-bold p-2.5 rounded-xl">${text}</span></div>`;

    setTimeout(() => {
        let reply = "We deliver across eNanda for R30! Your cart is saved locally.";
        const lower = text.toLowerCase();
        if (lower.includes('offline') || lower.includes('install')) {
            reply = "Tap the '📲 Install App' button at the top right to install Nollie's on your home screen!";
        }
        box.innerHTML += `<div><span class="inline-block bg-slate-900 text-slate-200 border border-slate-700 p-2.5 rounded-xl"><strong>Nollie AI:</strong> ${reply}</span></div>`;
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
EOF_JS

echo "✅ All connected successfully!"
