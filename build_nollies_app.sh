#!/data/data/com.termux/files/usr/bin/bash
set -e

cd ~/nollies
echo "🚀 Building Nollie's Web App..."

mkdir -p public/css public/js data

# 1. Generate public/index.html
cat << 'HTML' > public/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Nollie's | Community Essentials & Bulk Juice Delivery</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body class="light-mode">

    <!-- App Header -->
    <header class="app-header">
        <div class="header-left">
            <span class="app-logo">Nollie's<span class="dot">.</span></span>
            <span class="badge-tag">Mzansi Hub</span>
        </div>
        <div class="header-right">
            <button class="icon-btn" onclick="toggleTheme()" id="theme-btn" title="Toggle Theme">🌙</button>
            <div class="cart-pill" onclick="toggleCart()">
                🛒 <span id="cart-count">0</span>
            </div>
        </div>
    </header>

    <!-- Multi-Tab Navigation -->
    <nav class="tab-nav">
        <button class="tab-btn active" onclick="switchTab('shop', this)">🛍️ Shop</button>
        <button class="tab-btn" onclick="switchTab('bulk', this)">📦 Bulk Calculator</button>
        <button class="tab-btn" onclick="switchTab('ai', this)">🤖 Nollie AI</button>
        <button class="tab-btn" onclick="switchTab('telemetry', this)">📊 Impact Hub</button>
    </nav>

    <!-- Main Content Area -->
    <main class="app-body">

        <!-- SHOP VIEW -->
        <section id="tab-shop" class="tab-content active-tab">
            <div class="hero-banner">
                <h1>Juice, Perfume, Cereal & Pantry Basics</h1>
                <p>Affordable essentials delivered straight to your community. Pay via Cash or EFT.</p>
            </div>

            <div class="search-box">
                <input type="text" id="search-input" placeholder="Search juice, perfume, cereal..." onkeyup="filterProducts()">
            </div>
            
            <div class="product-grid">
                <div class="card" data-name="bulk 5l juice events funerals gathering">
                    <span class="badge">Events & Funerals</span>
                    <h3>Bulk 5L Refreshing Juice</h3>
                    <p>High-yield 5L juice bottles. Ideal for family gatherings, events, and community funerals.</p>
                    <div class="card-footer">
                        <div class="price">R 65.00</div>
                        <div class="btn-group">
                            <button class="btn btn-add" onclick="addToCart('Bulk 5L Juice', 65)">+ Cart</button>
                            <a href="https://wa.me/?text=Hi%20Nollie's,%20I'm%20interested%20in%20Bulk%205L%20Juice" class="btn btn-wa" target="_blank">WhatsApp</a>
                        </div>
                    </div>
                </div>

                <div class="card" data-name="designer inspired perfume fragrance luxury">
                    <span class="badge">Fragrance</span>
                    <h3>Designer-Inspired Perfume</h3>
                    <p>Long-lasting, premium fragrances crafted for everyday freshness and elegance.</p>
                    <div class="card-footer">
                        <div class="price">R 150.00</div>
                        <div class="btn-group">
                            <button class="btn btn-add" onclick="addToCart('Designer Perfume', 150)">+ Cart</button>
                            <a href="https://wa.me/?text=Hi%20Nollie's,%20I'm%20interested%20in%20Designer%20Perfume" class="btn btn-wa" target="_blank">WhatsApp</a>
                        </div>
                    </div>
                </div>

                <div class="card" data-name="family breakfast cereal pantry 1kg">
                    <span class="badge">Pantry Basics</span>
                    <h3>Family Breakfast Cereal (1kg)</h3>
                    <p>Wholesome and filling breakfast cereal to energize your family every morning.</p>
                    <div class="card-footer">
                        <div class="price">R 45.00</div>
                        <div class="btn-group">
                            <button class="btn btn-add" onclick="addToCart('Family Cereal 1kg', 45)">+ Cart</button>
                            <a href="https://wa.me/?text=Hi%20Nollie's,%20I'm%20interested%20in%20Family%20Cereal" class="btn btn-wa" target="_blank">WhatsApp</a>
                        </div>
                    </div>
                </div>

                <div class="card" data-name="community hamper gift celebration box">
                    <span class="badge">Special Combo</span>
                    <h3>Community Gift Hamper</h3>
                    <p>Selected combo box containing pantry items, fresh juice, and treats for any occasion.</p>
                    <div class="card-footer">
                        <div class="price">R 320.00</div>
                        <div class="btn-group">
                            <button class="btn btn-add" onclick="addToCart('Community Gift Hamper', 320)">+ Cart</button>
                            <a href="https://wa.me/?text=Hi%20Nollie's,%20I'm%20interested%20in%20Community%20Gift%20Hamper" class="btn btn-wa" target="_blank">WhatsApp</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- BULK CALCULATOR VIEW -->
        <section id="tab-bulk" class="tab-content">
            <div class="panel">
                <h2>📦 Event & Funeral Bulk Calculator</h2>
                <p>Planning an upcoming gathering? Enter the estimated guest count to calculate required 5L juice bottles and costs.</p>
                
                <div class="form-group" style="margin-top: 15px;">
                    <label>Estimated Guests:</label>
                    <input type="number" id="guest-count" value="50" oninput="calculateBulk()" style="width:100%; padding:10px; margin-top:5px; border-radius:8px; border:1px solid var(--border);">
                </div>

                <div class="metric-box" style="margin-top: 15px;">
                    <p>Required 5L Juice Bottles: <strong id="calc-bottles">10 Bottles</strong></p>
                    <p>Estimated Cost: <strong id="calc-total">R 650.00</strong></p>
                </div>

                <button class="btn btn-add" style="width:100%; margin-top:15px; padding:12px;" onclick="addBulkToCart()">Add Bulk Package to Cart 📦</button>
            </div>
        </section>

        <!-- AI ASSISTANT VIEW -->
        <section id="tab-ai" class="tab-content">
            <div class="panel">
                <h2>🤖 Nollie AI Assistant</h2>
                <p>Get instant assistance for product inquiries, bulk orders, and delivery details.</p>
                
                <div id="chat-box" style="background:var(--bg); border:1px solid var(--border); border-radius:10px; height:220px; padding:10px; overflow-y:auto; margin:15px 0; font-size:0.9rem;">
                    <div><strong>Nollie AI:</strong> Sawubona! How can I help you with your order or bulk calculation today?</div>
                </div>

                <div style="display:flex; gap:8px;">
                    <input type="text" id="chat-input" placeholder="Ask a question (e.g., How much for bulk juice?)..." style="flex:1; padding:10px; border-radius:8px; border:1px solid var(--border);">
                    <button class="btn btn-add" onclick="sendAiMessage()">Send</button>
                </div>
            </div>
        </section>

        <!-- TELEMETRY VIEW -->
        <section id="tab-telemetry" class="tab-content">
            <div class="panel">
                <h2>📊 Community Impact & Telemetry</h2>
                <p>Real-time metrics demonstrating local order fulfillment and operational stats.</p>
                
                <div class="status-indicator" style="margin:15px 0;">
                    <span class="dot-live"></span> System Online | Local Storage Engine Ready
                </div>

                <div class="metric-box" style="margin-bottom:10px;">
                    <span>Completed Orders Logged:</span> <strong id="stat-orders">142</strong>
                </div>
                <div class="metric-box">
                    <span>Average Fulfillment Window:</span> <strong>30 - 45 Mins</strong>
                </div>
            </div>
        </section>

    </main>

    <!-- Slide-Up Cart Drawer -->
    <div id="cart-modal" class="cart-overlay">
        <div class="cart-drawer">
            <div class="drawer-header">
                <h3>Your Cart Summary</h3>
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

    <script src="js/script.js"></script>
</body>
</html>
HTML

# 2. Sync root index.html
cp public/index.html index.html 2>/dev/null || true

echo "✅ App updated successfully!"
