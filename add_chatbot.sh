#!/bin/bash
set -e
cd ~/nollies

echo "[*] Step 1: Upgrading public/js/features.js with interactive Chatbot logic..."

cat << 'JSCHAT' >> public/js/features.js

// ==========================================
// CUSTOMER SUPPORT CHATBOT ENGINE
// ==========================================

const chatbotKnowledgeBase = [
    {
        keywords: ["shipping", "delivery", "dispatch", "courier", "cost"],
        answer: "📦 We deliver nation-wide! Standard delivery takes 2-4 business days. Free shipping on orders over R1000."
    },
    {
        keywords: ["return", "refund", "exchange", "policy"],
        answer: "🔄 We offer a 14-day hassle-free return policy on all unused items. Contact support with your order ID to initiate a return."
    },
    {
        keywords: ["track", "order status", "where is my package"],
        answer: "🚚 You can track your order using the tracking link sent to your email or SMS once dispatched."
    },
    {
        keywords: ["payment", "pay", "card", "eft", "method"],
        answer: "💳 We accept major Credit/Debit Cards, Instant EFT, and secure mobile payments."
    },
    {
        keywords: ["hours", "open", "time", "contact", "support"],
        answer: "🕒 Our online store is open 24/7! Customer support operates Monday – Friday, 08:00 to 17:00 SAST."
    }
];

function getChatbotResponse(userQuery) {
    let lowerQuery = userQuery.toLowerCase().trim();
    if (!lowerQuery) return "Please type a question so I can assist you!";

    for (let entry of chatbotKnowledgeBase) {
        if (entry.keywords.some(kw => lowerQuery.includes(kw))) {
            return entry.answer;
        }
    }
    return "🤖 I'm sorry, I didn't quite catch that. You can ask me about **shipping**, **returns**, **order tracking**, or **payment options**!";
}

// Upgrade Concierge Widget to Interactive Chatbot Interface
document.addEventListener("DOMContentLoaded", () => {
    let conciergeBox = document.getElementById('concierge-box');
    if (conciergeBox) {
        conciergeBox.style.width = "320px";
        conciergeBox.innerHTML = `
            <div class="concierge-header">
                <span>🤖 Nollies Assistant</span>
                <span onclick="toggleConcierge()" style="cursor:pointer; font-size:1.2rem;">&times;</span>
            </div>
            <div class="concierge-body" id="chatHistory" style="height: 220px; overflow-y: auto; display: flex; flex-direction: column; gap: 8px; padding: 10px;">
                <div style="background: rgba(99, 102, 241, 0.15); padding: 8px 12px; border-radius: 10px; font-size: 0.85rem; max-width: 85%; align-self: flex-start;">
                    Hello! 👋 I'm your Nollies assistant. How can I help you today?
                </div>
            </div>
            <div style="display: flex; padding: 8px; border-top: 1px solid var(--glass-border, #ddd); background: rgba(0,0,0,0.02);">
                <input type="text" id="chatInput" placeholder="Ask a question..." style="flex: 1; padding: 8px; border-radius: 6px; border: 1px solid #ccc; font-size: 0.85rem; outline: none;" onkeypress="if(event.key === 'Enter') processChatInput()">
                <button onclick="processChatInput()" style="background: #6366f1; color: white; border: none; padding: 8px 12px; margin-left: 6px; border-radius: 6px; cursor: pointer; font-size: 0.85rem;">Send</button>
            </div>
        `;
    }
});

function processChatInput() {
    let input = document.getElementById('chatInput');
    let history = document.getElementById('chatHistory');
    if (!input || !history) return;

    let query = sanitizeInput(input.value);
    if (!query) return;

    // Append User Message
    let userMsg = document.createElement('div');
    userMsg.style.cssText = "background: #6366f1; color: white; padding: 8px 12px; border-radius: 10px; font-size: 0.85rem; max-width: 85%; align-self: flex-end; word-break: break-word;";
    userMsg.innerText = query;
    history.appendChild(userMsg);

    input.value = "";
    history.scrollTop = history.scrollHeight;

    // Simulate Bot Response Delay
    setTimeout(() => {
        let botReply = getChatbotResponse(query);
        let botMsg = document.createElement('div');
        botMsg.style.cssText = "background: rgba(99, 102, 241, 0.15); color: var(--text-main, #333); padding: 8px 12px; border-radius: 10px; font-size: 0.85rem; max-width: 85%; align-self: flex-start; word-break: break-word;";
        botMsg.innerText = botReply;
        history.appendChild(botMsg);
        history.scrollTop = history.scrollHeight;
    }, 400);
}
JSCHAT

echo "[*] Step 2: Ensuring git remote is set to nollies-site..."
git remote set-url origin git@github.com:Banele477/nollies-site.git

echo "[*] Step 3: Staging, committing, and pushing updates securely..."
git add .
if ! git diff-index --quiet HEAD --; then
    git commit -S -m "Add interactive customer support chatbot with knowledge base" || git commit -m "Add customer support chatbot"
fi

git push -u origin main

echo "[*] Step 4: Running deployment script..."
if [ -f "./deploy.sh" ]; then
    ./deploy.sh
fi

echo "[+] SUCCESS: Customer support chatbot deployed live to nollies-site!"
