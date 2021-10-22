self.addEventListener('fetch', function (e) {
    // ここは空でもOK
})
self.addEventListener('install', function (e) {
    console.log('[ServiceWorker] Install');
});

self.addEventListener('activate', function (e) {
    console.log('[ServiceWorker] Activate');
});
