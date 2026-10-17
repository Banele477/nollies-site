"""Nollie's order database + API (SQLite, Flask blueprint)."""
import csv, hmac, io, json, os, re, secrets, sqlite3, time
from datetime import datetime, timezone
from functools import wraps
from flask import Blueprint, Response, g, jsonify, request

bp = Blueprint("orders", __name__)
BASE = os.path.dirname(os.path.abspath(__file__))
DB_PATH = os.environ.get("NOLLIES_DB", os.path.join(BASE, "data", "nollies.db"))
STATUSES = ("new", "confirmed", "out_for_delivery", "delivered", "cancelled")
CATEGORIES = ("juice", "perfume", "combo", "cereal")
REF_CHARS = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789"   # no look-alike characters

SCHEMA = """
CREATE TABLE IF NOT EXISTS products(
  id TEXT PRIMARY KEY, category TEXT NOT NULL, icon TEXT NOT NULL DEFAULT '',
  name TEXT NOT NULL, description TEXT NOT NULL DEFAULT '',
  price REAL NOT NULL CHECK(price >= 0), active INTEGER NOT NULL DEFAULT 1);
CREATE TABLE IF NOT EXISTS orders(
  id INTEGER PRIMARY KEY AUTOINCREMENT, ref TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL, phone TEXT NOT NULL, area TEXT NOT NULL, note TEXT NOT NULL DEFAULT '',
  total REAL NOT NULL, status TEXT NOT NULL DEFAULT 'new', created_at TEXT NOT NULL);
CREATE TABLE IF NOT EXISTS order_items(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  order_id INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  product_id TEXT NOT NULL, name TEXT NOT NULL, price REAL NOT NULL, qty INTEGER NOT NULL);
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(status);
CREATE INDEX IF NOT EXISTS idx_items_order ON order_items(order_id);
"""


def now_iso():
    return datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S")


def db():
    if "db" not in g:
        g.db = sqlite3.connect(DB_PATH)
        g.db.row_factory = sqlite3.Row
        g.db.execute("PRAGMA foreign_keys=ON")
    return g.db


@bp.teardown_app_request
def close_db(_exc):
    con = g.pop("db", None)
    if con is not None:
        con.close()


def init_app(app):
    os.makedirs(os.path.dirname(DB_PATH), exist_ok=True)
    con = sqlite3.connect(DB_PATH)
    try:
        con.executescript(SCHEMA)
        if con.execute("SELECT COUNT(*) FROM products").fetchone()[0] == 0:
            seed = os.path.join(BASE, "public", "products.json")
            if os.path.exists(seed):
                with open(seed, encoding="utf-8") as fh:
                    for p in json.load(fh):
                        con.execute(
                            "INSERT OR IGNORE INTO products(id,category,icon,name,description,price,active) "
                            "VALUES(?,?,?,?,?,?,1)",
                            (p["id"], p["category"], p.get("icon", ""), p["name"], p.get("desc", ""), float(p["price"])))
        con.commit()
    finally:
        con.close()
    app.config["MAX_CONTENT_LENGTH"] = 32 * 1024
    app.register_blueprint(bp, url_prefix="/api")


# ------------------------------------------------------------------ helpers --
_hits = {}


def rate_limited(ip, limit=10, window=3600):
    now = time.time()
    recent = [t for t in _hits.get(ip, []) if now - t < window]
    if len(recent) >= limit:
        _hits[ip] = recent
        return True
    recent.append(now)
    _hits[ip] = recent
    return False


def admin_only(fn):
    @wraps(fn)
    def wrapper(*a, **kw):
        key = os.environ.get("ADMIN_KEY", "")
        if not key:
            return jsonify(error="Admin is disabled. Start the server with ADMIN_KEY set."), 503
        given = request.headers.get("X-Admin-Key", "")
        if not hmac.compare_digest(given.encode(), key.encode()):
            return jsonify(error="Wrong admin key."), 401
        return fn(*a, **kw)
    return wrapper


