#!/data/data/com.termux/files/usr/bin/bash
set -e

cd ~/nollies

echo "======================================================="
echo "🛠️ Starting Comprehensive Nollie's Repository Cleanup..."
echo "======================================================="

# 1. Remove unnecessary scattered files and obsolete upgrade scripts
echo "Cleaning up scattered and duplicate utility scripts..."
rm -f upgrade_*.sh add_*.sh connect_*.sh enable_*.sh fix_and_push.sh \
      compile_all_nollies.sh configure_owner_phone.sh run_ai_dashboard.sh \
      setup_ssh.sh git-secure-push.sh generate_sitemap.py inject_seo.py 2>/dev/null || true

# 2. Ensure clean core directory layout
mkdir -p public/css public/js data

# 3. Write clean, robust backend code (server.py) with proper JSON handling and API routing
echo "Writing optimized server.py..."
cat > server.py << 'SERVER_EOF'
#!/usr/bin/env python3
"""Nollie's Enterprise Backend Server
Runs local API and static asset hosting.
"""
import json, os, threading, time
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer

BASE = os.path.dirname(os.path.abspath(__file__))
PUBLIC = os.path.join(BASE, "public")
DATA_DIR = os.path.join(BASE, "data")
DATA = os.path.join(DATA_DIR, "orders.json")
HOST = os.environ.get("HOST", "0.0.0.0")
PORT = int(os.environ.get("PORT", "8080"))
ADMIN_KEY = os.environ.get("ADMIN_KEY", "mysecret")
LOCK = threading.Lock()
MAX_BODY = 20_000

def load_orders():
    try:
        with open(DATA, encoding="utf-8") as f:
            return json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):
        return []

def save_orders(rows):
    os.makedirs(DATA_DIR, exist_ok=True)
    tmp = DATA + ".tmp"
    with open(tmp, "w", encoding="utf-8") as f:
        json.dump(rows, f, ensure_ascii=False, indent=2)
    os.replace(tmp, DATA)

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
        parsed_path = self.path.split("?")[0]
        if parsed_path == "/api/health":
            return self.send_json(200, {"status": "ok", "app": "Nollie's Mzansi Hub"})
        if parsed_path == "/api/orders":
            if self.headers.get("X-Admin-Key", "") != ADMIN_KEY:
                return self.send_json(401, {"error": "Unauthorized admin access"})
            with LOCK:
                return self.send_json(200, list(reversed(load_orders())))
        return super().do_GET()

    def do_POST(self):
        parsed_path = self.path.split("?")[0]
        if parsed_path != "/api/order":
            return self.send_json(404, {"error": "Not found"})
        try:
            size = int(self.headers.get("Content-Length", 0))
            if size <= 0 or size > MAX_BODY:
                return self.send_json(413, {"error": "Payload too large"})
            data = json.loads(self.rfile.read(size))
        except (ValueError, json.JSONDecodeError):
            return self.send_json(400, {"error": "Invalid JSON format"})

        if not clean(data.get("name")) or not clean(data.get("phone")):
            return self.send_json(400, {"error": "Missing required fields (name, phone)"})

        row = {
            "received": time.strftime("%Y-%m-%d %H:%M:%S"),
            "status": "new",
            "name": clean(data.get("name")),
            "phone": clean(data.get("phone")),
            "method": clean(data.get("method", "WhatsApp / EFT")),
            "total": float(data.get("total", 0)),
            "items": data.get("items", [])
        }

        with LOCK:
            orders = load_orders()
            orders.append(row)
            save_orders(orders)

        self.send_json(200, {"success": True, "message": "Order successfully recorded"})

if __name__ == "__main__":
    print(f"🚀 Nollie's Server starting on http://localhost:{PORT}")
    server = ThreadingHTTPServer((HOST, PORT), NollieHandler)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nShutting down server gracefully...")
        server.server_close()
SERVER_EOF

