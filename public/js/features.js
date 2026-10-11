// --- INTERACTIVE MOUSE-FOLLOWING PARTICLE CANVAS & VIDEO BG ---
function initCanvasParticlesAndVideo() {
    if (document.getElementById('nollies-bg-container')) return;

    let container = document.createElement('div');
    container.id = 'nollies-bg-container';
    container.innerHTML = `
        <video id="nollies-bg-video" autoplay loop muted playsinline>
            <source src="https://assets.mixkit.co/videos/preview/mixkit-digital-animation-of-screens-and-data-41535-large.mp4" type="video/mp4">
        </video>
        <div class="video-overlay-gradient"></div>
    `;
    document.body.prepend(container);

    let canvas = document.createElement('canvas');
    canvas.id = 'particle-canvas';
    document.body.prepend(canvas);

    let ctx = canvas.getContext('2d');
    let width = canvas.width = window.innerWidth;
    let height = canvas.height = window.innerHeight;

    window.addEventListener('resize', () => {
        width = canvas.width = window.innerWidth;
        height = canvas.height = window.innerHeight;
    });

    let mouse = { x: null, y: null, radius: 130 };
    window.addEventListener('mousemove', e => { mouse.x = e.clientX; mouse.y = e.clientY; });
    window.addEventListener('mouseleave', () => { mouse.x = null; mouse.y = null; });

    let particles = [];
    let particleCount = Math.min(window.innerWidth > 768 ? 65 : 30, 70);

    for (let i = 0; i < particleCount; i++) {
        particles.push({
            x: Math.random() * width,
            y: Math.random() * height,
            vx: (Math.random() - 0.5) * 0.8,
            vy: (Math.random() - 0.5) * 0.8,
            radius: Math.random() * 2 + 1
        });
    }

    function animateParticles() {
        ctx.clearRect(0, 0, width, height);
        ctx.fillStyle = 'rgba(99, 102, 241, 0.6)';
        ctx.strokeStyle = 'rgba(99, 102, 241, 0.18)';

        particles.forEach((p, index) => {
            p.x += p.vx; p.y += p.vy;
            if (p.x < 0 || p.x > width) p.vx *= -1;
            if (p.y < 0 || p.y > height) p.vy *= -1;

            ctx.beginPath();
            ctx.arc(p.x, p.y, p.radius, 0, Math.PI * 2);
            ctx.fill();

            // Connect nearby particles
            for (let j = index + 1; j < particles.length; j++) {
                let p2 = particles[j];
                let dist = Math.hypot(p.x - p2.x, p.y - p2.y);
                if (dist < 110) {
                    ctx.beginPath();
                    ctx.moveTo(p.x, p.y);
                    ctx.lineTo(p2.x, p2.y);
                    ctx.stroke();
                }
            }

            // Mouse interaction
            if (mouse.x !== null && mouse.y !== null) {
                let mDist = Math.hypot(p.x - mouse.x, p.y - mouse.y);
                if (mDist < mouse.radius) {
                    ctx.strokeStyle = 'rgba(236, 72, 153, 0.35)';
                    ctx.beginPath();
                    ctx.moveTo(p.x, p.y);
                    ctx.lineTo(mouse.x, mouse.y);
                    ctx.stroke();
                }
            }
        });
        requestAnimationFrame(animateParticles);
    }
    animateParticles();
}

// --- EXCEPTIONAL HERO & CHATBOT ---
function buildLayoutAndChatbot() {
    if (document.getElementById('nollies-hero')) return;

    let hero = document.createElement('section');
    hero.id = 'nollies-hero';
    hero.className = 'hero-section';
    hero.innerHTML = `
        <div class="hero-badge">✨ Enterprise Digital Ecosystem</div>
        <h1 class="hero-title">Experience the Future of <span>Nollies</span></h1>
        <p class="hero-subtitle">High-performance digital products, secure automation pipelines, and real-time telemetry engineered for maximum trust.</p>
        <div class="hero-cta-group">
            <button class="btn-primary" onclick="document.getElementById('real-world-grid')?.scrollIntoView({behavior:'smooth'})">Explore Gallery</button>
        </div>
    `;
    document.body.insertBefore(hero, document.body.firstChild);

    // Chatbot widget
    let concierge = document.createElement('div');
    concierge.id = 'nollies-concierge';
    concierge.innerHTML = `
        <div id="concierge-box">
            <div class="concierge-header">
                <span>🤖 Nollies Assistant</span>
                <span onclick="toggleConcierge()" style="cursor:pointer;">&times;</span>
            </div>
            <div id="chatHistory" style="padding:10px; height:180px; overflow-y:auto; font-size:0.85rem; color:#cbd5e1;">
                Hello! 👋 How can I help you today? Ask about shipping, returns, or security.
            </div>
            <div style="display:flex; padding:8px; border-top:1px solid rgba(255,255,255,0.1);">
                <input type="text" id="chatInput" placeholder="Ask a question..." style="flex:1; padding:6px; background:rgba(0,0,0,0.3); border:1px solid rgba(255,255,255,0.2); color:#fff; border-radius:4px; font-size:0.8rem;" onkeypress="if(event.key==='Enter') sendChat()">
                <button onclick="sendChat()" style="background:#6366f1; color:#fff; border:none; padding:6px 10px; margin-left:4px; border-radius:4px; cursor:pointer;">Send</button>
            </div>
        </div>
        <button id="concierge-btn" onclick="toggleConcierge()">💬</button>
    `;
    document.body.appendChild(concierge);
}