def new_ref(con):
    while True:
        ref = "NL-" + "".join(secrets.choice(REF_CHARS) for _ in range(6))
        if not con.execute("SELECT 1 FROM orders WHERE ref=?", (ref,)).fetchone():
            return ref


def items_of(con, order_id):
    return [dict(name=r["name"], qty=r["qty"], price=r["price"])
            for r in con.execute("SELECT name,qty,price FROM order_items WHERE order_id=?", (order_id,))]


def bad(msg, code=400):
    return jsonify(error=msg), code


# ------------------------------------------------------------ public routes --
@bp.get("/products")
def products():
    rows = db().execute("SELECT * FROM products WHERE active=1 ORDER BY category,name").fetchall()
    return jsonify([dict(id=r["id"], category=r["category"], icon=r["icon"], name=r["name"],
                         desc=r["description"], price=r["price"]) for r in rows])


@bp.post("/orders")
def create_order():
    if rate_limited(request.remote_addr or "?"):
        return bad("Too many orders from this device. Please try again later.", 429)
    d = request.get_json(silent=True) or {}
    name = str(d.get("name", "")).strip()[:80]
    phone = re.sub(r"\D", "", str(d.get("phone", "")))
    area = str(d.get("area", "")).strip()[:120]
    note = str(d.get("note", "")).strip()[:300]
    if not name or not area:
        return bad("Please enter your name and delivery area.")
    if not 9 <= len(phone) <= 15:
        return bad("Please enter a valid phone number.")
    raw = d.get("items")
    if not isinstance(raw, list) or not raw or len(raw) > 50:
        return bad("Your cart is empty.")
    qty = {}
    for it in raw:
        if not isinstance(it, dict):
            continue
        pid = str(it.get("id", ""))
        try:
            q = int(it.get("qty", 0))
        except (TypeError, ValueError):
            q = 0
        if 1 <= q <= 99:
            qty[pid] = min(99, qty.get(pid, 0) + q)
    if not qty:
        return bad("Your cart is empty.")

    con = db()
    marks = ",".join("?" * len(qty))
    rows = con.execute(f"SELECT id,name,price FROM products WHERE active=1 AND id IN ({marks})", list(qty)).fetchall()
    if len(rows) != len(qty):
        return bad("Some items are no longer available. Please refresh the page.")
    total = round(sum(r["price"] * qty[r["id"]] for r in rows), 2)   # server decides the price
    ref = new_ref(con)
    cur = con.execute(
        "INSERT INTO orders(ref,name,phone,area,note,total,status,created_at) VALUES(?,?,?,?,?,?,?,?)",
        (ref, name, phone, area, note, total, "new", now_iso()))
    con.executemany(
        "INSERT INTO order_items(order_id,product_id,name,price,qty) VALUES(?,?,?,?,?)",
        [(cur.lastrowid, r["id"], r["name"], r["price"], qty[r["id"]]) for r in rows])
    con.commit()
    return jsonify(ref=ref, total=total, status="new"), 201


@bp.get("/orders/<ref>")
def track(ref):
    phone = re.sub(r"\D", "", request.args.get("phone", ""))
    con = db()
    o = con.execute("SELECT * FROM orders WHERE ref=?", (ref.upper(),)).fetchone()
    # same 404 for wrong ref or wrong phone, so refs cannot be probed
    if not o or len(phone) < 9 or o["phone"][-9:] != phone[-9:]:
        return bad("Not found.", 404)
    return jsonify(ref=o["ref"], status=o["status"], total=o["total"],
                   created_at=o["created_at"], items=items_of(con, o["id"]))


