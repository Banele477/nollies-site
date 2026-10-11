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
