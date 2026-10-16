#!/bin/bash
set -e

cd ~/nollies

echo "Updating frontend layout and human experience design..."

# 1. Generate clean HTML with interactive elements and WhatsApp checkout
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

    <div class="announcement-bar">
        🚀 Fast Service Delivery Across Mzansi | Instant WhatsApp Order Support
    </div>

    <header class="navbar">
        <div class="logo">Nollie's<span>.</span></div>
        <div class="cart-btn" onclick="toggleCart()">
            🛒 Cart (<span id="cart-count">0</span>)
        </div>
    </header>

    <section class="hero">
        <h1>Simplified Operations & Tech Services</h1>
        <p>Reliable, data-light, and tailored business solutions for your growth.</p>
    </section>

    <main class="container">
        <div class="product-grid">

            <div class="card">
                <span class="badge">Operations</span>
                <h2>Smart Logistics Hub</h2>
                <p class="description">End-to-end supply chain setup, tracking, and inventory workflow optimization.</p>
                <div class="price">R 890.00</div>
                <div class="card-actions">
                    <button class="btn btn-primary" onclick="addToCart('Smart Logistics Hub', 890)">Add to Cart</button>
                    <a href="https://wa.me/?text=Hi%20Nollie's,%20I'm%20interested%20in%20the%20Smart%20Logistics%20Hub" class="btn btn-whatsapp" target="_blank">WhatsApp Us</a>
                </div>
            </div>

            <div class="card">
                <span class="badge">Intelligence</span>
                <h2>Data & Systems Analytics</h2>
                <p class="description">Custom business dashboards, automated data reporting, and operational insights.</p>
                <div class="price">R 1,200.00</div>
                <div class="card-actions">
                    <button class="btn btn-primary" onclick="addToCart('Data & Systems Analytics', 1200)">Add to Cart</button>
                    <a href="https://wa.me/?text=Hi%20Nollie's,%20I'm%20interested%20in%20Data%20%26%20Systems%20Analytics" class="btn btn-whatsapp" target="_blank">WhatsApp Us</a>
                </div>
            </div>

            <div class="card">
                <span class="badge">Infrastructure</span>
                <h2>Urban Architecture & Tech</h2>
                <p class="description">Digital transformation strategy for physical workspaces and enterprise infrastructure.</p>
                <div class="price">R 550.00</div>
                <div class="card-actions">
                    <button class="btn btn-primary" onclick="addToCart('Urban Architecture & Tech', 550)">Add to Cart</button>
                    <a href="https://wa.me/?text=Hi%20Nollie's,%20I'm%20interested%20in%20Urban%20Architecture%20%26%20Tech" class="btn btn-whatsapp" target="_blank">WhatsApp Us</a>
                </div>
            </div>

        </div>
    </main>

    <div id="cart-modal" class="cart-modal">
        <div class="cart-content">
            <div class="cart-header">
                <h3>Your Order Summary</h3>
                <span class="close-btn" onclick="toggleCart()">&times;</span>
            </div>
            <div id="cart-items"></div>
            <div class="cart-footer">
                <div class="total-price">Total: <span id="cart-total">R 0.00</span></div>
                <button class="btn btn-primary btn-block" onclick="checkoutWhatsApp()">Checkout via WhatsApp 💬</button>
            </div>
        </div>
    </div>

    <script src="script.js"></script>
</body>
</html>
HTML

# Synchronize index.html to root if needed
cp public/index.html index.html 2>/dev/null || true

# 2. Add Mobile-First High-Contrast CSS (No heavy images required)
cat << 'CSS' > public/style.css
:root {
    --primary: #4F46E5;
    --whatsapp: #25D366;
    --bg-light: #F8FAFC;
    --text-dark: #0F172A;
    --card-bg: #FFFFFF;
    --border: #E2E8F0;
}

* { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', -apple-system, sans-serif; }
body { background-color: var(--bg-light); color: var(--text-dark); padding-bottom: 40px; }
img { display: none !important; } /* Guarantees image removal */

.announcement-bar { background: #1E293B; color: #F8FAFC; text-align: center; padding: 8px 12px; font-size: 0.85rem; font-weight: 600; }
.navbar { display: flex; justify-content: space-between; align-items: center; padding: 16px 24px; background: var(--card-bg); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 100; }
.logo { font-size: 1.5rem; font-weight: 800; }
.logo span { color: var(--primary); }
.cart-btn { background: #EEF2FF; color: var(--primary); padding: 8px 16px; border-radius: 20px; font-weight: 700; cursor: pointer; }

.hero { text-align: center; padding: 36px 20px 20px; }
.hero h1 { font-size: 1.8rem; font-weight: 800; margin-bottom: 8px; }
.hero p { color: #64748B; font-size: 0.95rem; }

.container { max-width: 1000px; margin: 0 auto; padding: 20px; }
.product-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; }

.card { background: var(--card-bg); border: 1px solid var(--border); border-radius: 16px; padding: 24px; display: flex; flex-direction: column; justify-content: space-between; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05); }
.badge { background: #F1F5F9; color: #475569; font-size: 0.75rem; font-weight: 700; text-transform: uppercase; padding: 4px 10px; border-radius: 6px; align-self: flex-start; margin-bottom: 12px; }
.card h2 { font-size: 1.25rem; font-weight: 700; margin-bottom: 8px; }
.description { color: #64748B; font-size: 0.9rem; line-height: 1.4; margin-bottom: 16px; }
.price { font-size: 1.4rem; font-weight: 800; margin-bottom: 16px; }

.card-actions { display: flex; gap: 10px; }
.btn { flex: 1; padding: 12px; border: none; border-radius: 10px; font-weight: 700; font-size: 0.9rem; cursor: pointer; text-align: center; text-decoration: none; }
.btn-primary { background: var(--primary); color: white; }
.btn-whatsapp { background: var(--whatsapp); color: white; }

.cart-modal { display: none; position: fixed; top: 0; right: 0; bottom: 0; left: 0; background: rgba(0, 0, 0, 0.5); z-index: 200; justify-content: flex-end; }
.cart-content { background: white; width: 100%; max-width: 400px; height: 100%; padding: 24px; display: flex; flex-direction: column; }
.cart-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--border); padding-bottom: 12px; }
.close-btn { font-size: 1.5rem; cursor: pointer; }
#cart-items { flex: 1; overflow-y: auto; padding: 16px 0; }
.cart-item { display: flex; justify-content: space-between; margin-bottom: 12px; padding-bottom: 8px; border-bottom: 1px dashed var(--border); }
.cart-footer { border-top: 1px solid var(--border); padding-top: 16px; }
.total-price { font-size: 1.2rem; font-weight: 800; margin-bottom: 12px; }
.btn-block { width: 100%; }
CSS

# 3. Add JavaScript logic
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

function checkoutWhatsApp() {
    if (cart.length === 0) {
        alert('Your cart is empty!');
        return;
    }
    
    let message = "Hi Nollie's, I would like to place an order:%0A";
    let total = 0;
    cart.forEach(item => {
        message += `- ${item.title}: R${item.price}%0A`;
        total += item.price;
    });
    message += `%0ATotal Amount: R${total.toFixed(2)}`;
    
    window.open(`https://wa.me/?text=${message}`, '_blank');
}
JS

echo "Enhancements complete!"
