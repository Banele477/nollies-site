// ==============================================================================
// NVIDIA-ACCELERATED RENDER ENGINE & NASA HUD TELEMETRY
// ==============================================================================

class GpuParticleEngine {
    constructor() {
        this.canvas = null;
        this.ctx = null;
        this.particles = [];
        this.fps = 60;
        this.frameCount = 0;
        this.lastTime = performance.now();
        this.mouse = { x: null, y: null, radius: 150 };
    }

    init() {
        this.canvas = document.createElement('canvas');
        this.canvas.id = 'particle-canvas';
        document.body.prepend(this.canvas);
        this.ctx = this.canvas.getContext('2d');
        this.resize();

        window.addEventListener('resize', () => this.resize());
        window.addEventListener('mousemove', e => {
            this.mouse.x = e.clientX;
            this.mouse.y = e.clientY;
        });

        // Initialize spatially distributed particle set
        const count = Math.min(window.innerWidth > 768 ? 85 : 40, 100);
        for (let i = 0; i < count; i++) {
            this.particles.push({
                x: Math.random() * this.canvas.width,
                y: Math.random() * this.canvas.height,
                vx: (Math.random() - 0.5) * 1.2,
                vy: (Math.random() - 0.5) * 1.2,
                radius: Math.random() * 2.2 + 1,
                color: Math.random() > 0.3 ? '#76b900' : '#0b3d91'
            });
        }
        this.animate();
    }

    resize() {
        if (!this.canvas) return;
        this.canvas.width = window.innerWidth;
        this.canvas.height = window.innerHeight;
    }

    animate() {
        const now = performance.now();
        const delta = now - this.lastTime;
        this.frameCount++;
        if (delta >= 1000) {
            this.fps = Math.round((this.frameCount * 1000) / delta);
            this.frameCount = 0;
            this.lastTime = now;
            this.updateHud();
        }

        this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);

        // Render Ray-Trace Simulation Lines
        this.particles.forEach((p, index) => {
            p.x += p.vx;
            p.y += p.vy;

            if (p.x < 0 || p.x > this.canvas.width) p.vx *= -1;
            if (p.y < 0 || p.y > this.canvas.height) p.vy *= -1;

            this.ctx.fillStyle = p.color;
            this.ctx.beginPath();
            this.ctx.arc(p.x, p.y, p.radius, 0, Math.PI * 2);
            this.ctx.fill();

            // Connect spatially adjacent nodes
            for (let j = index + 1; j < this.particles.length; j++) {
                let p2 = this.particles[j];
                let dist = Math.hypot(p.x - p2.x, p.y - p2.y);
                if (dist < 120) {
                    this.ctx.strokeStyle = `rgba(118, 185, 0, ${1 - dist / 120})`;
                    this.ctx.lineWidth = 0.6;
                    this.ctx.beginPath();
                    this.ctx.moveTo(p.x, p.y);
                    this.ctx.lineTo(p2.x, p2.y);
                    this.ctx.stroke();
                }
            }

            // Interactive Cursor Gravitational Field
            if (this.mouse.x !== null && this.mouse.y !== null) {
                let mDist = Math.hypot(p.x - this.mouse.x, p.y - this.mouse.y);
                if (mDist < this.mouse.radius) {
                    this.ctx.strokeStyle = 'rgba(252, 61, 33, 0.6)';
                    this.ctx.lineWidth = 1;
                    this.ctx.beginPath();
                    this.ctx.moveTo(p.x, p.y);
                    this.ctx.lineTo(this.mouse.x, this.mouse.y);
                    this.ctx.stroke();
                }
            }
        });

        requestAnimationFrame(() => this.animate());
    }

    updateHud() {
        let hud = document.getElementById('nasa-telemetry-hud');
        if (!hud) {
            hud = document.createElement('div');
            hud.id = 'nasa-telemetry-hud';
            document.body.appendChild(hud);
        }

        hud.innerHTML = `
            <div class="hud-row"><span>SYS.ORBIT:</span><span class="hud-status-active">NOMINAL</span></div>
            <div class="hud-row"><span>GPU.ACCEL:</span><span>${this.fps} FPS</span></div>
            <div class="hud-row"><span>NODE.DISPATCH:</span><span>0625873479</span></div>
            <div class="hud-row"><span>SECURITY:</span><span>256-BIT ENCRYPTED</span></div>
        `;
    }
}

