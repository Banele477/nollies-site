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
