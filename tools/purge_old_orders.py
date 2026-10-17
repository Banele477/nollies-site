#!/usr/bin/env python3
"""Delete delivered/cancelled orders older than N days (keeps your privacy promise).

Usage:  python3 tools/purge_old_orders.py 365          (asks first)
        python3 tools/purge_old_orders.py 365 --yes     (no question)
A backup copy of the database is saved before anything is deleted.
"""
import os, shutil, sqlite3, sys
from datetime import datetime

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB = os.environ.get("NOLLIES_DB", os.path.join(BASE, "data", "nollies.db"))

if len(sys.argv) < 2 or not sys.argv[1].isdigit() or int(sys.argv[1]) < 30:
    sys.exit("Usage: purge_old_orders.py DAYS [--yes]   (DAYS must be 30 or more)")
days = int(sys.argv[1])
if not os.path.exists(DB):
    sys.exit("Database not found: " + DB)

con = sqlite3.connect(DB)
con.execute("PRAGMA foreign_keys=ON")
where = "status IN ('delivered','cancelled') AND created_at < datetime('now', ?)"
arg = (f"-{days} days",)
n = con.execute(f"SELECT COUNT(*) FROM orders WHERE {where}", arg).fetchone()[0]
print(f"Orders to delete (delivered/cancelled, older than {days} days): {n}")
if n == 0:
    sys.exit(0)
if "--yes" not in sys.argv and input("Delete them permanently? Type yes: ").strip() != "yes":
    sys.exit("Cancelled.")
backup = DB[:-3] + "_backup_" + datetime.now().strftime("%Y%m%d_%H%M%S") + ".db"
shutil.copy2(DB, backup)
print("Backup saved:", backup)
cur = con.execute(f"DELETE FROM orders WHERE {where}", arg)
con.commit()
con.execute("VACUUM")
print("Deleted", cur.rowcount, "orders. Old backups still contain them: delete backups you no longer need.")
