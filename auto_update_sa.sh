#!/bin/bash
set -e

cd ~/nollies

echo "======================================================"
echo "🚀 Updating Nollie's Frontend with Mzansi UX Upgrades..."
echo "======================================================"

mkdir -p public/css public/js

# 1. Generate SA-Optimized index.html
cat << 'HTML' > public/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nollie's | Smart Digital Services</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
</head>
<body>

    <!-- Top Announcement Bar -->
    <div class="announcement-bar">
        <span>🇿🇦 Fast Service Across Mzansi | Instant WhatsApp & EFT Support</span>
        <button class="lite-toggle" onclick="toggleDataSaver()">⚡ Data Saver Mode</button>
    </div>

    <!-- Header Navigation -->
    <header class="navbar">
        <div class="logo">Nollie's<span>.co.za</span></div>
        <div class="nav-right">
            <button class="theme-toggle" onclick="toggleTheme()">🌙</button>
            <div class="cart-btn" onclick="toggleCart()">
                🛒 Cart (<span id="cart-count">0</span>)
            </div>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero">
        <span class="hero-tag">Business & Tech Systems</span>
        <h1>Tailored Digital Solutions for SA Enterprises</h1>
        <p>Reliable, scalable, data-friendly business setup & management packages.</p>
    </section>

    <!-- Services Grid -->
    <main class="container">
        <div class="product-grid">

            <div class="card">
                <div class="card-header">
                    <span class="badge">Operations</span>
                    <span class="delivery-tag">🚚 24-48h Delivery</span>
                </div>
                <h2>Smart Logistics Hub</h2>
                <p class="description">End-to-end supply chain setup, stock inventory tracking, and process workflow optimization.</p>
                <div class="price-row">
                    <div class="price">R 890.00</div>
                    <span class="vat-tag">Incl. VAT</span>
                </div>
                <div class="card-actions">
                    <button class="btn btn-primary" onclick="addToCart('Smart Logistics Hub', 890)">Add to Cart</button>
                    <a href="https://wa.me/?text=Hi%20Nollie's,%20I'm%20interested%20in%20the%20Smart%20Logistics%20Hub" class="btn btn-whatsapp" target="_blank">WhatsApp</a>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <span class="badge">Intelligence</span>
                    <span class="delivery-tag">⚡ Instant Access</span>
                </div>
                <h2>Data & Systems Analytics</h2>
                <p class="description">Custom business dashboards, automated financial/sales reporting, and operational insights.</p>
                <div class="price-row">
                    <div class="price">R 1,200.00</div>
                    <span class="vat-tag">Incl. VAT</span>
                </div>
                <div class="card-actions">
                    <button class="btn btn-primary" onclick="addToCart('Data & Systems Analytics', 1200)">Add to Cart</button>
                    <a href="https://wa.me/?text=Hi%20Nollie's,%20I'm%20interested%20in%20Data%20%26%20Systems%20Analytics" class="btn btn-whatsapp" target="_blank">WhatsApp</a>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <span class="badge">Infrastructure</span>
                    <span class="delivery-tag">🛠️ Advisory Package</span>
                </div>
                <h2>Urban Architecture & Tech</h2>
                <p class="description">Digital transformation strategy for physical workspaces, virtual offices, and infrastructure.</p>
                <div class="price-row">
                    <div class="price">R 550.00</div>
                    <span class="vat-tag">Incl. VAT</span>
                </div>
                <div class="card-actions">
                    <button class="btn btn-primary" onclick="addToCart('Urban Architecture & Tech', 550)">Add to Cart</button>
                    <a href="https://wa.me/?text=Hi%20Nollie's,%20I'm%20interested%20in%20Urban%20Architecture%20%26%20Tech" class="btn btn-whatsapp" target="_blank">WhatsApp</a>
                </div>
            </div>

        </div>
    </main>

    <!-- Slide-over Cart & Checkout Modal -->
    <div id="cart-modal" class="cart-modal">
        <div class="cart-content">
            <div class="cart-header">
                <h3>Order Summary</h3>
                <span class="close-btn" onclick="toggleCart()">&times;</span>
            </div>
            <div id="cart-items"></div>
            <div class="cart-footer">
                <div class="total-row">
                    <span>Total Amount:</span>
                    <span id="cart-total" class="total-price">R 0.00</span>
                </div>
                <div class="payment-methods">
                    <span>Accepted Payments:</span>
                    <div class="pay-tags">
                        <span class="pay-badge">EFT / Capitec</span>
                        <span class="pay-badge">Ozow</span>
                        <span class="pay-badge">Cards</span>
                    </div>
                </div>
                <button class="btn btn-whatsapp btn-block" onclick="checkoutWhatsApp()">Checkout via WhatsApp 💬</button>
            </div>
        </div>
    </div>

    <script src="script.js"></script>
