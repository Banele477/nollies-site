import os
import json
import time

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA_DIR = os.path.join(BASE_DIR, "data")
ORDERS_FILE = os.path.join(DATA_DIR, "orders.json")

def load_orders():
    if not os.path.exists(ORDERS_FILE):
        return []
    try:
        with open(ORDERS_FILE, "r", encoding="utf-8") as f:
            return json.load(f)
    except Exception as e:
        print(f"[DB ERROR] Failed to load orders: {e}")
        return []

def save_orders(orders):
    os.makedirs(DATA_DIR, exist_ok=True)
    temp_file = f"{ORDERS_FILE}.tmp.{int(time.time() * 1000)}"
    try:
        with open(temp_file, "w", encoding="utf-8") as f:
            json.dump(orders, f, ensure_ascii=False, indent=2)
        os.replace(temp_file, ORDERS_FILE)
        return True
    except Exception as e:
        print(f"[DB ERROR] Failed to save orders: {e}")
        if os.path.exists(temp_file):
            os.remove(temp_file)
        return False