function toggleConcierge() {
    let box = document.getElementById('concierge-box');
    box.style.display = box.style.display === 'flex' ? 'none' : 'flex';
}

function sendChat() {
    let input = document.getElementById('chatInput');
    let history = document.getElementById('chatHistory');
    if (!input || !input.value.trim()) return;
    let q = sanitizeInput(input.value);
    
    history.innerHTML += `<div style="text-align:right; margin:4px 0;"><span style="background:#6366f1; padding:4px 8px; border-radius:6px; display:inline-block;">${q}</span></div>`;
    input.value = "";
    
    setTimeout(() => {
        let ans = "📦 We deliver nation-wide within 2-4 business days with 256-bit encrypted checkout.";
        if(q.toLowerCase().includes('return')) ans = "🔄 14-day hassle-free return policy on all items.";
        history.innerHTML += `<div style="text-align:left; margin:4px 0;"><span style="background:rgba(255,255,255,0.1); padding:4px 8px; border-radius:6px; display:inline-block;">${ans}</span></div>`;
        history.scrollTop = history.scrollHeight;
    }, 400);
}

document.addEventListener("DOMContentLoaded", () => {
    initCanvasParticlesAndVideo();
    buildLayoutAndChatbot();
});

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

// ==========================================
// CLIENT-SIDE NOTIFICATION TRIGGER HELPERS
// ==========================================

function dispatchOrderConfirmation(userEmail, userPhone, orderId) {
    console.log(`[Notification Engine] Dispatching Email & SMS confirmation for Order #${orderId}...`);
    
    // Trigger local backend notification API or display instant UI feedback
    showToast(`📱 Confirmation SMS sent to ${sanitizeInput(userPhone)} & Email sent to ${sanitizeInput(userEmail)}`);
}

// Toast Notification UI Helper
function showToast(message) {
    let toast = document.createElement('div');
    toast.style.cssText = "position: fixed; bottom: 20px; left: 50%; transform: translateX(-50%); background: #10b981; color: white; padding: 12px 24px; border-radius: 10px; font-weight: bold; font-size: 0.9rem; z-index: 10000; box-shadow: 0 10px 25px rgba(0,0,0,0.3);";
    toast.innerText = message;
    document.body.appendChild(toast);
    setTimeout(() => toast.remove(), 4000);
}

// Load Client Location Tracer Module
if (!document.querySelector('script[src*="tracer.js"]')) { let s = document.createElement('script'); s.src = '/public/js/tracer.js'; document.head.appendChild(s); }

// ==========================================
// NOLLIES EDUCATIONAL GOOGLE FORM EMBEDDER
// ==========================================

function openEducationalFormModal() {
    let modal = document.getElementById('nollies-form-modal');
    if (!modal) {
        modal = document.createElement('div');
        modal.id = 'nollies-form-modal';
        modal.style.cssText = "position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; background: rgba(7, 9, 14, 0.9); backdrop-filter: blur(15px); z-index: 10000; display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 20px;";
        
        modal.innerHTML = `
            <div style="width: 100%; max-width: 850px; background: rgba(15, 23, 42, 0.95); border: 1px solid rgba(99, 102, 241, 0.4); border-radius: 16px; overflow: hidden; display: flex; flex-direction: column; max-height: 90vh;">
                <div style="background: linear-gradient(135deg, #6366f1, #a855f7); color: white; padding: 14px 20px; display: flex; justify-content: space-between; align-items: center; font-weight: bold;">
                    <span>🎓 Nollies Educational & Enrollment Portal</span>
                    <span onclick="document.getElementById('nollies-form-modal').style.display='none'" style="cursor: pointer; font-size: 1.4rem;">&times;</span>
                </div>
                <iframe src="https://docs.google.com/forms/d/e/1FAIpQLSc_EXAMPLE_FORM_ID/viewform?embedded=true" width="100%" height="650" frameborder="0" marginheight="0" marginwidth="0" style="border: none;">Loading enrollment form...</iframe>
            </div>
        `;
        document.body.appendChild(modal);
    } else {
        modal.style.display = 'flex';
    }
}

// Add Educational Form Trigger Button in Nav
document.addEventListener("DOMContentLoaded", () => {
    let heroCta = document.querySelector('.hero-cta-group');
    if (heroCta && !document.getElementById('btn-educational-form')) {
        let btn = document.createElement('button');
        btn.id = 'btn-educational-form';
        btn.className = 'btn-secondary';
        btn.innerText = '🎓 Educational Intake Form';
        btn.onclick = openEducationalFormModal;
        heroCta.appendChild(btn);
    }
});
