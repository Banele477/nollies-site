import os
import json

DATA_DIR = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'data')
ORDERS_FILE = os.path.join(DATA_DIR, 'orders.json')

def init_db():
    if not os.path.exists(DATA_DIR):
        os.makedirs(DATA_DIR, exist_ok=True)
    if not os.path.exists(ORDERS_FILE):
        with open(ORDERS_FILE, 'w') as f:
            json.dump([], f)

def load_orders():
    if not os.path.exists(ORDERS_FILE):
        return []
    try:
        with open(ORDERS_FILE, 'r') as f:
            return json.load(f)
    except Exception:
        return []

def save_order(items, total):
    init_db()
    orders = load_orders()
    new_order = {
        "id": len(orders) + 1,
        "items": items,
        "total": total
    }
    orders.insert(0, new_order)
    with open(ORDERS_FILE, 'w') as f:
        json.dump(orders, f, indent=2)
    return new_order
