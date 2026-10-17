#!/bin/bash
set -e

cd ~/nollies

echo "======================================================="
echo "⚙️ Restoring Full Nollie's System (Multi-Tab & Backend API)..."
echo "======================================================="

mkdir -p public/css public/js data

# 1. Generate Full Multi-Tab App (Home, Shop, Educational, Telemetry, Account)
cat << 'HTML' > public/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Nollie's | Enterprise & Systems Portal</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body class="light-mode">

    <!-- Top App Header -->
    <header class="app-header">
        <div class="header-left">
            <span class="app-logo">Nollie's<span class="dot">.</span></span>
            <span class="badge-tag">Mzansi Hub</span>
        </div>
        <div class="header-right">
            <button class="icon-btn" onclick="toggleDataSaver()" title="Data Saver">⚡</button>
            <button class="icon-btn" onclick="toggleTheme()" id="theme-btn">🌙</button>
            <div class="cart-pill" onclick="toggleCart()">
                🛒 <span id="cart-count">0</span>
            </div>
        </div>
    </header>

    <!-- Navigation Tabs -->
    <nav class="tab-nav">
        <button class="tab-btn active" onclick="switchTab('shop', this)">🛍️ Shop</button>
        <button class="tab-btn" onclick="switchTab('home', this)">🏠 Home</button>
        <button class="tab-btn" onclick="switchTab('educational', this)">📚 Hub</button>
        <button class="tab-btn" onclick="switchTab('telemetry', this)">📊 Metrics</button>
        <button class="tab-btn" onclick="switchTab('account', this)">👤 Account</button>
    </nav>

    <!-- Main Views Container -->
    <main class="app-body">

        <!-- SHOP TAB -->
        <section id="tab-shop" class="tab-content active-tab">
            <div class="search-box">
                <input type="text" id="search-input" placeholder="Search services..." onkeyup="filterProducts()">
            </div>
            
            <div class="product-grid">
                <div class="card" data-name="smart logistics hub">
                    <span class="badge">Operations</span>
                    <h3>Smart Logistics Hub</h3>
                    <p>End-to-end supply chain setup and inventory workflow optimization.</p>
                    <div class="card-footer">
                        <div class="price">R 890.00</div>
                        <div class="btn-group">
                            <button class="btn btn-add" onclick="addToCart('Smart Logistics Hub', 890)">+ Cart</button>
                            <a href="https://wa.me/?text=Hi%20Nollie's,%20I'm%20interested%20in%20Smart%20Logistics%20Hub" class="btn btn-wa" target="_blank">WhatsApp</a>
                        </div>
                    </div>
                </div>

                <div class="card" data-name="data & systems analytics">
                    <span class="badge">Intelligence</span>
                    <h3>Data & Systems Analytics</h3>
                    <p>Custom dashboards, automated data reporting, and operational insights.</p>
                    <div class="card-footer">
                        <div class="price">R 1,200.00</div>
                        <div class="btn-group">
                            <button class="btn btn-add" onclick="addToCart('Data & Systems Analytics', 1200)">+ Cart</button>
                            <a href="https://wa.me/?text=Hi%20Nollie's,%20I'm%20interested%20in%20Data%20%26%20Systems%20Analytics" class="btn btn-wa" target="_blank">WhatsApp</a>
                        </div>
                    </div>
                </div>

                <div class="card" data-name="urban architecture & tech">
                    <span class="badge">Infrastructure</span>
                    <h3>Urban Architecture & Tech</h3>
                    <p>Digital transformation strategy for physical workspaces and local infrastructure.</p>
                    <div class="card-footer">
                        <div class="price">R 550.00</div>
                        <div class="btn-group">
                            <button class="btn btn-add" onclick="addToCart('Urban Architecture & Tech', 550)">+ Cart</button>
                            <a href="https://wa.me/?text=Hi%20Nollie's,%20I'm%20interested%20in%20Urban%20Architecture%20%26%20Tech" class="btn btn-wa" target="_blank">WhatsApp</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- HOME TAB -->
        <section id="tab-home" class="tab-content">
            <div class="panel">
                <h2>Welcome to Nollie's</h2>
                <p>Streamlined enterprise solutions, digital marketing, and automated business management tools designed for South African enterprises.</p>
            </div>
        </section>

        <!-- EDUCATIONAL TAB -->
        <section id="tab-educational" class="tab-content">
            <div class="panel">
                <h2>Knowledge & Training Hub</h2>
                <p>Access operations management guides, administrative tools, and digital business frameworks.</p>
            </div>
        </section>

        <!-- TELEMETRY TAB -->
        <section id="tab-telemetry" class="tab-content">
            <div class="panel">
                <h2>System Telemetry</h2>
                <div class="status-indicator">
                    <span class="dot-live"></span> Server Online | SQLite DB Active
                </div>
                <div class="metric-box">
                    <span>API Endpoint Status:</span> <strong>200 OK</strong>
                </div>
            </div>
        </section>

        <!-- ACCOUNT TAB -->
        <section id="tab-account" class="tab-content">
            <div class="panel">
                <h2>User Profile & Orders</h2>
                <p>Track active service packages, local payment records, and support tickets.</p>
            </div>
        </section>

    </main>

    <!-- Slide-Up Cart -->
    <div id="cart-modal" class="cart-overlay">
        <div class="cart-drawer">
            <div class="drawer-header">
                <h3>Order Summary</h3>
                <button class="close-icon" onclick="toggleCart()">&times;</button>
            </div>
            <div id="cart-items" class="drawer-body"></div>
            <div class="drawer-footer">
                <div class="total-row">
                    <span>Total Amount:</span>
                    <span id="cart-total">R 0.00</span>
                </div>
                <button class="btn btn-checkout" onclick="checkoutWhatsApp()">Checkout via WhatsApp 💬</button>
            </div>
        </div>
    </div>

    <script src="script.js"></script>
