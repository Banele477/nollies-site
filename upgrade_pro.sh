#!/bin/bash
set -e
cd ~/nollies

echo "[*] Step 1: Extending public/js/features.js with Cart & Review features..."
cat << 'JSCODE' >> public/js/features.js

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
JSCODE

echo "[*] Step 2: Registering Progressive Web App (PWA) Service Worker..."
cat << 'SWCODE' > public/sw.js
const CACHE_NAME = 'nollies-v1';
const ASSETS_TO_CACHE = [
  '/',
  '/public/js/products.js',
  '/public/js/config.js',
  '/public/js/features.js'
];

self.addEventListener('install', (e) => {
  e.waitUntil(
    caches.open(CACHE_NAME).then((cache) => cache.addAll(ASSETS_TO_CACHE))
  );
});

self.addEventListener('fetch', (e) => {
  e.respondWith(
    caches.match(e.request).then((res) => res || fetch(e.request))
  );
});
SWCODE

cat << 'PWACODE' >> public/js/features.js

// Register Service Worker for PWA Support
if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('/public/sw.js')
        .then(() => console.log('PWA Service Worker Registered Successfully'))
        .catch(err => console.log('SW Registration Failed:', err));
}
PWACODE

echo "[*] Step 3: Adding automated SEO Sitemap generator to backend..."
cat << 'PYCODE' > generate_sitemap.py
import os
import datetime

DOMAIN = "https://nollies.co.za" # Update with your domain

urls = [
    "/",
    "/#products",
    "/#about"
]

sitemap_xml = '<?xml version="1.0" encoding="UTF-8"?>\n'
sitemap_xml += '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n'

today = datetime.datetime.now().strftime("%Y-%m-%d")

for url in urls:
    sitemap_xml += f'  <url>\n    <loc>{DOMAIN}{url}</loc>\n    <lastmod>{today}</lastmod>\n    <priority>0.8</priority>\n  </url>\n'

sitemap_xml += '</urlset>'

with open("public/sitemap.xml", "w") as f:
    f.write(sitemap_xml)

print("[+] Generated public/sitemap.xml successfully!")
PYCODE

python3 generate_sitemap.py || true

echo "[*] Step 4: Pushing updates securely to GitHub..."
if [ -f "./git-secure-push.sh" ]; then
    ./git-secure-push.sh "Add cart system, review ratings, PWA service worker, and SEO sitemap"
else
    git add .
    git commit -m "Add enterprise features: Cart, Rating, PWA, SEO"
    git push origin main
fi

echo "[*] Step 5: Triggering server deployment..."
if [ -f "./deploy.sh" ]; then
    ./deploy.sh
fi

echo "[+] SUCCESS: Your website has been upgraded with Cart, Reviews, PWA, and SEO features!"
