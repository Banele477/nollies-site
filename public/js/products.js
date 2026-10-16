const realWorldGallery = [
    { id: "rw-1", title: "Urban Architecture & Tech", category: "Infrastructure", image: "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&auto=format&fit=crop&q=80", price: 550.00 },
    { id: "rw-2", title: "Smart Logistics Hub", category: "Operations", image: "https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=800&auto=format&fit=crop&q=80", price: 890.00 },
    { id: "rw-3", title: "Data & Systems Analytics", category: "Intelligence", image: "https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&auto=format&fit=crop&q=80", price: 1200.00 }
];

function sanitizeInput(str) {
    if (!str) return '';
    return str.replace(/[&<>"']/g, m => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#039;'}[m]));
}

function renderRealWorldSection() {
    let container = document.getElementById('real-world-grid');
    if (!container) {
        container = document.createElement('div');
        container.id = 'real-world-grid';
        container.style.cssText = "display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; padding: 25px; max-width: 1200px; margin: 0 auto;";
        document.body.appendChild(container);
    } else { container.innerHTML = ""; }

    realWorldGallery.forEach(item => {
        let card = document.createElement('div');
        card.className = 'product-card';
        card.innerHTML = `
            <img src="${item.image}" alt="${item.title}" style="width: 100%; height: 190px; object-fit: cover; border-radius: 10px; margin-bottom: 12px;">
            <span style="font-size: 0.75rem; text-transform: uppercase; color: #818cf8; font-weight: bold;">${item.category}</span>
            <h3 style="font-size: 1.15rem; margin: 6px 0 10px 0; color: #fff;">${item.title}</h3>
            <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 15px;">
                <span style="font-weight: bold; color: #10b981; font-size: 1.1rem;">R ${item.price.toFixed(2)}</span>
                <button onclick="alert('✨ Secured item: ${sanitizeInput(item.title)}')" style="background: #6366f1; color: white; border: none; padding: 8px 14px; border-radius: 6px; cursor: pointer;">Secure Item</button>
            </div>
        `;
        container.appendChild(card);
    });
}
document.addEventListener("DOMContentLoaded", renderRealWorldSection);