</body>
</html>
HTML

# Sync root index.html
cp public/index.html index.html 2>/dev/null || true

# 2. Modern Multi-Tab CSS
cat << 'CSS' > public/style.css
:root {
    --primary: #4F46E5;
    --wa-green: #25D366;
    --bg: #F8FAFC;
    --card: #FFFFFF;
    --text: #0F172A;
    --muted: #64748B;
    --border: #E2E8F0;
}

body.dark-mode {
    --bg: #0F172A;
    --card: #1E293B;
    --text: #F8FAFC;
    --muted: #94A3B8;
    --border: #334155;
}

* { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }
body { background: var(--bg); color: var(--text); padding-bottom: 20px; }
img { display: none !important; }

.app-header { display: flex; justify-content: space-between; align-items: center; padding: 12px 16px; background: var(--card); border-bottom: 1px solid var(--border); }
.app-logo { font-size: 1.3rem; font-weight: 800; }
.app-logo .dot { color: var(--primary); }
.badge-tag { background: #EEF2FF; color: var(--primary); font-size: 0.7rem; font-weight: 700; padding: 2px 8px; border-radius: 8px; }

.header-right { display: flex; gap: 8px; align-items: center; }
.icon-btn { background: var(--bg); border: 1px solid var(--border); width: 34px; height: 34px; border-radius: 50%; cursor: pointer; color: var(--text); }
.cart-pill { background: var(--primary); color: white; padding: 6px 12px; border-radius: 16px; font-weight: 700; font-size: 0.85rem; cursor: pointer; }

/* Tab Navigation */
.tab-nav { display: flex; background: var(--card); border-bottom: 1px solid var(--border); overflow-x: auto; }
.tab-btn { flex: 1; padding: 12px 8px; border: none; background: none; color: var(--muted); font-weight: 600; font-size: 0.82rem; cursor: pointer; white-space: nowrap; border-bottom: 2px solid transparent; }
.tab-btn.active { color: var(--primary); border-bottom-color: var(--primary); font-weight: 700; }

/* Views */
.app-body { padding: 16px; max-width: 800px; margin: 0 auto; }
.tab-content { display: none; }
.tab-content.active-tab { display: block; }

.panel { background: var(--card); border: 1px solid var(--border); border-radius: 12px; padding: 20px; }
.panel h2 { margin-bottom: 8px; font-size: 1.2rem; }
.panel p { color: var(--muted); font-size: 0.9rem; line-height: 1.4; }

/* Search & Cards */
.search-box { margin-bottom: 16px; }
#search-input { width: 100%; padding: 12px; border-radius: 10px; border: 1px solid var(--border); background: var(--card); color: var(--text); outline: none; }

.product-grid { display: flex; flex-direction: column; gap: 14px; }
.card { background: var(--card); border: 1px solid var(--border); border-radius: 12px; padding: 16px; }
.badge { background: #F1F5F9; color: #475569; font-size: 0.7rem; font-weight: 700; text-transform: uppercase; padding: 3px 6px; border-radius: 4px; }
.card h3 { font-size: 1.1rem; margin: 8px 0 4px; }
.card p { font-size: 0.85rem; color: var(--muted); margin-bottom: 12px; }

.card-footer { display: flex; justify-content: space-between; align-items: center; border-top: 1px dashed var(--border); padding-top: 10px; }
.price { font-size: 1.2rem; font-weight: 800; }
.btn-group { display: flex; gap: 6px; }
.btn { padding: 8px 12px; border-radius: 8px; border: none; font-weight: 700; font-size: 0.8rem; cursor: pointer; text-decoration: none; }
.btn-add { background: var(--primary); color: white; }
.btn-wa { background: var(--wa-green); color: white; }

/* Status & Metrics */
.status-indicator { display: flex; align-items: center; gap: 8px; margin: 12px 0; font-weight: 600; font-size: 0.9rem; }
.dot-live { width: 10px; height: 10px; background: #10B981; border-radius: 50%; }
.metric-box { background: var(--bg); padding: 10px; border-radius: 8px; font-size: 0.85rem; border: 1px solid var(--border); }

/* Cart Overlay */
.cart-overlay { display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.5); z-index: 200; justify-content: flex-end; flex-direction: column; }
.cart-drawer { background: var(--card); border-top-left-radius: 16px; border-top-right-radius: 16px; padding: 20px; max-height: 80vh; }
.drawer-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--border); padding-bottom: 10px; }
.close-icon { background: none; border: none; font-size: 1.3rem; color: var(--muted); cursor: pointer; }
.drawer-body { padding: 16px 0; max-height: 250px; overflow-y: auto; }
.cart-row { display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 0.9rem; }
.drawer-footer { border-top: 1px solid var(--border); padding-top: 12px; }
.total-row { display: flex; justify-content: space-between; font-weight: 800; font-size: 1.1rem; margin-bottom: 12px; }
.btn-checkout { width: 100%; background: var(--wa-green); color: white; padding: 12px; border-radius: 10px; font-weight: 700; border: none; cursor: pointer; }
CSS

