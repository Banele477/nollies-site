import os
import time
from flask import Blueprint, jsonify, request, send_from_directory
from app.database import load_orders, save_order

bp = Blueprint("main", __name__)
ADMIN_KEY = os.environ.get("ADMIN_KEY", "mysecret")
STATIC_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "static"))

@bp.route("/")
def index():
    return send_from_directory(STATIC_DIR, "index.html")

@bp.route("/manifest.json")
def manifest():
    return send_from_directory(STATIC_DIR, "manifest.json")

@bp.route("/sw.js")
def sw():
    return send_from_directory(STATIC_DIR, "sw.js")

@bp.route("/api/health", methods=["GET"])
def health():
    return jsonify({"status": "healthy", "architecture": "production-grade", "hub": "eNanda"})

@bp.route("/api/orders", methods=["GET"])
def get_orders():
    if request.headers.get("X-Admin-Key", "") != ADMIN_KEY:
        return jsonify({"error": "Unauthorized"}), 401
    orders = load_orders()
    return jsonify({"total_orders": len(orders), "orders": list(reversed(orders))})

@bp.route("/api/order", methods=["POST"])
def create_order():
    try:
        data = request.get_json(force=True)
    except Exception:
        return jsonify({"error": "Invalid JSON Payload"}), 400

    new_order = {
        "id": int(time.time() * 1000),
        "received": time.strftime("%Y-%m-%d %H:%M:%S"),
        "status": "Pending",
        "name": str(data.get("name", "eNanda Customer"))[:100],
        "phone": str(data.get("phone", "WhatsApp"))[:50],
        "total": float(data.get("total", 0)),
        "items": data.get("items", [])
    }
    orders = load_orders()
    orders.append(new_order)
    save_order(orders)
    return jsonify({"success": True, "order_id": new_order["id"]})
