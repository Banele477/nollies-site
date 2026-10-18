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
    
    # Orders Table
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS orders (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            customer_name TEXT,
            customer_phone TEXT,
            comm_preference TEXT,
            delivery_address TEXT,
            items TEXT,
            payment_method TEXT,
            payment_status TEXT,
            total REAL
        )
    ''')
    
    # Bookings Table
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS bookings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            customer_name TEXT,
            customer_phone TEXT,
            service_type TEXT,
            booking_date TEXT,
            booking_time TEXT,
            notes TEXT,
            status TEXT
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
                "payment_method": r["payment_method"] if "payment_method" in r.keys() else "COD",
                "payment_status": r["payment_status"] if "payment_status" in r.keys() else "Pending",
                "total": r["total"]
            })
        return orders
    except Exception as e:
        print(f"Error loading orders: {e}")
        return []

def save_order(items, total, customer_name="", customer_phone="", comm_preference="whatsapp", delivery_address="", payment_method="COD", payment_status="Pending"):
    init_db()
    date_str = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    items_json = json.dumps(items)
    
    conn = sqlite3.connect(DB_FILE)
    cursor = conn.cursor()
    cursor.execute('''
        INSERT INTO orders (date, customer_name, customer_phone, comm_preference, delivery_address, items, payment_method, payment_status, total) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', (date_str, customer_name, customer_phone, comm_preference, delivery_address, items_json, payment_method, payment_status, total))
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
        "payment_method": payment_method,
        "payment_status": payment_status,
        "total": total
    }

def save_booking(customer_name, customer_phone, service_type, booking_date, booking_time, notes=""):
    init_db()
    date_str = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    conn = sqlite3.connect(DB_FILE)
    cursor = conn.cursor()
    cursor.execute('''
        INSERT INTO bookings (date, customer_name, customer_phone, service_type, booking_date, booking_time, notes, status) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ''', (date_str, customer_name, customer_phone, service_type, booking_date, booking_time, notes, "Confirmed"))
    conn.commit()
    new_id = cursor.lastrowid
    conn.close()
    
    return {
        "id": new_id,
        "date": date_str,
        "customer_name": customer_name,
        "customer_phone": customer_phone,
        "service_type": service_type,
        "booking_date": booking_date,
        "booking_time": booking_time,
        "notes": notes,
        "status": "Confirmed"
    }

def load_bookings():
    init_db()
    try:
        conn = sqlite3.connect(DB_FILE)
        conn.row_factory = sqlite3.Row
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM bookings ORDER BY id DESC")
        rows = cursor.fetchall()
        conn.close()
        
        bookings = []
        for r in rows:
            bookings.append({
                "id": r["id"],
                "date": r["date"],
                "customer_name": r["customer_name"],
                "customer_phone": r["customer_phone"],
                "service_type": r["service_type"],
                "booking_date": r["booking_date"],
                "booking_time": r["booking_time"],
                "notes": r["notes"],
                "status": r["status"]
            })
        return bookings
    except Exception as e:
        print(f"Error loading bookings: {e}")
        return []
