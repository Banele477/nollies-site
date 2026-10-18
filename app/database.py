import os
import sqlite3
import json
import datetime

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
            customer_name TEXT,
            customer_phone TEXT,
            comm_preference TEXT,
            delivery_address TEXT,
            items TEXT,
            total REAL
        )
    ''')
    conn.commit()
    conn.close()

def load_orders():
    init_db()
    try:
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
                "customer_name": r["customer_name"] if "customer_name" in r.keys() else "",
                "customer_phone": r["customer_phone"] if "customer_phone" in r.keys() else "",
                "comm_preference": r["comm_preference"] if "comm_preference" in r.keys() else "whatsapp",
                "delivery_address": r["delivery_address"] if "delivery_address" in r.keys() else "",
                "items": json.loads(r["items"]),
                "total": r["total"]
            })
        return orders
    except Exception as e:
        print(f"Error loading orders: {e}")
        return []

def save_order(items, total, customer_name="", customer_phone="", comm_preference="whatsapp", delivery_address=""):
    init_db()
    date_str = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    items_json = json.dumps(items)
    
    conn = sqlite3.connect(DB_FILE)
    cursor = conn.cursor()
    cursor.execute('''
        INSERT INTO orders (date, customer_name, customer_phone, comm_preference, delivery_address, items, total) 
        VALUES (?, ?, ?, ?, ?, ?, ?)
    ''', (date_str, customer_name, customer_phone, comm_preference, delivery_address, items_json, total))
    conn.commit()
    new_id = cursor.lastrowid
    conn.close()
    
    return {
        "id": new_id, 
        "date": date_str, 
        "customer_name": customer_name,
        "customer_phone": customer_phone,
        "comm_preference": comm_preference,
        "delivery_address": delivery_address,
        "items": items, 
        "total": total
    }

def save_orders(items, total, **kwargs):
    return save_order(items, total, **kwargs)
