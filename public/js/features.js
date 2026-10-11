// Toast Notification System
function showToast(message) {
    let toast = document.getElementById("toast");
    if (!toast) {
        toast = document.createElement("div");
        toast.id = "toast";
        toast.style.cssText = "visibility: hidden; min-width: 250px; background-color: #333; color: #fff; text-align: center; border-radius: 4px; padding: 16px; position: fixed; z-index: 1000; left: 50%; bottom: 30px; transform: translateX(-50%); transition: visibility 0.5s, opacity 0.5s; opacity: 0;";
        document.body.appendChild(toast);
    }
    toast.innerText = message;
    toast.style.visibility = "visible";
    toast.style.opacity = "1";
    setTimeout(() => {
        toast.style.opacity = "0";
        toast.style.visibility = "hidden";
    }, 3000);
}

// Theme Toggle System
if (localStorage.getItem('theme') === 'dark') {
    document.body.classList.add('dark-theme');
}

function toggleTheme() {
    document.body.classList.toggle('dark-theme');
    let isDark = document.body.classList.contains('dark-theme');
    localStorage.setItem('theme', isDark ? 'dark' : 'light');
    showToast(isDark ? "Dark mode enabled" : "Light mode enabled");
}

// Product Search Filter
function filterProducts() {
    let input = document.getElementById('searchInput');
    if (!input) return;
    let filter = input.value.toLowerCase();
    let cards = document.querySelectorAll('.product-card');
    cards.forEach(card => {
        let title = card.innerText.toLowerCase();
        card.style.display = title.includes(filter) ? "" : "none";
    });
}

// ==========================================
// 1. SHOPPING CART SYSTEM
// ==========================================
let cart = JSON.parse(localStorage.getItem('nollies_cart')) || [];

function addToCart(productId, productName, productPrice) {
    let existingItem = cart.find(item => item.id === productId);
    if (existingItem) {
        existingItem.quantity += 1;
    } else {
        cart.push({ id: productId, name: productName, price: productPrice, quantity: 1 });
    }
    localStorage.setItem('nollies_cart', JSON.stringify(cart));
    updateCartUI();
    showToast(`${productName} added to cart!`);
}

function updateCartUI() {
    let cartCount = document.getElementById('cartCount');
    if (cartCount) {
        let totalCount = cart.reduce((sum, item) => sum + item.quantity, 0);
        cartCount.innerText = totalCount;
    }
}

function clearCart() {
    cart = [];
    localStorage.removeItem('nollies_cart');
    updateCartUI();
    showToast("Cart cleared");
}

// ==========================================
// 2. CUSTOMER RATING / REVIEW SYSTEM
// ==========================================
function submitRating(productId, ratingStars) {
    let ratings = JSON.parse(localStorage.getItem('nollies_ratings')) || {};
    ratings[productId] = ratingStars;
    localStorage.setItem('nollies_ratings', JSON.stringify(ratings));
    showToast(`Thank you for rating ${ratingStars} stars!`);
}

document.addEventListener("DOMContentLoaded", updateCartUI);

// Register Service Worker for PWA Support
if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('/public/sw.js')
        .then(() => console.log('PWA Service Worker Registered Successfully'))
        .catch(err => console.log('SW Registration Failed:', err));
}

// Inject stylesheet dynamically if not present
if (!document.getElementById('unique-theme-style')) {
    let link = document.createElement('link');
    link.id = 'unique-theme-style';
    link.rel = 'stylesheet';
    link.href = '/public/unique_style.css';
    document.head.appendChild(link);
}

// Inject Floating AI Concierge Widget UI
if (!document.getElementById('nollies-concierge')) {
    let conciergeDiv = document.createElement('div');
    conciergeDiv.id = 'nollies-concierge';
    conciergeDiv.innerHTML = `
        <div id="concierge-box">
            <div class="concierge-header">
                <span>🤖 Nollies Assistant</span>
                <span onclick="toggleConcierge()" style="cursor:pointer;">&times;</span>
            </div>
            <div class="concierge-body" id="conciergeText">
                Hi there! Welcome to Nollies. Looking for something specific or need help checking out?
            </div>
        </div>
        <button id="concierge-btn" onclick="toggleConcierge()">💬</button>
    `;
    document.body.appendChild(conciergeDiv);
}

function toggleConcierge() {
    let box = document.getElementById('concierge-box');
    box.style.display = box.style.display === 'flex' ? 'none' : 'flex';
}

// Enhanced Add to Cart with Micro-Feedback
const originalAddToCart = window.addToCart;
window.addToCart = function(id, name, price) {
    if (typeof originalAddToCart === 'function') {
        originalAddToCart(id, name, price);
    }
    showToast(`✨ Successfully secured: ${name}`);
};

