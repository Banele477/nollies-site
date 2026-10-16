#!/bin/bash
set -e

cd ~/nollies

echo "======================================================="
echo "🛠️ Reverse Engineering Nollie's Web App (Mzansi Pro UX)..."
echo "======================================================="

mkdir -p public/css public/js

# 1. Reverse Engineered Web App HTML
cat << 'HTML' > public/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Nollie's | Digital & Tech Services</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body class="light-mode">

    <!-- App Header Bar -->
    <header class="app-header">
        <div class="header-left">
            <span class="app-logo">Nollie's<span class="dot">.</span></span>
            <span class="location-badge">🇿🇦 Mzansi</span>
        </div>
        <div class="header-right">
            <button class="icon-btn" onclick="toggleDataSaver()" id="data-btn" title="Data Saver Mode">⚡</button>
            <button class="icon-btn" onclick="toggleTheme()" id="theme-btn">🌙</button>
            <div class="cart-pill" onclick="toggleCart()">
                🛒 <span id="cart-count">0</span>
            </div>
        </div>
    </header>

    <!-- Sub Header Status -->
    <div class="status-bar">
        <span>⚡ Instant Delivery & Local Support via WhatsApp</span>
    </div>

    <!-- Search & Filter Controls -->
    <div class="search-container">
        <input type="text" id="search-input" placeholder="Search services (e.g. Analytics, Logistics)..." onkeyup="filterProducts()">
        <div class="filter-chips">
            <button class="chip active" onclick="filterCategory('all', this)">All</button>
            <button class="chip" onclick="filterCategory('operations', this)">Operations</button>
            <button class="chip" onclick="filterCategory('intelligence', this)">Analytics</button>
            <button class="chip" onclick="filterCategory('infrastructure', this)">Infrastructure</button>
        </div>
    </div>

    <!-- Main Service Cards Feed -->
    <main class="app-feed">
        <div id="product-list" class="product-grid">

            <!-- Card 1 -->
            <div class="card" data-category="operations" data-name="smart logistics hub">
                <div class="card-top">
                    <span class="badge badge-ops">Operations</span>
                    <span class="delivery-eta">🚚 24-48h Delivery</span>
                </div>
                <h3>Smart Logistics Hub</h3>
                <p>Complete supply chain setup, stock inventory tracking, and process workflow optimization.</p>
                <div class="card-footer">
                    <div class="price-box">
                        <span class="currency">R</span>
                        <span class="amount">890</span>
                        <span class="vat">Incl. VAT</span>
                    </div>
                    <div class="btn-group">
                        <button class="btn btn-add" onclick="addToCart('Smart Logistics Hub', 890)">+ Cart</button>
                        <a href="https://wa.me/?text=Hi%20Nollie's,%20I'm%20interested%20in%20the%20Smart%20Logistics%20Hub" class="btn btn-wa" target="_blank">WhatsApp</a>
                    </div>
                </div>
            </div>

            <!-- Card 2 -->
            <div class="card" data-category="intelligence" data-name="data & systems analytics">
                <div class="card-top">
                    <span class="badge badge-intel">Intelligence</span>
                    <span class="delivery-eta">⚡ Instant Setup</span>
                </div>
                <h3>Data & Systems Analytics</h3>
                <p>Custom executive dashboards, automated financial reporting, and operational analytics tools.</p>
                <div class="card-footer">
                    <div class="price-box">
                        <span class="currency">R</span>
                        <span class="amount">1,200</span>
                        <span class="vat">Incl. VAT</span>
                    </div>
                    <div class="btn-group">
                        <button class="btn btn-add" onclick="addToCart('Data & Systems Analytics', 1200)">+ Cart</button>
                        <a href="https://wa.me/?text=Hi%20Nollie's,%20I'm%20interested%20in%20Data%20%26%20Systems%20Analytics" class="btn btn-wa" target="_blank">WhatsApp</a>
                    </div>
                </div>
            </div>

            <!-- Card 3 -->
            <div class="card" data-category="infrastructure" data-name="urban architecture & tech">
                <div class="card-top">
                    <span class="badge badge-infra">Infrastructure</span>
                    <span class="delivery-eta">🛠️ Advisory Package</span>
                </div>
                <h3>Urban Architecture & Tech</h3>
                <p>Digital transformation strategy for physical workspaces, virtual offices, and systems architecture.</p>
                <div class="card-footer">
                    <div class="price-box">
                        <span class="currency">R</span>
                        <span class="amount">550</span>
                        <span class="vat">Incl. VAT</span>
                    </div>
                    <div class="btn-group">
                        <button class="btn btn-add" onclick="addToCart('Urban Architecture & Tech', 550)">+ Cart</button>
                        <a href="https://wa.me/?text=Hi%20Nollie's,%20I'm%20interested%20in%20Urban%20Architecture%20%26%20Tech" class="btn btn-wa" target="_blank">WhatsApp</a>
                    </div>
                </div>
            </div>

        </div>
    </main>

    <!-- Slide-Up Checkout Drawer -->
    <div id="cart-modal" class="cart-overlay">
        <div class="cart-drawer">
            <div class="drawer-handle" onclick="toggleCart()"></div>
            <div class="drawer-header">
                <h3>Order Summary</h3>
                <button class="close-icon" onclick="toggleCart()">&times;</button>
            </div>

            <div id="cart-items" class="drawer-body">
                <div class="empty-msg">Your cart is empty</div>
            </div>

            <div class="drawer-footer">
                <div class="summary-line">
                    <span>Total Amount</span>
                    <span id="cart-total" class="total-amount">R 0.00</span>
                </div>

                <div class="payment-options">
                    <span class="pay-label">Select Payment Method:</span>
                    <div class="pay-selector">
                        <label class="pay-opt"><input type="radio" name="pay_method" value="EFT / Capitec" checked> Capitec / EFT</label>
                        <label class="pay-opt"><input type="radio" name="pay_method" value="Ozow Instant"> Ozow</label>
                        <label class="pay-opt"><input type="radio" name="pay_method" value="Card Payment"> Card</label>
                    </div>
                </div>

                <button class="btn btn-checkout" onclick="checkoutWhatsApp()">
                    Order via WhatsApp 💬
                </button>
            </div>
        </div>
    </div>

    <script src="script.js"></script>