# ------------------------------------------------------------- admin routes --
@bp.get("/admin/orders")
@admin_only
def admin_orders():
    st = request.args.get("status", "")
    q, args = "SELECT * FROM orders", []
    if st in STATUSES:
        q += " WHERE status=?"
        args.append(st)
    con = db()
    out = []
    for o in con.execute(q + " ORDER BY id DESC LIMIT 300", args):
        out.append(dict(ref=o["ref"], name=o["name"], phone=o["phone"], area=o["area"], note=o["note"],
                        total=o["total"], status=o["status"], created_at=o["created_at"],
                        items=items_of(con, o["id"])))
    return jsonify(out)


@bp.patch("/admin/orders/<ref>")
@admin_only
def admin_set_status(ref):
    st = (request.get_json(silent=True) or {}).get("status")
    if st not in STATUSES:
        return bad("Invalid status.")
    con = db()
    cur = con.execute("UPDATE orders SET status=? WHERE ref=?", (st, ref))
    con.commit()
    return jsonify(ok=True) if cur.rowcount else bad("Order not found.", 404)


def csv_safe(v):
    s = str(v)
    return "'" + s if s[:1] in ("=", "+", "-", "@") else s   # blocks spreadsheet formula injection


@bp.get("/admin/orders.csv")
@admin_only
def admin_csv():
    con = db()
    buf = io.StringIO()
    w = csv.writer(buf)
    w.writerow(["ref", "created_at_utc", "status", "name", "phone", "area", "note", "items", "total"])
    for o in con.execute("SELECT * FROM orders ORDER BY id DESC"):
        items = "; ".join(f"{i['qty']} x {i['name']}" for i in items_of(con, o["id"]))
        w.writerow([csv_safe(x) for x in (o["ref"], o["created_at"], o["status"], o["name"], o["phone"],
                                          o["area"], o["note"], items, f"{o['total']:.2f}")])
    return Response(buf.getvalue(), mimetype="text/csv",
                    headers={"Content-Disposition": "attachment; filename=nollies_orders.csv"})


@bp.get("/admin/products")
@admin_only
def admin_products():
    rows = db().execute("SELECT * FROM products ORDER BY category,name").fetchall()
    return jsonify([dict(id=r["id"], category=r["category"], icon=r["icon"], name=r["name"],
                         desc=r["description"], price=r["price"], active=bool(r["active"])) for r in rows])


@bp.put("/admin/products/<pid>")
@admin_only
def admin_put_product(pid):
    if not re.fullmatch(r"[a-z0-9-]{2,40}", pid):
        return bad("Product id: 2-40 chars, lowercase letters, digits, dashes.")
    d = request.get_json(silent=True) or {}
    con = db()
    cur = con.execute("SELECT * FROM products WHERE id=?", (pid,)).fetchone()
    try:
        price = float(d.get("price", cur["price"] if cur else ""))
    except (TypeError, ValueError):
        return bad("Price must be a number.")
    if not 0 <= price <= 100000:
        return bad("Price out of range.")
    cat = str(d.get("category", cur["category"] if cur else "")).strip()
    if cat not in CATEGORIES:
        return bad("Category must be one of: " + ", ".join(CATEGORIES))
    name = str(d.get("name", cur["name"] if cur else "")).strip()[:80]
    if not name:
        return bad("Name is required.")
    desc = str(d.get("desc", cur["description"] if cur else "")).strip()[:200]
    icon = str(d.get("icon", cur["icon"] if cur else "")).strip()[:8]
    active = 1 if d.get("active", bool(cur["active"]) if cur else True) else 0
    con.execute("INSERT OR REPLACE INTO products(id,category,icon,name,description,price,active) VALUES(?,?,?,?,?,?,?)",
                (pid, cat, icon, name, desc, round(price, 2), active))
    con.commit()
    return jsonify(ok=True)


@bp.delete("/admin/orders/<ref>")
@admin_only
def admin_delete_order(ref):
    con = db()
    cur = con.execute("DELETE FROM orders WHERE ref=?", (ref,))   # items go with it (ON DELETE CASCADE)
    con.commit()
    return jsonify(ok=True) if cur.rowcount else bad("Order not found.", 404)