</body>
</html>
HTML

# Ensure root index.html is updated for GitHub Pages deployment
cp public/index.html index.html 2>/dev/null || true

# 2. Generate Mzansi Mobile-First CSS
cat << 'CSS' > public/style.css
:root {
    --primary: #4F46E5;
    --primary-hover: #4338CA;
    --whatsapp: #25D366;
    --bg-light: #F8FAFC;
    --text-dark: #0F172A;
    --card-bg: #FFFFFF;
    --border: #E2E8F0;
    --accent: #10B981;
}

body.dark-theme {
    --bg-light: #0F172A;
    --text-dark: #F8FAFC;
    --card-bg: #1E293B;
    --border: #334155;
}

body.lite-mode * {
    box-shadow: none !important;
    transition: none !important;
}

* { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', -apple-system, sans-serif; }
body { background-color: var(--bg-light); color: var(--text-dark); padding-bottom: 40px; transition: background 0.3s ease; }
img { display: none !important; }

.announcement-bar { background: #1E293B; color: #F8FAFC; display: flex; justify-content: space-between; align-items: center; padding: 8px 16px; font-size: 0.8rem; font-weight: 600; }
.lite-toggle { background: #334155; color: #F8FAFC; border: none; padding: 4px 8px; border-radius: 6px; cursor: pointer; font-size: 0.75rem; }

.navbar { display: flex; justify-content: space-between; align-items: center; padding: 16px 24px; background: var(--card-bg); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 100; }
.logo { font-size: 1.4rem; font-weight: 800; }
.logo span { color: var(--primary); }
.nav-right { display: flex; align-items: center; gap: 12px; }
.theme-toggle { background: transparent; border: 1px solid var(--border); padding: 6px 10px; border-radius: 8px; cursor: pointer; }
.cart-btn { background: #EEF2FF; color: var(--primary); padding: 8px 16px; border-radius: 20px; font-weight: 700; cursor: pointer; }

.hero { text-align: center; padding: 36px 20px 24px; }
.hero-tag { background: #EEF2FF; color: var(--primary); font-size: 0.8rem; font-weight: 700; padding: 4px 12px; border-radius: 12px; text-transform: uppercase; }
.hero h1 { font-size: 1.8rem; font-weight: 800; margin: 12px 0 8px; }
.hero p { color: #64748B; font-size: 0.95rem; }

.container { max-width: 1000px; margin: 0 auto; padding: 16px; }
.product-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; }

.card { background: var(--card-bg); border: 1px solid var(--border); border-radius: 16px; padding: 24px; display: flex; flex-direction: column; justify-content: space-between; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05); }
.card-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
.badge { background: #F1F5F9; color: #475569; font-size: 0.75rem; font-weight: 700; text-transform: uppercase; padding: 4px 10px; border-radius: 6px; }
.delivery-tag { font-size: 0.75rem; color: var(--accent); font-weight: 600; }

.card h2 { font-size: 1.25rem; font-weight: 700; margin-bottom: 8px; }
.description { color: #64748B; font-size: 0.9rem; line-height: 1.4; margin-bottom: 16px; }

.price-row { display: flex; align-items: baseline; gap: 8px; margin-bottom: 16px; }
.price { font-size: 1.4rem; font-weight: 800; }
.vat-tag { font-size: 0.75rem; color: #94A3B8; }

.card-actions { display: flex; gap: 10px; }
.btn { flex: 1; padding: 12px; border: none; border-radius: 10px; font-weight: 700; font-size: 0.9rem; cursor: pointer; text-align: center; text-decoration: none; }
.btn-primary { background: var(--primary); color: white; }
.btn-whatsapp { background: var(--whatsapp); color: white; }

.cart-modal { display: none; position: fixed; top: 0; right: 0; bottom: 0; left: 0; background: rgba(0, 0, 0, 0.5); z-index: 200; justify-content: flex-end; }
.cart-content { background: var(--card-bg); width: 100%; max-width: 400px; height: 100%; padding: 24px; display: flex; flex-direction: column; }
.cart-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--border); padding-bottom: 12px; }
.close-btn { font-size: 1.5rem; cursor: pointer; }
#cart-items { flex: 1; overflow-y: auto; padding: 16px 0; }
.cart-item { display: flex; justify-content: space-between; margin-bottom: 12px; padding-bottom: 8px; border-bottom: 1px dashed var(--border); }
.cart-footer { border-top: 1px solid var(--border); padding-top: 16px; }
.total-row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; font-weight: 700; }
.total-price { font-size: 1.3rem; color: var(--primary); }

.payment-methods { margin-bottom: 16px; }
.payment-methods span { font-size: 0.75rem; color: #64748B; display: block; margin-bottom: 6px; }
.pay-tags { display: flex; gap: 6px; }
.pay-badge { background: #F1F5F9; color: #334155; font-size: 0.7rem; font-weight: 600; padding: 4px 8px; border-radius: 4px; }
.btn-block { width: 100%; }
CSS

# 3. Generate JavaScript Features
cat << 'JS' > public/script.js
let cart = [];

function addToCart(title, price) {
    cart.push({ title, price });
    updateCartUI();
}

function updateCartUI() {
    document.getElementById('cart-count').innerText = cart.length;
    const cartItemsContainer = document.getElementById('cart-items');
    cartItemsContainer.innerHTML = '';
    
    let total = 0;
    cart.forEach((item) => {
        total += item.price;
        cartItemsContainer.innerHTML += `
            <div class="cart-item">
                <div><strong>${item.title}</strong></div>
                <div>R ${item.price.toFixed(2)}</div>
            </div>
        `;
    });

    document.getElementById('cart-total').innerText = `R ${total.toFixed(2)}`;
}

function toggleCart() {
    const modal = document.getElementById('cart-modal');
    modal.style.display = modal.style.display === 'flex' ? 'none' : 'flex';
}

function toggleTheme() {
    document.body.classList.toggle('dark-theme');
}

function toggleDataSaver() {
    document.body.classList.toggle('lite-mode');
    alert('Data Saver mode toggled!');
}

function checkoutWhatsApp() {
    if (cart.length === 0) {
        alert('Your cart is empty!');
        return;
    }
    
    let message = "Hi Nollie's, I would like to order the following:%0A";
    let total = 0;
    cart.forEach(item => {
        message += `- ${item.title}: R${item.price}%0A`;
        total += item.price;
    });
    message += `%0ATotal Amount: R${total.toFixed(2)}%0APayment Method: EFT / Capitec / Card`;
    
    window.open(`https://wa.me/?text=${message}`, '_blank');
}
JS

echo "Build complete! Pushing updates online using deploy.sh..."

# 4. Automatically push updates online using deploy.sh
if [ -f ./deploy.sh ]; then
    ./deploy.sh
else
    git add .
    git commit -m "Auto-update SA human UX features and design"
    git push origin main
fi

echo "======================================================"
echo "✅ Everything updated and pushed online automatically!"
echo "======================================================"
