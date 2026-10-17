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
    date_str = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    items_json = json.dumps(items)
    
    conn = sqlite3.connect(DB_FILE)
    cursor = conn.cursor()
    cursor.execute("INSERT INTO orders (date, items, total) VALUES (?, ?, ?)", (date_str, items_json, total))
    conn.commit()
    new_id = cursor.lastrowid
    conn.close()
    
    return {"id": new_id, "date": date_str, "items": items, "total": total}

# Alias to support any modules importing save_orders plural
def save_orders(items, total):
    return save_order(items, total)
