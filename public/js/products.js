// Enterprise Real-World Offerings & Direct SMS/WhatsApp Order Routing
const OWNER_PHONE = "27625873479"; // International format for 0625873479 (South Africa +27)

const nolliesOfferings = [
    {
        id: "offering-1",
        title: "Enterprise Cybersecurity & Cloud Nodes",
        category: "Infrastructure",
        description: "Hardened server clusters, active intrusion detection, and encrypted database pipelines.",
        image: "https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=800&auto=format&fit=crop&q=80",
        price: 1500.00
    },
    {
        id: "offering-2",
        title: "Smart Logistics & Automated Hubs",
        category: "Operations",
        description: "Real-time telemetry, automated tracking, and high-efficiency inventory dispatch systems.",
        image: "https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=800&auto=format&fit=crop&q=80",
        price: 2200.00
    },
    {
        id: "offering-3",
        title: "AI Analytics & Intelligence Dashboard",
        category: "Data Science",
        description: "Predictive decision engines, automated reporting, and deep data visualization suites.",
        image: "https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&auto=format&fit=crop&q=80",
        price: 1850.00
    },
    {
        id: "offering-4",
        title: "Global Connectivity Terminals",
        category: "Networking",
        description: "Ultra-low latency API gateways, distributed CDN routing, and fault-tolerant node meshing.",
        image: "https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=800&auto=format&fit=crop&q=80",
        price: 1350.00
    }
];

function renderOfferings() {
    let container = document.getElementById('real-world-grid');
    if (!container) {
        container = document.createElement('div');
        container.id = 'real-world-grid';
        document.body.appendChild(container);
    } else {
        container.innerHTML = "";
    }

    nolliesOfferings.forEach((item, index) => {
        let card = document.createElement('div');
        card.className = 'product-card';
        card.style.animationDelay = `${index * 0.15}s`;
        
        card.innerHTML = `
            <img src="${item.image}" alt="${item.title}">
            <span style="font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; color: #818cf8; font-weight: 700;">${item.category}</span>
            <h3 style="font-size: 1.2rem; margin: 6px 0; color: #fff; font-weight: 700;">${item.title}</h3>
            <p style="font-size: 0.85rem; color: #94a3b8; margin-bottom: 16px;">${item.description}</p>
            <div style="display: flex; justify-content: space-between; align-items: center; border-top: 1px solid rgba(255,255,255,0.08); padding-top: 14px;">
                <span style="font-weight: 800; color: #10b981; font-size: 1.15rem;">R ${item.price.toFixed(2)}</span>
                <button class="btn-primary" onclick="dispatchOrderToPhone('${item.title}', ${item.price})">Acquire Solution</button>
            </div>
        `;
        container.appendChild(card);
    });
}

function dispatchOrderToPhone(title, price) {
    // Construct direct order message routed to your WhatsApp / SMS gateway endpoint
    let message = `🔔 *NEW NOLLIES ORDER* 🔔\n\n*Product:* ${title}\n*Price:* R ${price.toFixed(2)}\n\n_Please process this order._`;
    let encodedMessage = encodeURIComponent(message);
    
    // Direct WhatsApp Business API URL configured for 0625873479 (+27 62 587 3479)
    let waUrl = `https://wa.me/${OWNER_PHONE}?text=${encodedMessage}`;
    
    // Open order dispatch window
    window.open(waUrl, '_blank');
    
    if (typeof showToast === 'function') {
        showToast(`📲 Order dispatched to your phone (0625873479)!`);
    }
}

document.addEventListener("DOMContentLoaded", renderOfferings);
