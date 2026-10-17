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
