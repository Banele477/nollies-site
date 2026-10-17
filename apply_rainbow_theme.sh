#!/data/data/com.termux/files/usr/bin/bash
set -e

cd ~/nollies
echo "🌈 Applying Rainbow Accents, Real-World Background, and Easy Navigation..."

# Overwrite public/index.html with full rainbow styling & real background image
cat > public/index.html << 'HTML_EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Nollie's | eNanda Community Hub</title>
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
        
        /* Rainbow Gradient Text & Accents */
        .rainbow-text {
            background: linear-gradient(90deg, #ef4444, #f97316, #eab308, #10b981, #06b6d4, #6366f1, #a855f7);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .rainbow-border {
            border-image: linear-gradient(90deg, #ef4444, #f97316, #eab308, #10b981, #06b6d4, #6366f1, #a855f7) 1;
        }

        .rainbow-bg {
            background: linear-gradient(135deg, #ef4444, #f97316, #eab308, #10b981, #06b6d4, #6366f1, #a855f7);
        }

        /* Real-World Background Overlay */
        .bg-community {
            background-image: linear-gradient(rgba(15, 23, 42, 0.85), rgba(15, 23, 42, 0.92)), 
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
        <span>🚚 R30 Delivery Fee</span>
    </div>

    <!-- Easy Mobile Tab Navigation -->
    <nav class="flex bg-slate-800/90 backdrop-blur-md border border-slate-700 max-w-2xl mx-auto my-3 rounded-2xl shadow-xl p-1.5 gap-1 overflow-x-auto">
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-black rainbow-bg text-white whitespace-nowrap shadow-md text-center" onclick="switchTab('shop', this)">🛍️ Shop</button>
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-bold text-slate-300 hover:text-white whitespace-nowrap text-center" onclick="switchTab('specials', this)">🔥 Combos</button>
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-bold text-slate-300 hover:text-white whitespace-nowrap text-center" onclick="switchTab('analytics', this)">📊 Live Stats</button>
        <button class="tab-btn flex-1 py-3 px-3 rounded-xl text-xs font-bold text-slate-300 hover:text-white whitespace-nowrap text-center" onclick="switchTab('ai', this)">🤖 AI Help</button>
    </nav>

    <!-- Main Content View -->
    <main class="max-w-2xl mx-auto px-4">

        <!-- SHOP TAB -->
        <section id="tab-shop" class="tab-content block space-y-4">
            
            <!-- Hero Banner -->
            <div class="relative overflow-hidden rounded-2xl border border-slate-700 p-5 shadow-2xl bg-slate-800/80 backdrop-blur-sm">
                <div class="absolute -right-10 -bottom-10 w-32 h-32 rainbow-bg rounded-full blur-2xl opacity-30"></div>
                <h1 class="text-xl font-black mb-1 rainbow-text">Quality Products & Good Services</h1>
                <p class="text-xs text-slate-300">5-Item Cereal Hampers, Juices Africa (4L Concentrate makes 20L), & M-Scents Perfumes!</p>
            </div>

            <!-- Search Input -->
            <input type="text" id="search-input" placeholder="🔍 Touch here to search cereal, juice, perfume..." onkeyup="filterProducts()" 
                   class="w-full px-4 py-3.5 rounded-2xl border border-slate-700 bg-slate-800/90 text-white placeholder-slate-400 text-xs focus:ring-2 focus:ring-amber-400 outline-none shadow-md">

            <!-- Filter Pills -->
            <div class="flex space-x-2 overflow-x-auto pb-1 text-xs">
                <button onclick="filterCat('all', this)" class="cat-btn px-4 py-2 rounded-xl font-black rainbow-bg text-white shadow-md">All Items</button>
                <button onclick="filterCat('cereal', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-800 text-slate-300 border border-slate-700">Cereal Hampers</button>
                <button onclick="filterCat('juice', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-800 text-slate-300 border border-slate-700">Juices Africa (4L)</button>
                <button onclick="filterCat('perfume', this)" class="cat-btn px-4 py-2 rounded-xl font-bold bg-slate-800 text-slate-300 border border-slate-700">M-Scents Perfumes</button>
            </div>

            <!-- Products List -->
            <div class="space-y-3" id="product-list">
                <!-- Products injected by JS -->
            </div>
        </section>

        <!-- COMBOS TAB -->
        <section id="tab-specials" class="tab-content hidden space-y-3">
            <div class="bg-slate-800/90 backdrop-blur-md p-5 rounded-2xl border border-slate-700 shadow-xl space-y-3">
                <h2 class="text-lg font-black rainbow-text">🔥 Exclusive Bundle Savings</h2>
                
                <div class="p-3.5 bg-slate-900/80 rounded-xl border border-purple-500/30 flex justify-between items-center">
                    <div>
                        <h4 class="font-black text-xs text-purple-300">2x M-Scents Perfumes</h4>
                        <p class="text-[11px] text-slate-400">Save R48 on any two 40ml bottles</p>
                    </div>
                    <button onclick="addToCart('2x M-Scents Perfumes Deal', 192)" class="bg-purple-600 hover:bg-purple-500 text-white font-black text-xs px-4 py-2 rounded-xl shadow-md">R 192</button>
                </div>

                <div class="p-3.5 bg-slate-900/80 rounded-xl border border-emerald-500/30 flex justify-between items-center">
                    <div>
                        <h4 class="font-black text-xs text-emerald-300">2x Juices Africa (4L)</h4>
                        <p class="text-[11px] text-slate-400">Save R96 (Yields 40L Fresh Juice)</p>
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
            <div class="bg-slate-800/90 backdrop-blur-md p-5 rounded-2xl border border-slate-700 shadow-xl">
                <h2 class="text-base font-black mb-3 text-white">📊 eNanda Live Store Analytics</h2>
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
                        <strong>Nollie AI:</strong> Sawubona! Ask me about Juices Africa, Cereal Hampers, or R30 eNanda delivery!
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

# Sync root index.html
cp public/index.html index.html

echo "✅ Rainbow theme and real-world background applied!"
