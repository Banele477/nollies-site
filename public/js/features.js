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
