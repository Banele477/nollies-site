# Nollie's website

Juice, perfume, combo packs, hampers and cereals. Online ordering stored in a database (SQLite), order tracking for customers, admin dashboard for the owner.

## What is in this repo
| Path | Purpose |
|---|---|
| `nollies_server.py` | Starts the site (serves `public/` and the order API) |
| `orders_api.py` | Database, order API, admin API |
| `public/` | The website: `index.html`, `admin.html`, `css/`, `js/`, PWA files, SEO files |
| `public/products.json` | Starting product list. Copied into the database the first time only |
| `tools/purge_old_orders.py` | Deletes old finished orders (retention) |
| `data/` | Created at runtime, holds `nollies.db`. NOT in git |

## Run it (Termux or any computer)
```
pip install -r requirements.txt
ADMIN_KEY=your-long-secret python3 nollies_server.py
```
Shop: http://localhost:5000   Admin: http://localhost:5000/admin.html

Without `ADMIN_KEY` the admin page stays disabled. Never commit the key.
After the first run, edit prices and switch products on or off in the admin page (the database is the source of truth, not `products.json`).

## Put it online (PythonAnywhere)
1. In a Bash console: `git clone <this repo> nollies`
2. Web tab: add a Flask web app (manual configuration), then edit the WSGI file:
```
import os, sys
path = '/home/YOURUSERNAME/nollies'
if path not in sys.path:
    sys.path.insert(0, path)
os.environ['ADMIN_KEY'] = 'your-long-secret'
from nollies_server import app as application
```
3. Click Reload. To update later: `git pull`, then Reload.

## Looking after it
- Back up `data/nollies.db` regularly.
- Delete a customer's order from the admin page when they ask.
- Clean old orders: `python3 tools/purge_old_orders.py 365`
- The privacy notice (in `public/index.html`) says old records are deleted: keep to that.
