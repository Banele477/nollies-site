import os
import time
from flask import Flask, jsonify, request, send_from_directory
from app.database import load_orders, save_orders

BASE = os.path.dirname(os.path.abspath(__file__))
PUBLIC = os.path.join(BASE, "public")
ADMIN_KEY = os.environ.get("ADMIN_KEY", "mysecret")

try:
    import images as imgtools
except Exception:
    imgtools = None

app = Flask(__name__, static_folder=PUBLIC, static_url_path="")

@app.get("/")
def index():
    return send_from_directory(PUBLIC, "index.html")

@app.get("/admin")
def admin_panel():
    return send_from_directory(PUBLIC, "admin.html")

@app.get("/img/manifest.json")
def img_manifest():
    if imgtools is None:
        return send_from_directory(os.path.join(PUBLIC, "img"), "manifest.json")
    r = jsonify(imgtools.build_manifest(PUBLIC))
    r.headers["Cache-Control"] = "no-store"
    return r

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
    return jsonify({"recent_orders": list(reversed(recent)), "total_fulfilled": len(orders)})

@app.get("/api/orders")
def get_orders():
    if request.headers.get("X-Admin-Key", "") != ADMIN_KEY:
        return jsonify({"error": "Unauthorized"}), 401
    orders = load_orders()
    return jsonify({"total_orders": len(orders), "orders": list(reversed(orders))})

@app.post("/api/order")
def create_order():
    try:
        data = request.get_json(force=True)
    except Exception:
        return jsonify({"error": "Invalid JSON Payload"}), 400

    new_order = {
        "id": int(time.time() * 1000),
        "received": time.strftime("%Y-%m-%d %H:%M:%S"),
        "status": "Processing in eNanda",
        "name": str(data.get("name", "eNanda Customer"))[:100],
        "phone": str(data.get("phone", "WhatsApp"))[:50],
        "total": float(data.get("total", 0)),
        "items": data.get("items", [])
    }
    orders = load_orders()
    orders.append(new_order)
    save_orders(orders)
    return jsonify({"success": True, "order_id": new_order["id"]})

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    print(f"👑 Nollie's Enterprise Server running on http://localhost:{port}")
    app.run(host="0.0.0.0", port=port, debug=False)