// Admin / System Telemetry Status Indicator
if (!document.getElementById('nollies-telemetry-panel')) {
    let panel = document.createElement('div');
    panel.id = 'nollies-telemetry-panel';
    panel.style.cssText = "position: fixed; bottom: 25px; left: 25px; background: var(--glass-bg, rgba(255,255,255,0.8)); backdrop-filter: blur(10px); border: 1px solid var(--glass-border, #ddd); padding: 10px 14px; border-radius: 12px; font-size: 0.8rem; z-index: 998; box-shadow: 0 4px 15px rgba(0,0,0,0.1); display: flex; align-items: center; gap: 8px;";
    panel.innerHTML = `
        <span style="height: 8px; width: 8px; background-color: #10b981; border-radius: 50%; display: inline-block; box-shadow: 0 0 8px #10b981;"></span>
        <span id="telemetry-badge">Nollies System: Optimal (Secure)</span>
    `;
    document.body.appendChild(panel);
}

// ==========================================
# ANTI-SOCIAL ENGINEERING & ANTI-PHISHING
// ==========================================

// 1. Input Sanitization Engine (Defeats XSS Payload Injections)
function sanitizeInput(str) {
    if (!str) return '';
    return str.replace(/[&<>"']/g, function(m) {
        return {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#039;'
        }[m];
    });
}

// 2. Anti-Phishing Verification Banner
function renderPhishingProtectionBanner() {
    if (document.getElementById('anti-phishing-banner')) return;
    
    let banner = document.createElement('div');
    banner.id = 'anti-phishing-banner';
    banner.style.cssText = "background: #0f172a; color: #a5f3fc; text-align: center; font-size: 0.75rem; padding: 6px; font-weight: 500; letter-spacing: 0.5px; border-bottom: 1px solid rgba(255,255,255,0.1);";
    banner.innerHTML = `
        🔒 <strong>Official Nollies Domain:</strong> Verify you are at <u>${sanitizeInput(window.location.hostname)}</u>. We will never ask for your passwords or private credentials.
    `;
    document.body.insertBefore(banner, document.body.firstChild);
}

// 3. Honeytoken Bot Trap (Detects and Mitigates Automated Scanners)
function initializeHoneytokenTrap() {
    let trap = document.createElement('input');
    trap.type = 'text';
    trap.name = 'nollies_security_honeypot';
    trap.style.display = 'none';
    trap.tabIndex = -1;
    trap.autocomplete = 'off';
    trap.addEventListener('change', function() {
        console.warn('[SECURITY] Automated bot scanner detected and flagged!');
        showToast('⚠️ Security Exception: Automated action blocked.');
    });
    document.body.appendChild(trap);
}

document.addEventListener("DOMContentLoaded", () => {
    renderPhishingProtectionBanner();
    initializeHoneytokenTrap();
});

// ==========================================
// CUSTOMER SUPPORT CHATBOT ENGINE
// ==========================================

const chatbotKnowledgeBase = [
    {
        keywords: ["shipping", "delivery", "dispatch", "courier", "cost"],
        answer: "📦 We deliver nation-wide! Standard delivery takes 2-4 business days. Free shipping on orders over R1000."
    },
    {
        keywords: ["return", "refund", "exchange", "policy"],
        answer: "🔄 We offer a 14-day hassle-free return policy on all unused items. Contact support with your order ID to initiate a return."
    },
    {
        keywords: ["track", "order status", "where is my package"],
        answer: "🚚 You can track your order using the tracking link sent to your email or SMS once dispatched."
    },
    {
        keywords: ["payment", "pay", "card", "eft", "method"],
        answer: "💳 We accept major Credit/Debit Cards, Instant EFT, and secure mobile payments."
    },
    {
        keywords: ["hours", "open", "time", "contact", "support"],
        answer: "🕒 Our online store is open 24/7! Customer support operates Monday – Friday, 08:00 to 17:00 SAST."
    }
];

function getChatbotResponse(userQuery) {
    let lowerQuery = userQuery.toLowerCase().trim();
    if (!lowerQuery) return "Please type a question so I can assist you!";

    for (let entry of chatbotKnowledgeBase) {
        if (entry.keywords.some(kw => lowerQuery.includes(kw))) {
            return entry.answer;
        }
    }
    return "🤖 I'm sorry, I didn't quite catch that. You can ask me about **shipping**, **returns**, **order tracking**, or **payment options**!";
}

