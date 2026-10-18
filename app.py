import os
from flask import Flask, jsonify, request, send_from_directory
from app.database import init_db, load_orders, save_order, save_booking, load_bookings

app = Flask(__name__, static_folder='public')

with app.app_context():
    init_db()

@app.route('/')
def index():
    return send_from_directory('public', 'index.html')

@app.route('/<path:path>')
def static_proxy(path):
    if os.path.exists(os.path.join('public', path)):
        return send_from_directory('public', path)
    return send_from_directory('public', 'index.html')

@app.route('/api/orders', methods=['GET', 'POST'])
def handle_orders():
    if request.method == 'POST':
        data = request.json or {}
        if 'items' not in data or 'total' not in data:
            return jsonify({'error': 'Invalid payload'}), 400
        
        saved = save_order(
            items=data['items'], 
            total=data['total'],
            customer_name=data.get('customer_name', ''),
            customer_phone=data.get('customer_phone', ''),
            comm_preference=data.get('comm_preference', 'whatsapp'),
            delivery_address=data.get('delivery_address', ''),
            payment_method=data.get('payment_method', 'COD'),
            payment_status=data.get('payment_status', 'Pending')
        )
        return jsonify({'status': 'success', 'order': saved}), 201
    else:
        orders = load_orders()
        return jsonify({'orders': orders, 'count': len(orders)})

@app.route('/api/bookings', methods=['GET', 'POST'])
def handle_bookings():
    if request.method == 'POST':
        data = request.json or {}
        if 'customer_name' not in data or 'service_type' not in data:
            return jsonify({'error': 'Invalid booking payload'}), 400
        
        saved = save_booking(
            customer_name=data['customer_name'],
            customer_phone=data.get('customer_phone', ''),
            service_type=data['service_type'],
            booking_date=data.get('booking_date', ''),
            booking_time=data.get('booking_time', ''),
            notes=data.get('notes', '')
        )
        return jsonify({'status': 'success', 'booking': saved}), 201
    else:
        bookings = load_bookings()
        return jsonify({'bookings': bookings, 'count': len(bookings)})

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    print(f"🚀 Nollie's Quantum Hub running at http://localhost:{port}")
    app.run(host='0.0.0.0', port=port, debug=True)
