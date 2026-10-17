const CACHE_NAME = 'nollies-v2.0';
const STATIC_ASSETS = [
    '/',
    '/index.html',
    '/manifest.json'
];

self.addEventListener('install', (e) => {
    e.waitUntil(
        caches.open(CACHE_NAME).then((cache) => cache.addAll(STATIC_ASSETS))
    );
    self.skipWaiting();
});

self.addEventListener('activate', (e) => {
    e.waitUntil(
        caches.keys().then((keys) => {
            return Promise.all(
                keys.filter((k) => k !== CACHE_NAME).map((k) => caches.delete(k))
            );
        })
    );
    self.clients.claim();
});

self.addEventListener('fetch', (e) => {
    if (e.request.method !== 'GET') return;
    e.respondWith(
        caches.match(e.request).then((cached) => {
            return cached || fetch(e.request).then((response) => {
                if (response.status === 200 && e.request.url.startsWith('http')) {
                    const copy = response.clone();
                    caches.open(CACHE_NAME).then((cache) => cache.put(e.request, copy));
                }
                return response;
            });
        }).catch(() => caches.match('/index.html'))
    );
});