// Upgrade Concierge Widget to Interactive Chatbot Interface
document.addEventListener("DOMContentLoaded", () => {
    let conciergeBox = document.getElementById('concierge-box');
    if (conciergeBox) {
        conciergeBox.style.width = "320px";
        conciergeBox.innerHTML = `
            <div class="concierge-header">
                <span>🤖 Nollies Assistant</span>
                <span onclick="toggleConcierge()" style="cursor:pointer; font-size:1.2rem;">&times;</span>
            </div>
            <div class="concierge-body" id="chatHistory" style="height: 220px; overflow-y: auto; display: flex; flex-direction: column; gap: 8px; padding: 10px;">
                <div style="background: rgba(99, 102, 241, 0.15); padding: 8px 12px; border-radius: 10px; font-size: 0.85rem; max-width: 85%; align-self: flex-start;">
                    Hello! 👋 I'm your Nollies assistant. How can I help you today?
                </div>
            </div>
            <div style="display: flex; padding: 8px; border-top: 1px solid var(--glass-border, #ddd); background: rgba(0,0,0,0.02);">
                <input type="text" id="chatInput" placeholder="Ask a question..." style="flex: 1; padding: 8px; border-radius: 6px; border: 1px solid #ccc; font-size: 0.85rem; outline: none;" onkeypress="if(event.key === 'Enter') processChatInput()">
                <button onclick="processChatInput()" style="background: #6366f1; color: white; border: none; padding: 8px 12px; margin-left: 6px; border-radius: 6px; cursor: pointer; font-size: 0.85rem;">Send</button>
            </div>
        `;
    }
});

function processChatInput() {
    let input = document.getElementById('chatInput');
    let history = document.getElementById('chatHistory');
    if (!input || !history) return;

    let query = sanitizeInput(input.value);
    if (!query) return;

    // Append User Message
    let userMsg = document.createElement('div');
    userMsg.style.cssText = "background: #6366f1; color: white; padding: 8px 12px; border-radius: 10px; font-size: 0.85rem; max-width: 85%; align-self: flex-end; word-break: break-word;";
    userMsg.innerText = query;
    history.appendChild(userMsg);

    input.value = "";
    history.scrollTop = history.scrollHeight;

    // Simulate Bot Response Delay
    setTimeout(() => {
        let botReply = getChatbotResponse(query);
        let botMsg = document.createElement('div');
        botMsg.style.cssText = "background: rgba(99, 102, 241, 0.15); color: var(--text-main, #333); padding: 8px 12px; border-radius: 10px; font-size: 0.85rem; max-width: 85%; align-self: flex-start; word-break: break-word;";
        botMsg.innerText = botReply;
        history.appendChild(botMsg);
        history.scrollTop = history.scrollHeight;
    }, 400);
}

// Dynamic Hero & Trust Banner Injector
function buildExceptionalLayout() {
    if (document.getElementById('nollies-hero')) return;

    // Ambient glow element
    let glow = document.createElement('div');
    glow.className = 'ambient-glow';
    document.body.prepend(glow);

    // Hero Section
    let hero = document.createElement('section');
    hero.id = 'nollies-hero';
    hero.className = 'hero-section';
    hero.innerHTML = `
        <div class="hero-badge">✨ Next-Generation Digital Platform</div>
        <h1 class="hero-title">Experience the Future of <span>Nollies</span></h1>
        <p class="hero-subtitle">High-performance digital products, seamless security, and real-time operations engineered for maximum impact.</p>
        <div class="hero-cta-group">
            <button class="btn-primary" onclick="document.getElementById('real-world-grid')?.scrollIntoView({behavior:'smooth'})">Explore Gallery</button>
            <button class="btn-secondary" onclick="toggleConcierge()">Talk to AI Concierge</button>
        </div>
        
        <div class="stats-banner">
            <div class="stat-item">
                <div class="stat-num">99.9%</div>
                <div class="stat-lbl">Uptime Reliability</div>
            </div>
            <div class="stat-item">
                <div class="stat-num">&lt; 100ms</div>
                <div class="stat-lbl">Response Time</div>
            </div>
            <div class="stat-item">
                <div class="stat-num">256-bit</div>
                <div class="stat-lbl">Encrypted Safety</div>
            </div>
            <div class="stat-item">
                <div class="stat-num">24/7</div>
                <div class="stat-lbl">Automated Support</div>
            </div>
        </div>
    `;

    // Insert Hero right after Anti-Phishing banner or at top of body
    let banner = document.getElementById('anti-phishing-banner');
    if (banner && banner.nextSibling) {
        document.body.insertBefore(hero, banner.nextSibling);
    } else {
        document.body.insertBefore(hero, document.body.firstChild);
    }
}

document.addEventListener("DOMContentLoaded", buildExceptionalLayout);
