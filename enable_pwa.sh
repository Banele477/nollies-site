#!/bin/bash
set -e
cd ~/nollies

echo "[*] Step 1: Creating Web App Manifest (public/manifest.json)..."
cat << 'MANIFEST' > public/manifest.json
{
  "short_name": "Nollies",
  "name": "Nollies Enterprise Ecosystem",
  "icons": [
    {
      "src": "https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=192&auto=format&fit=crop&q=80",
      "type": "image/png",
      "sizes": "192x192"
    },
    {
      "src": "https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=512&auto=format&fit=crop&q=80",
      "type": "image/png",
      "sizes": "512x512"
    }
  ],
  "start_url": "/",
  "background_color": "#07090e",
  "theme_color": "#6366f1",
  "display": "standalone",
  "orientation": "portrait-primary",
  "description": "High-performance digital products, secure automation, and real-time operations."
}
MANIFEST

echo "[*] Step 2: Creating Service Worker for Offline & Caching Support (public/sw.js)..."
cat << 'SW' > public/sw.js
const CACHE_NAME = 'nollies-v1';
const ASSETS_TO_CACHE = [
  '/',
  '/public/unique_style.css',
  '/public/js/products.js',
  '/public/js/features.js',
  '/public/manifest.json'
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(ASSETS_TO_CACHE);
    })
  );
});

self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      return response || fetch(event.request);
    })
  );
});
SW

echo "[*] Step 3: Registering Service Worker & PWA Install Banner in public/js/features.js..."
cat << 'JSPWA' >> public/js/features.js

// ==========================================
// PWA INSTALLATION ENGINE & SERVICE WORKER
// ==========================================

if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker.register('/public/sw.js')
      .then(reg => console.log('[PWA] Service Worker registered successfully.'))
      .catch(err => console.log('[PWA] Service Worker registration failed:', err));
  });
}

let deferredPrompt;
window.addEventListener('beforeinstallprompt', (e) => {
  e.preventDefault();
  deferredPrompt = e;
  showPwaInstallBanner();
});

function showPwaInstallBanner() {
  if (document.getElementById('pwa-install-banner')) return;

  let banner = document.createElement('div');
  banner.id = 'pwa-install-banner';
  banner.style.cssText = "position: fixed; top: 15px; right: 15px; z-index: 9999; background: rgba(15, 23, 42, 0.95); border: 1px solid rgba(99, 102, 241, 0.4); padding: 10px 16px; border-radius: 12px; backdrop-filter: blur(12px); color: #fff; font-size: 0.85rem; display: flex; align-items: center; gap: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.5);";
  banner.innerHTML = `
    <span>📲 Install <strong>Nollies App</strong> on your device</span>
    <button onclick="triggerPwaInstall()" style="background: linear-gradient(135deg, #6366f1, #a855f7); color: white; border: none; padding: 6px 12px; border-radius: 6px; cursor: pointer; font-weight: bold; font-size: 0.8rem;">Install</button>
    <span onclick="this.parentElement.remove()" style="cursor: pointer; opacity: 0.7;">&times;</span>
  `;
  document.body.appendChild(banner);
}

function triggerPwaInstall() {
  if (deferredPrompt) {
    deferredPrompt.prompt();
    deferredPrompt.userChoice.then((choiceResult) => {
      if (choiceResult.outcome === 'accepted') {
        console.log('[PWA] User accepted the install prompt.');
      }
      deferredPrompt = null;
      let banner = document.getElementById('pwa-install-banner');
      if (banner) banner.remove();
    });
  }
}
JSPWA

echo "[*] Step 4: Pushing PWA updates live to GitHub..."
git remote set-url origin git@github.com:Banele477/nollies-site.git

git add .
if ! git diff-index --quiet HEAD --; then
    git commit -S -m "Enable PWA support: manifest.json, sw.js offline caching, and native app install banner" || git commit -m "Enable PWA offline app capabilities"
fi

git push -u origin main

echo "[+] SUCCESS: Nollies is now downloadable as a native app and pushed to GitHub!"