# 4. Write optimized public/index.html (Fixed semantics, valid markup, clean UI)
echo "Writing polished frontend index.html..."
cat > public/index.html << 'HTML_EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nollie's | Enterprise & Services Portal</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body class="light-mode">

    <header class="app-header">
        <div class="header-left">
            <span class="app-logo">Nollie's<span class="dot">.</span></span>
            <span class="badge-tag">Mzansi Hub</span>
        </div>
        <div class="header-right">
            <button class="icon-btn" onclick="toggleTheme()" id="theme-btn" aria-label="Toggle Theme">🌙</button>
            <div class="cart-pill" onclick="toggleCart()" role="button" tabindex="0">
                🛒 <span id="cart-count">0</span>
            </div>
        </div>
    </header>

    <main class="app-body">
        <section class="hero-card">
            <h1>Tailored Digital Solutions for SA Enterprises</h1>
            <p>Reliable, data-friendly business setup, analytics, and logistics services.</p>
        </section>

        <div class="search-box">
            <input type="text" id="search-input" placeholder="Search services..." onkeyup="filterProducts()">
        </div>

        <div class="product-grid" id="product-grid">
            <div class="card" data-name="smart logistics hub">
                <span class="badge">Operations</span>
                <h3>Smart Logistics Hub</h3>
                <p>Complete supply chain setup, stock inventory tracking, and workflow optimization.</p>
                <div class="card-footer">
                    <div class="price">R 890.00</div>
                    <button class="btn btn-add" onclick="addToCart('Smart Logistics Hub', 890)">+ Cart</button>
                </div>
            </div>

            <div class="card" data-name="data & systems analytics">
                <span class="badge">Intelligence</span>
                <h3>Data & Systems Analytics</h3>
                <p>Custom business dashboards, automated financial reporting, and operational insights.</p>
                <div class="card-footer">
                    <div class="price">R 1,200.00</div>
                    <button class="btn btn-add" onclick="addToCart('Data & Systems Analytics', 1200)">+ Cart</button>
                </div>
            </div>

            <div class="card" data-name="urban architecture & tech">
                <span class="badge">Infrastructure</span>
                <h3>Urban Architecture & Tech</h3>
                <p>Digital transformation strategy for physical workspaces and local infrastructure.</p>
                <div class="card-footer">
                    <div class="price">R 550.00</div>
                    <button class="btn btn-add" onclick="addToCart('Urban Architecture & Tech', 550)">+ Cart</button>
                </div>
            </div>
        </div>
    </main>

    <!-- Slide-Up Cart Modal -->
    <div id="cart-modal" class="cart-overlay">
        <div class="cart-drawer">
            <div class="drawer-header">
                <h3>Order Summary</h3>
                <button class="close-icon" onclick="toggleCart()">&times;</button>
            </div>
            <div id="cart-items" class="drawer-body">
                <p class="empty-text">Your cart is empty.</p>
            </div>
            <div class="drawer-footer">
                <div class="total-row">
                    <span>Total Amount:</span>
                    <span id="cart-total">R 0.00</span>
                </div>
                <button class="btn btn-checkout" onclick="checkoutWhatsApp()">Checkout via WhatsApp 💬</button>
            </div>
        </div>
    </div>

    <script src="js/script.js"></script>
</body>
</html>
HTML_EOF