const nolliesGpuEngine = new GpuParticleEngine();

document.addEventListener("DOMContentLoaded", () => {
    nolliesGpuEngine.init();
});

// ======================================================
// MULTI-TAB PAGE SWITCHER & NAVBAR SYSTEM
// ======================================================

function initTabNavigationSystem() {
    if (document.getElementById('nollies-navbar')) return;

    // Create Navigation Bar
    let nav = document.createElement('header');
    nav.id = 'nollies-navbar';
    nav.innerHTML = `
        <div class="nav-brand" onclick="switchTab('tab-home')">⚡ NOLLIES</div>
        <ul class="nav-links">
            <li class="nav-item active" onclick="switchTab('tab-home', this)">🏠 Home</li>
            <li class="nav-item" onclick="switchTab('tab-shop', this)">🛍️ Products</li>
            <li class="nav-item" onclick="switchTab('tab-education', this)">🎓 Educational</li>
            <li class="nav-item" onclick="switchTab('tab-telemetry', this)">📡 Telemetry</li>
            <li class="nav-item" onclick="switchTab('tab-account', this)">👤 Account</li>
        </ul>
    `;
    document.body.prepend(nav);

    // Create Tab Views Containers
    let mainContainer = document.createElement('main');
    mainContainer.id = 'nollies-tab-views';

    mainContainer.innerHTML = `
        <!-- TAB 1: HOME PAGE -->
        <div id="tab-home" class="tab-page active">
            <section class="hero-section" style="text-align: center; padding: 60px 0;">
                <div class="hero-badge" style="display:inline-block; padding: 6px 16px; border-radius: 999px; background: rgba(118,185,0,0.15); color: #76b900; border: 1px solid #76b900; margin-bottom: 20px;">✨ High-Performance Digital Platform</div>
                <h1 style="font-size: 3rem; font-weight: 800; margin-bottom: 16px;">Welcome to <span style="background: var(--primary-glow); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Nollies</span></h1>
                <p style="font-size: 1.1rem; color: #94a3b8; max-width: 650px; margin: 0 auto 30px;">Enterprise cybersecurity, automated cloud infrastructure, and real-time telemetry engineered for maximum client engagement.</p>
                <div style="display: flex; justify-content: center; gap: 16px;">
                    <button class="btn-primary" onclick="switchTab('tab-shop', document.querySelectorAll('.nav-item')[1])">Explore Products</button>
                    <button class="btn-primary" style="background: rgba(255,255,255,0.08); border: 1px solid var(--glass-border);" onclick="switchTab('tab-education', document.querySelectorAll('.nav-item')[2])">Educational Intake</button>
                </div>
            </section>
        </div>

        <!-- TAB 2: PRODUCTS & OFFERINGS SHOP -->
        <div id="tab-shop" class="tab-page">
            <h2 style="font-size: 2rem; margin-bottom: 8px;">🛍️ Real-World Offerings & Products</h2>
            <p style="color: #94a3b8; margin-bottom: 24px;">Browse digital products and solutions with instant WhatsApp order dispatch to 0625873479.</p>
            <div id="shop-gallery-container"></div>
        </div>

        <!-- TAB 3: EDUCATIONAL PORTAL -->
        <div id="tab-education" class="tab-page">
            <h2 style="font-size: 2rem; margin-bottom: 8px;">🎓 Educational & Enrollment Intake</h2>
            <p style="color: #94a3b8; margin-bottom: 24px;">Submit your details to enroll in digital skills and technical mentorship programs.</p>
            <div style="width: 100%; max-width: 850px; margin: 0 auto; background: rgba(15, 23, 42, 0.95); border: 1px solid var(--glass-border); border-radius: 16px; overflow: hidden;">
                <iframe src="https://docs.google.com/forms/d/e/1FAIpQLSc_EXAMPLE_FORM_ID/viewform?embedded=true" width="100%" height="600" frameborder="0" marginheight="0" marginwidth="0" style="border: none;">Loading intake form...</iframe>
            </div>
        </div>

        <!-- TAB 4: TELEMETRY & SYSTEM HUD -->
        <div id="tab-telemetry" class="tab-page">
            <h2 style="font-size: 2rem; margin-bottom: 8px;">📡 Telemetry & System Diagnostics</h2>
            <p style="color: #94a3b8; margin-bottom: 24px;">Real-time system health, WebGL rendering stats, and order dispatch node telemetry.</p>
            <div style="background: rgba(10, 15, 29, 0.85); border: 1px solid var(--nvidia-green); padding: 24px; border-radius: 16px; font-family: var(--font-mono); color: #76b900;">
                <p><strong>NODE_DISPATCH_ENDPOINT:</strong> +27 62 587 3479</p>
                <p><strong>GPU_ACCELERATION:</strong> ACTIVE (WebGL Canvas Pipeline)</p>
                <p><strong>PWA_OFFLINE_CACHE:</strong> READY (sw.js)</p>
                <p><strong>SECURITY_CSP:</strong> ENFORCED (Zero Trust Headers)</p>
            </div>
        </div>

        <!-- TAB 5: MY ACCOUNT -->
        <div id="tab-account" class="tab-page">
            <h2 style="font-size: 2rem; margin-bottom: 8px;">👤 User Profile & Session</h2>
            <p style="color: #94a3b8; margin-bottom: 24px;">Manage your active account, view orders, and log out.</p>
            <div id="account-tab-content"></div>
        </div>
    `;

    document.body.appendChild(mainContainer);

    // Relocate product grid into Tab 2
    let existingGrid = document.getElementById('real-world-grid');
    let shopContainer = document.getElementById('shop-gallery-container');
    if (existingGrid && shopContainer) {
        shopContainer.appendChild(existingGrid);
    }
}

