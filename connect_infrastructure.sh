#!/data/data/com.termux/files/usr/bin/bash
set -e

cd ~/nollies

echo "======================================================="
echo "🔌 Connecting Full-Stack Backend & Frontend Infrastructure..."
echo "======================================================="

# 1. Ensure required directories exist
mkdir -p public/js public/css data

# 2. Build Python Backend Infrastructure (server.py)
echo "Setting up Python API & Asset Server..."
cat > server.py << 'SERVER_EOF'
#!/usr/bin/env python3
"""
Nollie's Enterprise Full-Stack Server
Connects frontend UI directly with Python backend APIs and SQLite/JSON storage.
"""
import json, os, threading, time
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
PUBLIC_DIR = os.path.join(BASE_DIR, "public")
DATA_DIR = os.path.join(BASE_DIR, "data")
ORDERS_FILE = os.path.join(DATA_DIR, "orders.json")

HOST = os.environ.get("HOST", "0.0.0.0")
PORT = int(os.environ.get("PORT", "8080"))
ADMIN_KEY = os.environ.get("ADMIN_KEY", "mysecret")
LOCK = threading.Lock()
MAX_BODY_SIZE = 50_000

def load_orders():
    try:
        with open(ORDERS_FILE, "r", encoding="utf-8") as f:
            return json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):
        return []

def save_orders(orders):
    os.makedirs(DATA_DIR, exist_ok=True)
    temp_file = ORDERS_FILE + ".tmp"
    with open(temp_file, "w", encoding="utf-8") as f:
        json.dump(orders, f, ensure_ascii=False, indent=2)
    os.replace(temp_file, ORDERS_FILE)

def sanitize(val, length=300):
    return str(val)[:length].strip()

class NollieRequestHandler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=PUBLIC_DIR, **kwargs)

    def send_json_response(self, status_code, data):
        body = json.dumps(data).encode("utf-8")
        self.send_response(status_code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Headers", "Content-Type, X-Admin-Key")
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(body)

    def do_OPTIONS(self):
        self.send_response(200)
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        self.send_header("Access-Control-Allow-Headers", "Content-Type, X-Admin-Key")
        self.end_headers()

    def do_GET(self):
        parsed_path = self.path.split("?")[0]
        
        # API 1: Health Check Endpoint
        if parsed_path == "/api/health":
            return self.send_json_response(200, {
                "status": "online",
                "app": "Nollie's eNanda Hub",
                "timestamp": time.strftime("%Y-%m-%d %H:%M:%S")
            })

        # API 2: Telemetry & Orders List Endpoint (Admin Protected)
        if parsed_path == "/api/orders":
            client_key = self.headers.get("X-Admin-Key", "")
            if client_key != ADMIN_KEY:
                return self.send_json_response(401, {"error": "Unauthorized. Invalid Admin Key."})
            
            with LOCK:
                orders = load_orders()
                total_revenue = sum(o.get("total", 0) for o in orders)
                return self.send_json_response(200, {
                    "total_orders": len(orders),
                    "total_revenue": total_revenue,
                    "orders": list(reversed(orders))
                })

        return super().do_GET()

    def do_POST(self):
        parsed_path = self.path.split("?")[0]
        
        # API 3: Create Order Endpoint
        if parsed_path == "/api/order":
            try:
                content_length = int(self.headers.get("Content-Length", 0))
                if content_length <= 0 or content_length > MAX_BODY_SIZE:
                    return self.send_json_response(413, {"error": "Payload size invalid"})
                
                body = self.rfile.read(content_length)
                data = json.loads(body.decode("utf-8"))
            except Exception:
                return self.send_json_response(400, {"error": "Invalid JSON format"})

            customer_name = sanitize(data.get("name", "Web Customer"))
            phone = sanitize(data.get("phone", "WhatsApp"))
            total_amount = float(data.get("total", 0))
            items = data.get("items", [])

            new_order = {
                "id": int(time.time() * 1000),
                "received": time.strftime("%Y-%m-%d %H:%M:%S"),
                "status": "Pending",
                "name": customer_name,
                "phone": phone,
                "total": total_amount,
                "items": items
            }

            with LOCK:
                orders = load_orders()
                orders.append(new_order)
                save_orders(orders)

            return self.send_json_response(200, {
                "success": True,
                "message": "Order successfully synchronized with backend!",
                "order_id": new_order["id"]
            })

        return self.send_json_response(404, {"error": "Endpoint not found"})

if __name__ == "__main__":
    print("=======================================================")
    print(f"🚀 Nollie's Full-Stack Infrastructure Running")
    print(f"📍 Location: http://localhost:{PORT}")
    print(f"🔒 Admin Key: {ADMIN_KEY}")
    print("=======================================================")
    server = ThreadingHTTPServer((HOST, PORT), NollieRequestHandler)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nShutting down server gracefully...")
        server.server_close()
SERVER_EOF

# 3. Connect Frontend API JS Bridge (public/js/app.js)
echo "Writing Frontend API Integration Script..."
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
    syncBackendTelemetry();
    initCharts();
});

function renderProducts(items) {
    const container = document.getElementById('product-list');
    if (!container) return;
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
        syncBackendTelemetry();
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

async function syncBackendTelemetry() {
    try {
        const res = await fetch('/api/orders', {
            headers: { 'X-Admin-Key': 'mysecret' }
        });
        if (res.ok) {
            const data = await res.json();
            const counter = document.getElementById('live-order-counter');
            if (counter) counter.innerText = data.total_orders || 0;

            const revEl = document.getElementById('visual-revenue');
            if (revEl) revEl.innerText = `R ${(data.total_revenue || 0).toFixed(2)}`;

            const profitEl = document.getElementById('visual-profit');
            if (profitEl) profitEl.innerText = `R ${((data.total_revenue || 0) * 0.28).toFixed(2)}`;
        }
    } catch (err) {
        console.log("Offline mode or connecting to backend...");
    }
}

function initCharts() {
    const el1 = document.getElementById('salesChart');
    if (el1) {
        const ctx1 = el1.getContext('2d');
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
    }

    const el2 = document.getElementById('expensesChart');
    if (el2) {
        const ctx2 = el2.getContext('2d');
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
}

function updateCharts() {
    if (salesChartInstance) salesChartInstance.update();
    if (expensesChartInstance) expensesChartInstance.update();
}

async function checkoutWhatsApp() {
    if (cart.length === 0) return alert('Your cart is empty!');

    let subtotal = cart.reduce((sum, item) => sum + item.price, 0);
    let grandTotal = subtotal + deliveryFee;

    // Send payload directly to Python Backend Infrastructure API
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
        syncBackendTelemetry();
    } catch (e) {
        console.warn("Backend offline, launching WhatsApp directly.");
    }

    let msg = "Hi Nollie's (eNanda), I would like to order:%0A%0A";
    cart.forEach(item => {
        msg += `• ${item.title} - R${item.price}%0A`;
    });
    msg += `%0ADelivery Fee: R30%0A*Total: R${grandTotal.toFixed(2)}*`;

    window.open(`https://wa.me/?text=${msg}`, '_blank');
}
JS_EOF

# 4. Sync root files
cp public/index.html index.html 2>/dev/null || true

echo "======================================================="
echo "✅ Full-Stack Backend & Frontend Integration Completed!"
echo "======================================================="
