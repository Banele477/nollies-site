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