# 3. Multi-Tab JavaScript Controller
cat << 'JS' > public/script.js
let cart = [];

function switchTab(tabId, btn) {
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active-tab'));
    
    btn.classList.add('active');
    document.getElementById(`tab-${tabId}`).classList.add('active-tab');
}

function addToCart(title, price) {
    cart.push({ title, price });
    updateCartUI();
    toggleCart();
}

function updateCartUI() {
    document.getElementById('cart-count').innerText = cart.length;
    const container = document.getElementById('cart-items');
    container.innerHTML = '';
    
    let total = 0;
    cart.forEach(item => {
        total += item.price;
        container.innerHTML += `
            <div class="cart-row">
                <div><strong>${item.title}</strong></div>
                <div>R ${item.price.toFixed(2)}</div>
            </div>
        `;
    });

    document.getElementById('cart-total').innerText = `R ${total.toFixed(2)}`;
}

function toggleCart() {
    const modal = document.getElementById('cart-modal');
    modal.style.display = (modal.style.display === 'flex') ? 'none' : 'flex';
}

function toggleTheme() {
    document.body.classList.toggle('dark-mode');
    document.getElementById('theme-btn').innerText = document.body.classList.contains('dark-mode') ? '☀️' : '🌙';
}

function toggleDataSaver() {
    alert('⚡ Data Saver active!');
}

function filterProducts() {
    const query = document.getElementById('search-input').value.toLowerCase();
    document.querySelectorAll('.card').forEach(card => {
        const name = card.getAttribute('data-name');
        card.style.display = name.includes(query) ? 'block' : 'none';
    });
}

function checkoutWhatsApp() {
    if (cart.length === 0) return alert('Cart is empty!');
    let message = "Hi Nollie's, I'd like to place an order:%0A";
    let total = 0;
    cart.forEach(item => {
        message += `- ${item.title}: R${item.price}%0A`;
        total += item.price;
    });
    message += `%0ATotal: R${total.toFixed(2)}`;
    window.open(`https://wa.me/?text=${message}`, '_blank');
}
JS

echo "Restoration script complete!"
