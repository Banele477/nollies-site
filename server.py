#!/usr/bin/env python3
"""Tiny server for Nollie's website. No heavy dependencies.

Run: ADMIN_KEY=your-secret python server.py
Open: http://localhost:8080 (shop)
      http://localhost:8080/admin.html
"""

import os, json, threading, time
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer

BASE = os.path.dirname(os.path.abspath(__file__))
PUBLIC = os.path.join(BASE, "public")
DATA = os.path.join(BASE, "data", "orders.json")
HOST = os.environ.get("HOST", "0.0.0.0")
PORT = int(os.environ.get("PORT", "8080"))
ADMIN_KEY = os.environ.get("ADMIN_KEY", "")
LOCK = threading.Lock()
MAX_BODY = 20_000

print(f"Nollie's server starting on port {PORT}...")
