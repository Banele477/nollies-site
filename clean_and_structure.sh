#!/data/data/com.termux/files/usr/bin/bash
set -e

cd ~/nollies

echo "======================================================="
echo "🧹 Cleaning up repository and structuring Nollie's..."
echo "======================================================="

# 1. Remove obsolete, scattered, or duplicate scripts
rm -f upgrade_*.sh add_*.sh connect_*.sh enable_*.sh fix_and_push.sh \
      compile_all_nollies.sh configure_owner_phone.sh run_ai_dashboard.sh \
      setup_ssh.sh git-secure-push.sh generate_sitemap.py inject_seo.py \
      gsc.py 2>/dev/null || true

# 2. Establish clean directory hierarchy
mkdir -p public/css public/js data .github/workflows

# 3. Write clean, robust backend server.py
cat > server.py << 'SERVER_EOF'
#!/usr/bin/env python3
"""Nollie's Enterprise Backend Server
Runs local API, static hosting, and order database management.
"""
import json, os, threading, time
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer

BASE = os.path.dirname(os.path.abspath(__file__))
PUBLIC = os.path.join(BASE, "public")
DATA_DIR = os.path.join(BASE, "data")
DATA_FILE = os.path.join(DATA_DIR, "orders.json")
HOST = os.environ.get("HOST", "0.0.0.0")
PORT = int(os.environ.get("PORT", "8080"))
ADMIN_KEY = os.environ.get("ADMIN_KEY", "mysecret")
LOCK = threading.Lock()
MAX_BODY = 20_000

def load_orders():
    try:
        with open(DATA_FILE, encoding="utf-8") as f:
            return json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):
        return []

def save_orders(rows):
    os.makedirs(DATA_DIR, exist_ok=True)
    tmp = DATA_FILE + ".tmp"
    with open(tmp, "w", encoding="utf-8") as f:
        json.dump(rows, f, ensure_ascii=False, indent=2)
    os.replace(tmp, DATA_FILE)

def clean(v, n=300):
    return str(v)[:n].strip()

class NollieHandler(SimpleHTTPRequestHandler):
    def __init__(self, *a, **kw):
        super().__init__(*a, directory=PUBLIC, **kw)

    def send_json(self, code, obj):
        body = json.dumps(obj).encode()
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        parsed = self.path.split("?")[0]
        if parsed == "/api/health":
            return self.send_json(200, {"status": "ok", "app": "Nollie's eNanda Hub"})
        if parsed == "/api/orders":
            if self.headers.get("X-Admin-Key", "") != ADMIN_KEY:
                return self.send_json(401, {"error": "Unauthorized access"})
            with LOCK:
                return self.send_json(200, list(reversed(load_orders())))
        return super().do_GET()

    def do_POST(self):
        parsed = self.path.split("?")[0]
        if parsed != "/api/order":
            return self.send_json(404, {"error": "Not found"})
        try:
            size = int(self.headers.get("Content-Length", 0))
            if size <= 0 or size > MAX_BODY:
                return self.send_json(413, {"error": "Payload too large"})
            data = json.loads(self.rfile.read(size))
        except (ValueError, json.JSONDecodeError):
            return self.send_json(400, {"error": "Invalid JSON"})

        row = {
            "received": time.strftime("%Y-%m-%d %H:%M:%S"),
            "status": "New",
            "name": clean(data.get("name", "Customer")),
            "phone": clean(data.get("phone", "WhatsApp")),
            "total": float(data.get("total", 0)),
            "items": data.get("items", [])
        }

        with LOCK:
            orders = load_orders()
            orders.append(row)
            save_orders(orders)

        self.send_json(200, {"success": True, "message": "Order recorded successfully"})

if __name__ == "__main__":
    print(f"🚀 Nollie's Server starting on http://localhost:{PORT}")
    server = ThreadingHTTPServer((HOST, PORT), NollieHandler)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nShutting down server gracefully...")
        server.server_close()
SERVER_EOF

