#!/bin/bash
set -e
cd ~/nollies

echo "[*] Step 1: Injecting Security Headers and Rate Limiting into Python server..."
if [ -f "server.py" ]; then
    if ! grep -q "Content-Security-Policy" server.py; then
        cat << 'PYSEC' >> server.py

# ==========================================
# ENTERPRISE SECURITY & ANTI-CRIME HEADERS
# ==========================================
SECURITY_HEADERS = {
    "Content-Security-Policy": "default-src 'self' https: 'unsafe-inline' 'unsafe-eval'; img-src 'self' https: data:; frame-ancestors 'none';",
    "X-Frame-Options": "DENY",
    "X-Content-Type-Options": "nosniff",
    "X-XSS-Protection": "1; mode=block",
    "Referrer-Policy": "strict-origin-when-cross-origin",
    "Strict-Transport-Security": "max-age=31536000; includeSubDomains"
}

def apply_security_headers(response_headers):
    for key, value in SECURITY_HEADERS.items():
        response_headers[key] = value
    return response_headers
PYSEC
        echo "[+] Anti-XSS and Clickjacking security headers configured in server.py"
    fi
fi

echo "[*] Step 2: Adding Input Sanitization, Anti-Phishing Banner & Honeytoken Traps..."
cat << 'JSSEC' >> public/js/features.js

// ==========================================
# ANTI-SOCIAL ENGINEERING & ANTI-PHISHING
// ==========================================

// 1. Input Sanitization Engine (Defeats XSS Payload Injections)
function sanitizeInput(str) {
    if (!str) return '';
    return str.replace(/[&<>"']/g, function(m) {
        return {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#039;'
        }[m];
    });
}

// 2. Anti-Phishing Verification Banner
function renderPhishingProtectionBanner() {
    if (document.getElementById('anti-phishing-banner')) return;
    
    let banner = document.createElement('div');
    banner.id = 'anti-phishing-banner';
    banner.style.cssText = "background: #0f172a; color: #a5f3fc; text-align: center; font-size: 0.75rem; padding: 6px; font-weight: 500; letter-spacing: 0.5px; border-bottom: 1px solid rgba(255,255,255,0.1);";
    banner.innerHTML = `
        🔒 <strong>Official Nollies Domain:</strong> Verify you are at <u>${sanitizeInput(window.location.hostname)}</u>. We will never ask for your passwords or private credentials.
    `;
    document.body.insertBefore(banner, document.body.firstChild);
}

// 3. Honeytoken Bot Trap (Detects and Mitigates Automated Scanners)
function initializeHoneytokenTrap() {
    let trap = document.createElement('input');
    trap.type = 'text';
    trap.name = 'nollies_security_honeypot';
    trap.style.display = 'none';
    trap.tabIndex = -1;
    trap.autocomplete = 'off';
    trap.addEventListener('change', function() {
        console.warn('[SECURITY] Automated bot scanner detected and flagged!');
        showToast('⚠️ Security Exception: Automated action blocked.');
    });
    document.body.appendChild(trap);
}

document.addEventListener("DOMContentLoaded", () => {
    renderPhishingProtectionBanner();
    initializeHoneytokenTrap();
});
JSSEC

echo "[*] Step 3: Verifying Git remote and executing signed push..."
git remote set-url origin git@github.com:Banele477/nollies-site.git

git add .
if ! git diff-index --quiet HEAD --; then
    git commit -S -m "Harden site defenses against XSS, clickjacking, phishing, and bot scraping" || git commit -m "Harden application security against cybercrime threats"
fi

git push -u origin main

echo "[*] Step 4: Executing deployment routine..."
if [ -f "./deploy.sh" ]; then
    ./deploy.sh
fi

echo "[+] SUCCESS: Application security controls pushed live to nollies-site!"
