import os
import datetime
import json
from flask import Flask, render_template, send_from_directory, request, jsonify

app = Flask(__name__, static_folder='public', static_url_path='/public')

# ==========================================
# ENTERPRISE SECURITY & HEADERS
# ==========================================
@app.after_request
def apply_security_headers(response):
    response.headers["X-Frame-Options"] = "SAMEORIGIN"
    response.headers["X-Content-Type-Options"] = "nosniff"
    response.headers["X-XSS-Protection"] = "1; mode=block"
    response.headers["Referrer-Policy"] = "strict-origin-when-cross-origin"
    response.headers["Server"] = "Nollies-Engine/2.0"
    return response

# ==========================================
# REST API ENDPOINTS
# ==========================================
@app.route('/')
def index():
    return send_from_directory('.', 'index.html')

@app.route('/api/telemetry', methods=['POST'])
def handle_telemetry():
    data = request.get_json() or {}
    client_ip = request.remote_addr
    log_entry = {
        "timestamp": datetime.datetime.now(datetime.timezone.utc).isoformat(),
        "ip": client_ip,
        "userAgent": request.headers.get('User-Agent'),
        "clientData": data
    }
    try:
        with open("visitor_analytics.log", "a") as f:
            f.write(json.dumps(log_entry) + "\n")
    except Exception as e:
        print(f"[-] Log error: {e}")
    return jsonify({"status": "success", "recorded": True})

@app.route('/api/order', methods=['POST'])
def handle_order():
    data = request.get_json() or {}
    data['timestamp'] = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    # Save locally to order repository
    try:
        with open("orders_database.log", "a") as f:
            f.write(json.dumps(data) + "\n")
    except Exception as e:
        print(f"[-] Order record error: {e}")

    return jsonify({
        "status": "success", 
        "message": "Order dispatched to owner hotline (0625873479)",
        "whatsapp_url": f"https://wa.me/27625873479?text=Order%20for%20{data.get('product', 'Nollies Solution')}"
    })

if __name__ == '__main__':
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port, debug=True)
