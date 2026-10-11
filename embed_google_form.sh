#!/bin/bash
set -e
cd ~/nollies

echo "[*] Step 1: Upgrading public/js/features.js to embed Nollies Educational Google Form..."

cat << 'JSFORM' >> public/js/features.js

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
JSFORM

echo "[*] Step 2: Committing and pushing form integration to GitHub..."
git remote set-url origin git@github.com:Banele477/nollies-site.git

git add .
if ! git diff-index --quiet HEAD --; then
    git commit -S -m "Integrate Nollies educational intake Google Form embed and navigation button" || git commit -m "Integrate Google Form embed"
fi

git push -u origin main

echo "[+] SUCCESS: Google Form modal integration compiled and pushed to nollies-site!"