# 4. Write stunning public/index.html with Tailwind CSS & eNanda Catalog
cat > public/index.html << 'HTML_EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Nollie's | eNanda Essentials, Juices & Perfumes</title>
    <script src="https://cdn.tailwindcss.com"></script>
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
    <style>body { font-family: 'Inter', sans-serif; }</style>
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
        <button class="tab-btn flex-1 py-2 px-3 rounded-xl text-xs font-semibold text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-700 whitespace-nowrap" onclick="switchTab('specials', this)">🔥 Specials</button>
        <button class="tab-btn flex-1 py-2 px-3 rounded-xl text-xs font-semibold text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-700 whitespace-nowrap" onclick="switchTab('ai', this)">🤖 AI Assistant</button>
        <button class="tab-btn flex-1 py-2 px-3 rounded-xl text-xs font-semibold text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-700 whitespace-nowrap" onclick="switchTab('telemetry', this)">📊 Financials</button>
    </nav>

    <!-- Main Views Container -->
    <main class="max-w-2xl mx-auto px-4">

        <!-- SHOP TAB -->
        <section id="tab-shop" class="tab-content block space-y-4">
            <div class="bg-gradient-to-r from-brand-600 to-indigo-700 text-white rounded-2xl p-5 shadow-lg">
                <h1 class="text-lg font-black mb-1">Quality Products & Good Services</h1>
                <p class="text-xs text-brand-100">Browse our 5-item Cereal Hampers, Juices Africa 4L concentrates, and M-Scents Perfumes.</p>
            </div>

            <!-- Search & Filter -->
            <input type="text" id="search-input" placeholder="Search cereal, juices africa, m-scents..." onkeyup="filterProducts()" 
                   class="w-full px-4 py-3 rounded-xl border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-xs focus:ring-2 focus:ring-brand-500 outline-none shadow-sm">

            <div class="flex space-x-2 overflow-x-auto pb-1 text-xs">
                <button onclick="filterCat('all')" class="cat-btn px-3 py-1.5 rounded-xl font-bold bg-slate-900 text-white">All Items</button>
                <button onclick="filterCat('cereal')" class="cat-btn px-3 py-1.5 rounded-xl font-semibold bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700">Cereal Hampers</button>
                <button onclick="filterCat('juice')" class="cat-btn px-3 py-1.5 rounded-xl font-semibold bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700">Juices Africa (4L)</button>
                <button onclick="filterCat('perfume')" class="cat-btn px-3 py-1.5 rounded-xl font-semibold bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700">M-Scents Perfumes</button>
            </div>

            <!-- Products List -->
            <div class="space-y-3" id="product-list">
                
                <!-- Package 1 -->
                <div class="product-card bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm" data-cat="cereal" data-name="package 1 cereal hamper jungle oats future life noodles juice corn flakes weet bix">
                    <span class="bg-amber-100 text-amber-800 text-[10px] font-extrabold px-2.5 py-0.5 rounded-md uppercase">Cereal Hamper • 5 Items</span>
                    <h3 class="text-sm font-bold mt-2">Cereal Hamper - Package 1</h3>
                    <p class="text-[11px] text-slate-500 dark:text-slate-400 my-1">Jungle Oats 1kg, Future Life 500g, Kellogg's Noodles (5 Pks) OR Juice (6x300ml), Bokomo Corn Flakes 1kg, Weet-Bix 450g.</p>
                    <div class="flex justify-between items-center border-t border-slate-100 dark:border-slate-700 pt-3 mt-2">
                        <span class="text-base font-black text-slate-900 dark:text-white">R 250.00</span>
                        <button onclick="addToCart('Cereal Hamper Package 1', 250)" class="bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-4 py-2 rounded-xl shadow-sm">+ Add to Cart</button>
                    </div>
                </div>

                <!-- Package 2 -->
                <div class="product-card bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm" data-cat="cereal" data-name="package 2 cereal hamper corn flakes happy valley rice puffs juice my life porridge noodles">
                    <span class="bg-amber-100 text-amber-800 text-[10px] font-extrabold px-2.5 py-0.5 rounded-md uppercase">Cereal Hamper • 5 Items</span>
                    <h3 class="text-sm font-bold mt-2">Cereal Hamper - Package 2</h3>
                    <p class="text-[11px] text-slate-500 dark:text-slate-400 my-1">Bokomo Corn Flakes 1kg, Happy Valley (Rice Puffs), Juice 6x300ml, My Life Instant Porridge, Kellogg's Noodles (5 Pks).</p>
                    <div class="flex justify-between items-center border-t border-slate-100 dark:border-slate-700 pt-3 mt-2">
                        <span class="text-base font-black text-slate-900 dark:text-white">R 250.00</span>
                        <button onclick="addToCart('Cereal Hamper Package 2', 250)" class="bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-4 py-2 rounded-xl shadow-sm">+ Add to Cart</button>
                    </div>
                </div>

                <!-- Package 3 -->
                <div class="product-card bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm" data-cat="cereal" data-name="package 3 cereal hamper weet bix corn flakes future life nutrifics noodles">
                    <span class="bg-amber-100 text-amber-800 text-[10px] font-extrabold px-2.5 py-0.5 rounded-md uppercase">Cereal Hamper • 5 Items</span>
                    <h3 class="text-sm font-bold mt-2">Cereal Hamper - Package 3</h3>
                    <p class="text-[11px] text-slate-500 dark:text-slate-400 my-1">Bokomo Weet-Bix 450g, Corn Flakes 1kg, Future Life 500g, Nutrifics 450g, Kellogg's Noodles (5 Pks).</p>
                    <div class="flex justify-between items-center border-t border-slate-100 dark:border-slate-700 pt-3 mt-2">
                        <span class="text-base font-black text-slate-900 dark:text-white">R 250.00</span>
                        <button onclick="addToCart('Cereal Hamper Package 3', 250)" class="bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-4 py-2 rounded-xl shadow-sm">+ Add to Cart</button>
                    </div>
                </div>

                <!-- Package 4 -->
                <div class="product-card bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm" data-cat="cereal" data-name="package 4 cereal hamper corn flakes weet bix juice future life nutrifics">
                    <span class="bg-amber-100 text-amber-800 text-[10px] font-extrabold px-2.5 py-0.5 rounded-md uppercase">Cereal Hamper • 5 Items</span>
                    <h3 class="text-sm font-bold mt-2">Cereal Hamper - Package 4</h3>
                    <p class="text-[11px] text-slate-500 dark:text-slate-400 my-1">Bokomo Corn Flakes 1kg, Weet-Bix 450g, Juice 6x300ml, Future Life 500g, Nutrifics 450g.</p>
                    <div class="flex justify-between items-center border-t border-slate-100 dark:border-slate-700 pt-3 mt-2">
                        <span class="text-base font-black text-slate-900 dark:text-white">R 250.00</span>
                        <button onclick="addToCart('Cereal Hamper Package 4', 250)" class="bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-4 py-2 rounded-xl shadow-sm">+ Add to Cart</button>
                    </div>
                </div>

                <!-- Juices Africa -->
                <div class="product-card bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm" data-cat="juice" data-name="juices africa 4l guava mixed berry cocktail tropical punch 20l">
                    <span class="bg-emerald-100 text-emerald-800 text-[10px] font-extrabold px-2.5 py-0.5 rounded-md uppercase">4L Juice Concentrate (Makes 20L)</span>
                    <h3 class="text-sm font-bold mt-2">Juices Africa (4L Bottle)</h3>
                    <p class="text-[11px] text-slate-500 dark:text-slate-400 my-1">Flavors: Guava, Mixed Berry, Cocktail, Tropical Punch.</p>
                    <div class="flex justify-between items-center border-t border-slate-100 dark:border-slate-700 pt-3 mt-2">
                        <span class="text-base font-black text-slate-900 dark:text-white">R 160.00</span>
                        <button onclick="addToCart('Juices Africa 4L', 160)" class="bg-brand-600 hover:bg-brand-700 text-white text-xs font-bold px-4 py-2 rounded-xl shadow-sm">+ Add to Cart</button>
                    </div>
                </div>

                <!-- M-Scents Perfumes -->
                <div class="product-card bg-white dark:bg-slate-800 p-4 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm" data-cat="perfume" data-name="m scents perfume 40ml silver sense red dezire white oud blue dezire stallion sky oud gorgeous girl wild intense">
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
                <h2 class="text-base font-extrabold text-brand-600">🔥 Exclusive Bundle Deals</h2>
                
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

        <!-- FINANCIALS / TELEMETRY TAB -->
        <section id="tab-telemetry" class="tab-content hidden space-y-3">
            <div class="bg-white dark:bg-slate-800 p-5 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm space-y-3">
                <h2 class="text-base font-bold">📊 Business Financials & Telemetry</h2>
                <p class="text-xs text-slate-500">Overview of eNanda operational costs and inventory margins.</p>

                <div class="grid grid-cols-2 gap-2 text-xs">
                    <div class="bg-slate-50 dark:bg-slate-700 p-3 rounded-xl border">
                        <span class="text-slate-400 block">Stocking Taxis</span>
                        <strong class="font-bold">R 59.00</strong>
                    </div>
                    <div class="bg-slate-50 dark:bg-slate-700 p-3 rounded-xl border">
                        <span class="text-slate-400 block">Return Bolt Ride</span>
                        <strong class="font-bold">R 53 - R 100</strong>
                    </div>
                    <div class="bg-slate-50 dark:bg-slate-700 p-3 rounded-xl border">
                        <span class="text-slate-400 block">Petrol (Relative Car)</span>
                        <strong class="font-bold">R 150.00</strong>
                    </div>
                    <div class="bg-slate-50 dark:bg-slate-700 p-3 rounded-xl border">
                        <span class="text-slate-400 block">Marketing & Flyers</span>
                        <strong class="font-bold">R 300 / mo</strong>
                    </div>
                </div>

                <div class="p-3 bg-brand-50 dark:bg-brand-900/30 rounded-xl text-xs space-y-1">
                    <p><strong>Cereal Margin:</strong> Cost R180-R200 ➔ Sells R250</p>
                    <p><strong>Perfumes Margin:</strong> 10 Stock for R650 ➔ Sells R120 each</p>
                    <p><strong>Local Delivery:</strong> Fixed R30 fee in eNanda.</p>
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

    <!-- JavaScript Logic -->
    <script>
        let cart = [];
        const deliveryFee = 30;

        function switchTab(tabId, btn) {
            document.querySelectorAll('.tab-btn').forEach(b => {
                b.classList.remove('bg-brand-600', 'text-white', 'shadow-sm');
                b.classList.add('text-slate-600', 'dark:text-slate-300');
            });
            document.querySelectorAll('.tab-content').forEach(c => c.classList.add('hidden'));

            btn.classList.add('bg-brand-600', 'text-white', 'shadow-sm');
            btn.classList.remove('text-slate-600', 'dark:text-slate-300');
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

        function filterCat(cat) {
            document.querySelectorAll('.cat-btn').forEach(b => {
                b.classList.remove('bg-slate-900', 'text-white');
                b.classList.add('bg-white', 'dark:bg-slate-800', 'border');
            });
            event.target.classList.add('bg-slate-900', 'text-white');

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
                let reply = "We deliver across eNanda for R30! We sell 5-item Cereal Hampers (R250), Juices Africa 4L (R160), and M-Scents perfumes (R120).";
                const lower = text.toLowerCase();
                if (lower.includes('juice')) {
                    reply = "Juices Africa comes in 4L bottles for R160 (makes 20L). Flavors: Guava, Mixed Berry, Cocktail, Tropical Punch.";
                } else if (lower.includes('perfume')) {
                    reply = "M-Scents 40ml perfumes are R120 each or 2 for R192!";
                } else if (lower.includes('cereal') || lower.includes('hamper')) {
                    reply = "We have 4 different 5-item Cereal Hamper packages for R250 each.";
                }
                box.innerHTML += `<div><span class="inline-block bg-slate-200 dark:bg-slate-700 p-2 rounded-lg"><strong>Nollie AI:</strong> ${reply}</span></div>`;
                box.scrollTop = box.scrollHeight;
            }, 400);

            input.value = '';
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

            // Sync order to backend
            fetch('/api/order', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ name: 'Web Customer', phone: 'WhatsApp', total: subtotal + 30, items: cart })
            }).catch(() => {});

            window.open(`https://wa.me/?text=${msg}`, '_blank');
        }
    </script>
</body>
</html>
HTML_EOF

# 5. Ensure root index.html is synced
cp public/index.html index.html 2>/dev/null || true

echo "======================================================="
echo "✅ Repository cleaned, structured, and enhanced successfully!"
echo "======================================================="