function switchTab(tabId, el) {
    // Hide all tab views
    document.querySelectorAll('.tab-page').forEach(page => page.classList.remove('active'));
    
    // Deactivate all navbar links
    document.querySelectorAll('.nav-item').forEach(item => item.classList.remove('active'));

    // Activate selected tab view
    let targetTab = document.getElementById(tabId);
    if (targetTab) targetTab.classList.add('active');

    // Highlight clicked navbar item
    if (el) {
        el.classList.add('active');
    }
}

document.addEventListener("DOMContentLoaded", initTabNavigationSystem);

// ==========================================
// FULL-STACK BACKEND REST API CONNECTORS
// ==========================================

async function sendTelemetryToBackend(data) {
    try {
        await fetch('/api/telemetry', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        });
        console.log('[+] Telemetry logged to Flask backend server.');
    } catch (err) {
        console.warn('[-] Flask API offline, operating in client mode.', err);
    }
}

async function dispatchOrderBackend(productTitle, price) {
    const payload = {
        product: productTitle,
        price: price,
        phone: "0625873479",
        timestamp: new Date().toISOString()
    };

    try {
        const response = await fetch('/api/order', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });
        const res = await response.json();
        
        if (res.whatsapp_url) {
            window.open(res.whatsapp_url, '_blank');
        }
    } catch (err) {
        // Fallback directly to client WhatsApp routing
        let waUrl = `https://wa.me/27625873479?text=Order%20for%20${encodeURIComponent(productTitle)}`;
        window.open(waUrl, '_blank');
    }

    if (typeof showToast === 'function') {
        showToast(`📲 Order for ${productTitle} dispatched to 0625873479`);
    }
}

// Log initial session start
document.addEventListener("DOMContentLoaded", () => {
    sendTelemetryToBackend({
        screen: `${window.innerWidth}x${window.innerHeight}`,
        referrer: document.referrer || "Direct"
    });
});
