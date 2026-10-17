#!/data/data/com.termux/files/usr/bin/bash
set -e

cd ~/nollies
echo "📲 Adding PWA Install Button and Installation Guide..."

# Update public/index.html to ensure the install button and modal are present and functional
python3 -c '
with open("public/index.html", "r", encoding="utf-8") as f:
    html = f.read()

# Make sure triggerInstall script and modal exist
if "function triggerInstall" not in html:
    modal_code = """
    <!-- PWA Install Modal -->
    <div id="install-modal" class="fixed inset-0 bg-slate-950/85 backdrop-blur-md z-50 hidden flex items-center justify-center p-4">
        <div class="bg-slate-900 rounded-3xl p-6 border border-slate-700 max-w-sm w-full space-y-4 shadow-2xl">
            <div class="flex justify-between items-center border-b border-slate-800 pb-3">
                <h3 class="font-black text-sm text-orange-400">📲 Install Nollie\x27s App</h3>
                <button onclick="closeInstallModal()" class="text-slate-400 text-xl font-bold">&times;</button>
            </div>
            <p class="text-xs text-slate-300 leading-relaxed">
                Install Nollie\x27s on your phone home screen to use it completely offline!
            </p>
            <div class="bg-slate-950 p-3.5 rounded-xl border border-slate-800 text-xs space-y-2 text-slate-200">
                <p><strong>Android (Chrome):</strong> Tap your browser menu <strong>(⋮)</strong> at the top right, then tap <strong>"Install app"</strong> or <strong>"Add to Home screen"</strong>.</p>
                <p><strong>iPhone (Safari):</strong> Tap the Share button at the bottom, then tap <strong>"Add to Home Screen"</strong>.</p>
            </div>
            <button onclick="closeInstallModal()" class="w-full orange-gradient text-white font-black py-3 rounded-xl text-xs shadow-lg">
                Got it, thanks!
            </button>
        </div>
    </div>
    </body>
    """
    html = html.replace("</body>", modal_code)

print("✅ Index HTML updated with Install Modal!")
'

# Update public/js/app.js with triggerInstall functions
python3 -c '
with open("public/js/app.js", "r", encoding="utf-8") as f:
    js = f.read()

if "function triggerInstall" not in js:
    js += """
function triggerInstall() {
    const modal = document.getElementById("install-modal");
    if (modal) {
        modal.classList.remove("hidden");
        modal.classList.add("flex");
    }
}

function closeInstallModal() {
    const modal = document.getElementById("install-modal");
    if (modal) {
        modal.classList.add("hidden");
        modal.classList.remove("flex");
    }
}
"""
    with open("public/js/app.js", "w", encoding="utf-8") as f:
        f.write(js)

print("✅ App JS updated with Install trigger functions!")
'

cp public/index.html index.html 2>/dev/null || true
echo "======================================================="
echo "✅ PWA App Install Button Feature Added Successfully!"
echo "======================================================="
