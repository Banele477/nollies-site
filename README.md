# Nollie's Small Business website

Run (Termux):
    pkg install python -y
    ADMIN_KEY=choose-a-password python server.py
Open http://localhost:8080 in your phone browser.

Edit these files:
    public/js/config.js    WhatsApp number, delivery fees, links, policy text
    public/js/products.js  products, prices, categories
    public/css/style.css   colours and look (see :root at the top)

Orders are sent to WhatsApp and also saved in data/orders.json.
View them at /admin.html (needs ADMIN_KEY).
