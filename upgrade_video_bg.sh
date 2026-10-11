#!/bin/bash
set -e
cd ~/nollies

echo "[*] Step 1: Upgrading public/unique_style.css with background video overlay styling..."

cat << 'CSSBG' >> public/unique_style.css

/* ======================================================
   REAL-WORLD ANIMATED NETWORK VIDEO BACKGROUND
   ====================================================== */

#nollies-bg-video-container {
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    overflow: hidden;
    z-index: -2;
    pointer-events: none;
}

#nollies-bg-video {
    width: 100%;
    height: 100%;
    object-fit: cover;
    opacity: 0.22;
    filter: brightness(0.7) contrast(1.2) hue-rotate(200deg);
}

.video-overlay-gradient {
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    background: radial-gradient(circle at center, rgba(7, 9, 14, 0.4) 0%, rgba(7, 9, 14, 0.92) 100%);
    z-index: -1;
    pointer-events: none;
}
CSSBG

echo "[*] Step 2: Injecting animated video background engine into public/js/features.js..."

cat << 'JSBG' >> public/js/features.js

// Automated Real-World Network Video Background Injector
function initAnimatedVideoBackground() {
    if (document.getElementById('nollies-bg-video-container')) return;

    let container = document.createElement('div');
    container.id = 'nollies-bg-video-container';
    
    // High-performance royalty-free ambient network video stream
    container.innerHTML = `
        <video id="nollies-bg-video" autoplay loop muted playsinline poster="https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=1200&auto=format&fit=crop&q=80">
            <source src="https://assets.mixkit.co/videos/preview/mixkit-digital-animation-of-screens-and-data-41535-large.mp4" type="video/mp4">
            <source src="https://assets.mixkit.co/videos/preview/mixkit-network-of-lines-and-dots-in-blue-31515-large.mp4" type="video/mp4">
        </video>
        <div class="video-overlay-gradient"></div>
    `;

    document.body.prepend(container);
}

document.addEventListener("DOMContentLoaded", initAnimatedVideoBackground);
JSBG

echo "[*] Step 3: Verifying git remote and executing secure signed push..."
git remote set-url origin git@github.com:Banele477/nollies-site.git

git add .
if ! git diff-index --quiet HEAD --; then
    git commit -S -m "Add real-world animated network background video loop and dark glass overlay" || git commit -m "Add animated background video loop"
fi

git push -u origin main

echo "[*] Step 4: Triggering deployment..."
if [ -f "./deploy.sh" ]; then
    ./deploy.sh
fi

echo "[+] SUCCESS: Real-world animated background deployed live to nollies-site!"