</body>
</html>
HTML

# Sync to root index.html
cp public/index.html index.html 2>/dev/null || true

# 2. Modern Mobile App Stylesheet
cat << 'CSS' > public/style.css
:root {
    --primary: #4F46E5;
    --primary-dark: #3730A3;
    --wa-green: #25D366;
    --bg: #F8FAFC;
    --card: #FFFFFF;
    --text: #0F172A;
    --muted: #64748B;
    --border: #E2E8F0;
    --radius: 16px;
}

body.dark-mode {
    --bg: #0F172A;
    --card: #1E293B;
    --text: #F8FAFC;
    --muted: #94A3B8;
    --border: #334155;
}

body.lite-mode * {
    box-shadow: none !important;
    transition: none !important;
}

* { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', -apple-system, sans-serif; -webkit-tap-highlight-color: transparent; }
body { background: var(--bg); color: var(--text); padding-bottom: 20px; transition: background 0.2s ease; }
img { display: none !important; }

/* Header */
.app-header { display: flex; justify-content: space-between; align-items: center; padding: 12px 16px; background: var(--card); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 100; }
.header-left { display: flex; align-items: center; gap: 8px; }
.app-logo { font-size: 1.3rem; font-weight: 800; }
.app-logo .dot { color: var(--primary); }
.location-badge { background: #EEF2FF; color: var(--primary); font-size: 0.7rem; font-weight: 700; padding: 2px 8px; border-radius: 10px; }

.header-right { display: flex; align-items: center; gap: 8px; }
.icon-btn { background: var(--bg); border: 1px solid var(--border); width: 36px; height: 36px; border-radius: 50%; display: flex; align-items: center; justify-content: center; cursor: pointer; color: var(--text); }
.cart-pill { background: var(--primary); color: white; padding: 6px 14px; border-radius: 20px; font-weight: 700; font-size: 0.85rem; cursor: pointer; }

/* Status Bar */
.status-bar { background: #1E293B; color: #F8FAFC; text-align: center; padding: 6px 12px; font-size: 0.75rem; font-weight: 600; }

/* Search & Filters */
.search-container { padding: 16px; max-width: 800px; margin: 0 auto; }
#search-input { width: 100%; padding: 12px 16px; border-radius: 12px; border: 1px solid var(--border); background: var(--card); color: var(--text); font-size: 0.9rem; outline: none; margin-bottom: 12px; }
.filter-chips { display: flex; gap: 8px; overflow-x: auto; padding-bottom: 4px; }
.chip { background: var(--card); border: 1px solid var(--border); color: var(--muted); padding: 6px 14px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; white-space: nowrap; cursor: pointer; }
.chip.active { background: var(--primary); color: white; border-color: var(--primary); }

/* Product Feed */
.app-feed { padding: 0 16px; max-width: 800px; margin: 0 auto; }
.product-grid { display: flex; flex-direction: column; gap: 16px; }

.card { background: var(--card); border: 1px solid var(--border); border-radius: var(--radius); padding: 18px; box-shadow: 0 2px 8px rgba(0,0,0,0.03); }
.card-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; }
.badge { font-size: 0.7rem; font-weight: 700; text-transform: uppercase; padding: 3px 8px; border-radius: 6px; }
.badge-ops { background: #EEF2FF; color: #4F46E5; }
.badge-intel { background: #ECFDF5; color: #10B981; }
.badge-infra { background: #FFF7ED; color: #F97316; }
.delivery-eta { font-size: 0.75rem; color: var(--muted); font-weight: 500; }

.card h3 { font-size: 1.15rem; font-weight: 700; margin-bottom: 6px; }
.card p { font-size: 0.88rem; color: var(--muted); line-height: 1.4; margin-bottom: 14px; }

.card-footer { display: flex; justify-content: space-between; align-items: center; pt: 8px; border-top: 1px dashed var(--border); }
.price-box { display: flex; align-items: baseline; gap: 2px; }
.price-box .currency { font-size: 0.9rem; font-weight: 700; color: var(--primary); }
.price-box .amount { font-size: 1.3rem; font-weight: 800; }
.price-box .vat { font-size: 0.65rem; color: var(--muted); margin-left: 4px; }

.btn-group { display: flex; gap: 6px; }
.btn { padding: 8px 12px; border-radius: 10px; border: none; font-weight: 700; font-size: 0.82rem; cursor: pointer; text-decoration: none; }
.btn-add { background: var(--primary); color: white; }
.btn-wa { background: var(--wa-green); color: white; }

/* Slide-Up Drawer */
.cart-overlay { display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.5); z-index: 200; justify-content: flex-end; flex-direction: column; }
.cart-drawer { background: var(--card); border-top-left-radius: 20px; border-top-right-radius: 20px; padding: 20px; max-height: 85vh; display: flex; flex-direction: column; }
.drawer-handle { width: 40px; height: 4px; background: var(--border); border-radius: 2px; margin: 0 auto 12px; cursor: pointer; }
.drawer-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--border); padding-bottom: 12px; }
.close-icon { background: none; border: none; font-size: 1.4rem; color: var(--muted); cursor: pointer; }

.drawer-body { flex: 1; overflow-y: auto; padding: 16px 0; }
.cart-row { display: flex; justify-content: space-between; align-items: center; padding: 8px 0; border-bottom: 1px dashed var(--border); font-size: 0.9rem; }
.empty-msg { text-align: center; color: var(--muted); padding: 20px; }

.drawer-footer { border-top: 1px solid var(--border); padding-top: 14px; }
.summary-line { display: flex; justify-content: space-between; font-weight: 700; font-size: 1.1rem; margin-bottom: 12px; }
.total-amount { color: var(--primary); }

.payment-options { margin-bottom: 14px; }
.pay-label { font-size: 0.75rem; color: var(--muted); display: block; margin-bottom: 6px; }
.pay-selector { display: flex; gap: 10px; }
.pay-opt { font-size: 0.75rem; font-weight: 600; cursor: pointer; }

.btn-checkout { width: 100%; background: var(--wa-green); color: white; padding: 12px; border-radius: 12px; font-weight: 700; font-size: 0.95rem; border: none; cursor: pointer; }
CSS

# 3. Interactive JavaScript Controller
cat << 'JS' > public/script.js
let cart = [];

function addToCart(title, price) {
    cart.push({ title, price });
    updateCartUI();
    toggleCart();
}

function updateCartUI() {
    document.getElementById('cart-count').innerText = cart.length;
    const cartContainer = document.getElementById('cart-items');
    
    if (cart.length === 0) {
        cartContainer.innerHTML = '<div class="empty-msg">Your cart is empty</div>';
        document.getElementById('cart-total').innerText = 'R 0.00';
        return;
    }

    cartContainer.innerHTML = '';
    let total = 0;
    cart.forEach((item, index) => {
        total += item.price;
        cartContainer.innerHTML += `
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
    document.body.classList.toggle('lite-mode');
    alert('⚡ Data-Saver Mode Toggled!');
}

function filterCategory(cat, btn) {
    document.querySelectorAll('.chip').forEach(c => c.classList.remove('active'));
    btn.classList.add('active');

    const cards = document.querySelectorAll('.card');
    cards.forEach(card => {
        if (cat === 'all' || card.getAttribute('data-category') === cat) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });
}

function filterProducts() {
    const query = document.getElementById('search-input').value.toLowerCase();
    const cards = document.querySelectorAll('.card');
    cards.forEach(card => {
        const name = card.getAttribute('data-name');
        if (name.includes(query)) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });
}

function checkoutWhatsApp() {
    if (cart.length === 0) {
        alert('Your cart is empty!');
        return;
    }
    
    const payMethod = document.querySelector('input[name="pay_method"]:checked').value;
    let message = "Hi Nollie's, I would like to order:%0A";
    let total = 0;
    
    cart.forEach(item => {
        message += `• ${item.title}: R${item.price}%0A`;
        total += item.price;
    });
    
    message += `%0ATotal: R${total.toFixed(2)}`;
    message += `%0APayment Option: ${payMethod}`;
    
    window.open(`https://wa.me/?text=${message}`, '_blank');
}
JS

echo "Reverse-engineered build generated!"

# 4. Deploy changes automatically via deploy.sh
if [ -f ./deploy.sh ]; then
    ./deploy.sh
else
    git add .
    git commit -m "Reverse engineered SA Mzansi Web App UX"
    git push origin main
fi

echo "======================================================="
echo "✅ Site updated live! Test locally or check online."
echo "======================================================="