# 5. Write polished CSS (public/css/style.css)
echo "Writing professional CSS stylesheet..."
cat > public/css/style.css << 'CSS_EOF'
:root {
    --primary: #4F46E5;
    --wa-green: #25D366;
    --bg: #F8FAFC;
    --card: #FFFFFF;
    --text: #0F172A;
    --muted: #64748B;
    --border: #E2E8F0;
}
body.dark-mode {
    --bg: #0F172A;
    --card: #1E293B;
    --text: #F8FAFC;
    --muted: #94A3B8;
    --border: #334155;
}
* { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }
body { background: var(--bg); color: var(--text); padding-bottom: 40px; }
.app-header { display: flex; justify-content: space-between; align-items: center; padding: 14px 20px; background: var(--card); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 50; }
.app-logo { font-size: 1.3rem; font-weight: 800; }
.app-logo .dot { color: var(--primary); }
.badge-tag { background: #EEF2FF; color: var(--primary); font-size: 0.7rem; font-weight: 700; padding: 3px 8px; border-radius: 8px; }
.header-right { display: flex; gap: 10px; align-items: center; }
.icon-btn { background: var(--bg); border: 1px solid var(--border); width: 36px; height: 36px; border-radius: 50%; cursor: pointer; color: var(--text); }
.cart-pill { background: var(--primary); color: white; padding: 6px 14px; border-radius: 20px; font-weight: 700; font-size: 0.85rem; cursor: pointer; }

.app-body { padding: 20px; max-width: 800px; margin: 0 auto; }
.hero-card { background: var(--card); border: 1px solid var(--border); border-radius: 16px; padding: 24px; margin-bottom: 20px; text-align: center; }
.hero-card h1 { font-size: 1.4rem; font-weight: 800; margin-bottom: 8px; }
.hero-card p { color: var(--muted); font-size: 0.95rem; }

.search-box { margin-bottom: 16px; }
#search-input { width: 100%; padding: 12px 16px; border-radius: 12px; border: 1px solid var(--border); background: var(--card); color: var(--text); outline: none; font-size: 0.9rem; }

.product-grid { display: flex; flex-direction: column; gap: 14px; }
.card { background: var(--card); border: 1px solid var(--border); border-radius: 16px; padding: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.02); }
.badge { background: #F1F5F9; color: #475569; font-size: 0.7rem; font-weight: 700; text-transform: uppercase; padding: 4px 8px; border-radius: 6px; }
.card h3 { font-size: 1.15rem; font-weight: 700; margin: 10px 0 6px; }
.card p { font-size: 0.9rem; color: var(--muted); margin-bottom: 16px; line-height: 1.4; }

.card-footer { display: flex; justify-content: space-between; align-items: center; border-top: 1px dashed var(--border); padding-top: 12px; }
.price { font-size: 1.25rem; font-weight: 800; }
.btn { padding: 10px 16px; border-radius: 10px; border: none; font-weight: 700; font-size: 0.85rem; cursor: pointer; }
.btn-add { background: var(--primary); color: white; }
.btn-checkout { width: 100%; background: var(--wa-green); color: white; padding: 14px; border-radius: 12px; font-size: 1rem; }

.cart-overlay { display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.5); z-index: 200; justify-content: flex-end; flex-direction: column; }
.cart-drawer { background: var(--card); border-top-left-radius: 20px; border-top-right-radius: 20px; padding: 24px; max-height: 80vh; display: flex; flex-direction: column; }
.drawer-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--border); padding-bottom: 12px; }
.close-icon { background: none; border: none; font-size: 1.5rem; color: var(--muted); cursor: pointer; }
.drawer-body { padding: 16px 0; overflow-y: auto; flex: 1; }
.cart-row { display: flex; justify-content: space-between; margin-bottom: 10px; font-size: 0.95rem; border-bottom: 1px dashed var(--border); padding-bottom: 6px; }
.empty-text { color: var(--muted); text-align: center; }
.drawer-footer { border-top: 1px solid var(--border); padding-top: 16px; }
.total-row { display: flex; justify-content: space-between; font-weight: 800; font-size: 1.1rem; margin-bottom: 14px; }
CSS_EOF

# 6. Write robust frontend JavaScript (public/js/script.js)
echo "Writing robust frontend script..."
cat > public/js/script.js << 'JS_EOF'
let cart = [];

function addToCart(title, price) {
    cart.push({ title, price });
    updateCartUI();
    toggleCart();
}

function updateCartUI() {
    document.getElementById('cart-count').innerText = cart.length;
    const container = document.getElementById('cart-items');
    
    if (cart.length === 0) {
        container.innerHTML = '<p class="empty-text">Your cart is empty.</p>';
        document.getElementById('cart-total').innerText = 'R 0.00';
        return;
    }

    container.innerHTML = '';
    let total = 0;
    cart.forEach(item => {
        total += item.price;
        container.innerHTML += `
            <div class="cart-row">
                <div><strong>${item.title}</strong></div>
                <div>R ${item.price.toFixed(2)}</div>
            </div>
        `;
    });

    document.getElementById('cart-total').innerText = `R ${total.toFixed(2)}`;
}

function toggleCart() {
    const modal = document.getElementById('cart-modal');
    modal.style.display = (modal.style.display === 'flex') ? 'none' : 'flex';
}

function toggleTheme() {
    document.body.classList.toggle('dark-mode');
    const btn = document.getElementById('theme-btn');
    btn.innerText = document.body.classList.contains('dark-mode') ? '☀️' : '🌙';
}

function filterProducts() {
    const query = document.getElementById('search-input').value.toLowerCase();
    document.querySelectorAll('.card').forEach(card => {
        const name = card.getAttribute('data-name');
        card.style.display = name.includes(query) ? 'block' : 'none';
    });
}

function checkoutWhatsApp() {
    if (cart.length === 0) {
        alert('Your cart is empty!');
        return;
    }

    let message = "Hi Nollie's, I would like to order:%0A";
    let total = 0;
    cart.forEach(item => {
        message += `• ${item.title}: R${item.price}%0A`;
        total += item.price;
    });
    message += `%0ATotal Amount: R${total.toFixed(2)}`;

    // Sync order to backend API asynchronously
    fetch('/api/order', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name: 'Web Customer', phone: 'WhatsApp User', total: total, items: cart })
    }).catch(() => {});

    window.open(`https://wa.me/?text=${message}`, '_blank');
}
JS_EOF

# 7. Sync root index.html
cp public/index.html index.html 2>/dev/null || true

echo "======================================================="
echo "✅ Cleanup and Refactoring Successful!"
echo "======================================================="
