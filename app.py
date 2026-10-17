import os
import time
from flask import Flask, jsonify, request, send_from_directory
from app.database import load_orders, save_orders

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
PUBLIC_DIR = os.path.join(BASE_DIR, "public")
ADMIN_KEY = os.environ.get("ADMIN_KEY", "mysecret")

app = Flask(__name__, static_folder=PUBLIC_DIR, static_url_path="")

@app.after_request
def add_cors_headers(response):
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Headers"] = "Content-Type, X-Admin-Key"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, OPTIONS"
    return response

@app.get("/")
def index():
    return send_from_directory(PUBLIC_DIR, "index.html")

@app.get("/health")
def health_check():
    return jsonify({
        "status": "healthy",
        "timestamp": time.strftime("%Y-%m-%d %H:%M:%S"),
        "service": "Nollies eNanda Backend"
    })

@app.get("/api/public-activity")
def public_activity():
    orders = load_orders()
    recent = []
    for o in orders[-5:]:
        name_masked = o.get("name", "Customer").split()[0] + " (eNanda)"
        recent.append({
            "name": name_masked,
            "received": o.get("received", "Recently"),
            "items_count": len(o.get("items", [])),
            "total": o.get("total", 0)
        })
    return jsonify({
        "recent_orders": list(reversed(recent)),
        "total_fulfilled": len(orders)
    })

@app.get("/api/orders")
def get_orders():
    admin_header = request.headers.get("X-Admin-Key", "")
    if admin_header != ADMIN_KEY:
        return jsonify({"error": "Unauthorized"}), 401
    orders = load_orders()
    return jsonify({
        "total_orders": len(orders),
        "orders": list(reversed(orders))
    })

@app.post("/api/order")
def create_order():
    try:
        data = request.get_json(force=True)
    except Exception:
        return jsonify({"error": "Invalid JSON Payload"}), 400

    if not data or "items" not in data:
        return jsonify({"error": "Missing required order items"}), 400

    items = data.get("items", [])
    if not isinstance(items, list) or len(items) == 0:
        return jsonify({"error": "Items must be a non-empty list"}), 400

    new_order = {
        "id": int(time.time() * 1000),
        "received": time.strftime("%Y-%m-%d %H:%M:%S"),
        "status": "Processing in eNanda",
        "name": str(data.get("name", "eNanda Customer"))[:100],
        "phone": str(data.get("phone", "WhatsApp Checkout"))[:50],
        "total": float(data.get("total", 0)),
        "items": items
    }

    orders = load_orders()
    orders.append(new_order)
    if save_orders(orders):
        return jsonify({"success": True, "order_id": new_order["id"], "order": new_order}), 201
    else:
        return jsonify({"error": "Database write failure"}), 500

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    print(f"⚡ Nollie's Enterprise Flask Backend running on http://0.0.0.0:{port}")
    app.run(host="0.0.0.0", port=port, debug=False)
