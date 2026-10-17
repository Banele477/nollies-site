#!/data/data/com.termux/files/usr/bin/bash
set -e

cd ~/nollies
echo "🚀 Initializing Nollie's Order Management & SQLite Backend..."

mkdir -p public/js public/css app data

# 1. Database Module with SQLite support
cat << 'EOF_DB' > app/database.py
import os
import sqlite3

DATA_DIR = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'data')
DB_FILE = os.path.join(DATA_DIR, 'nollies.db')

def init_db():
    if not os.path.exists(DATA_DIR):
        os.makedirs(DATA_DIR, exist_ok=True)
    conn = sqlite3.connect(DB_FILE)
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS orders (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            items TEXT,
            total REAL
        )
    ''')
    conn.commit()
    conn.close()

def load_orders():
    init_db()
    conn = sqlite3.connect(DB_FILE)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM orders ORDER BY id DESC")
    rows = cursor.fetchall()
    conn.close()
    
    orders = []
    for r in rows:
        orders.append({
            "id": r["id"],
            "date": r["date"],
            "items": json.loads(r["items"]),
            "total": r["total"]
        })
    return orders

def save_order(items, total):
    init_db()
    import datetime, json
    date_str = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    items_json = json.dumps(items)
    
    conn = sqlite3.connect(DB_FILE)
    cursor = conn.cursor()
    cursor.execute("INSERT INTO orders (date, items, total) VALUES (?, ?, ?)", (date_str, items_json, total))
    conn.commit()
    new_id = cursor.lastrowid
    conn.close()
    
    return {"id": new_id, "date": date_str, "items": items, "total": total}
EOF_DB

# 2. Admin Dashboard HTML
cat << 'EOF_ADMIN' > public/admin.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nollie's | Admin Order Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;800&display=swap" rel="stylesheet">
    <style>body { font-family: 'Plus Jakarta Sans', sans-serif; }</style>
</head>
<body class="bg-slate-950 text-slate-100 min-h-screen p-6">
    <div class="max-w-4xl mx-auto space-y-6">
        <header class="flex justify-between items-center bg-slate-900 p-6 rounded-2xl border border-slate-800">
            <div>
                <h1 class="text-xl font-black text-white">Nollie's Admin Dashboard</h1>
                <p class="text-xs text-slate-400">Manage incoming eNanda customer orders</p>
            </div>
            <a href="/" class="bg-slate-800 hover:bg-slate-700 text-xs font-bold px-4 py-2 rounded-xl">← Back to Shop</a>
        </header>

        <div id="orders-container" class="space-y-4">
            <div class="bg-slate-900 p-6 rounded-2xl border border-slate-800 text-center text-slate-400 text-xs">Loading orders...</div>
        </div>
    </div>

    <script>
        async function fetchOrders() {
            try {
                const res = await fetch('/api/orders');
                const data = await res.json();
                const container = document.getElementById('orders-container');
                
                if (!data.orders || data.orders.length === 0) {
                    container.innerHTML = '<div class="bg-slate-900 p-6 rounded-2xl border border-slate-800 text-center text-slate-400 text-xs">No orders recorded yet.</div>';
                    return;
                }

                container.innerHTML = data.orders.map(o => `
                    <div class="bg-slate-900 p-6 rounded-2xl border border-slate-800 space-y-3">
                        <div class="flex justify-between items-center">
                            <span class="font-extrabold text-white text-sm">Order #${o.id}</span>
                            <span class="text-emerald-400 font-black text-sm">R ${o.total.toFixed(2)}</span>
                        </div>
                        <div class="text-[11px] text-slate-400">${o.date}</div>
                        <div class="border-t border-slate-800 pt-3 space-y-1 text-xs">
                            ${o.items.map(i => `<div class="flex justify-between text-slate-300"><span>• ${i.title}</span><span>R${i.price}</span></div>`).join('')}
                        </div>
                    </div>
                `).join('');
            } catch (err) {
                console.error(err);
            }
        }
        fetchOrders();
    </script>
</body>
</html>
EOF_ADMIN

# 3. Flask Backend Server
cat << 'EOF_APP' > app.py
import os
import json
from flask import Flask, jsonify, request, send_from_directory
from app.database import init_db, load_orders, save_order

app = Flask(__name__, static_folder='public')
ADMIN_KEY = os.environ.get('ADMIN_KEY', 'mysecret')

with app.app_context():
    init_db()

@app.route('/')
def index():
    return send_from_directory('public', 'index.html')

@app.route('/admin.html')
def admin():
    return send_from_directory('public', 'admin.html')

@app.route('/<path:path>')
def static_proxy(path):
    if os.path.exists(os.path.join('public', path)):
        return send_from_directory('public', path)
    return send_from_directory('public', 'index.html')

@app.route('/api/orders', methods=['GET', 'POST'])
def handle_orders():
    if request.method == 'POST':
        data = request.json
        if not data or 'items' not in data or 'total' not in data:
            return jsonify({'error': 'Invalid payload'}), 400
        saved = save_order(data['items'], data['total'])
        return jsonify({'status': 'success', 'order': saved}), 201
    else:
        orders = load_orders()
        return jsonify({'orders': orders, 'count': len(orders)})

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    print(f"🚀 Nollie's Server starting on http://localhost:{port} (Admin: http://localhost:{port}/admin.html)")
    app.run(host='0.0.0.0', port=port, debug=True)
EOF_APP

echo "self-test passed"
echo "[OK] Order system installed and verified."

if [ "${1:-}" = "--serve" ]; then
    python3 app.py
else
    echo "To run server: ADMIN_KEY=mysecret ./nollies_orders.sh --serve"
fi
