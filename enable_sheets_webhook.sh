#!/bin/bash
set -e
cd ~/nollies

echo "[*] Step 1: Injecting Webhook Logging Engine into public/js/features.js..."

cat << 'JSWEBHOOK' >> public/js/features.js

// ==========================================
// GOOGLE SHEETS AUTOMATED WEBHOOK LOGGER
// ==========================================
// Paste your Google Apps Script Web App URL below:
const GOOGLE_SHEETS_WEBHOOK_URL = "YOUR_GOOGLE_APPS_SCRIPT_WEBHOOK_URL_HERE";

async function logOrderToGoogleSheets(orderData) {
    if (!GOOGLE_SHEETS_WEBHOOK_URL || GOOGLE_SHEETS_WEBHOOK_URL.includes("YOUR_GOOGLE_APPS_SCRIPT_WEBHOOK_URL_HERE")) {
        console.warn("[Webhook] Google Sheets Webhook URL not configured yet.");
        return;
    }

    try {
        const payload = {
            timestamp: new Date().toLocaleString("en-ZA", { timeZone: "Africa/Johannesburg" }),
            product_name: orderData.title || "Nollies Product",
            price: orderData.price ? `R ${orderData.price.toFixed(2)}` : "R 0.00",
            customer_phone: orderData.phone || "0625873479",
            customer_email: orderData.email || "client@nollies-site.com",
            source: orderData.source || "Web Store Checkout"
        };

        // Send POST request to Google Apps Script Webhook
        await fetch(GOOGLE_SHEETS_WEBHOOK_URL, {
            method: 'POST',
            mode: 'no-cors', // Bypasses browser CORS restriction for Apps Script
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });

        console.log("[+] Order successfully dispatched to Google Sheets!");
        if (typeof showToast === 'function') {
            showToast("📊 Order automatically logged to database!");
        }
    } catch (err) {
        console.error("[-] Webhook dispatch error:", err);
    }
}
JSWEBHOOK

echo "[*] Step 2: Committing and pushing updates to GitHub..."
git remote set-url origin git@github.com:Banele477/nollies-site.git

git add .
if ! git diff-index --quiet HEAD --; then
    git commit -S -m "Add automated Google Sheets webhook order logging engine" || git commit -m "Add Google Sheets webhook logger"
fi

git push -u origin main

echo "[+] SUCCESS: Webhook logger added and pushed to nollies-site!"
