const PRODUCTS = [
    { 
        id: 'c1', cat: 'cereal', title: 'Cereal Hamper Package 1', price: 250, badge: '5 Items', 
        desc: 'Jungle Oats 1kg, Future Life 500g, Kellogg\'s Noodles (5 Pks), Bokomo Corn Flakes 1kg, Weet-Bix 450g.',
        img: 'https://images.unsplash.com/photo-1517093788734-90fa7b733160?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1521483451571-9f5ce5f25d78?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'c2', cat: 'cereal', title: 'Cereal Hamper Package 2', price: 250, badge: '5 Items', 
        desc: 'Bokomo Corn Flakes 1kg, Happy Valley Rice Puffs, Juice 6x300ml, My Life Porridge, Noodles.',
        img: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1521483451571-9f5ce5f25d78?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'c3', cat: 'cereal', title: 'Cereal Hamper Package 3', price: 250, badge: '5 Items', 
        desc: 'Bokomo Weet-Bix 450g, Corn Flakes 1kg, Future Life 500g, Nutrifics 450g, Noodles.',
        img: 'https://images.unsplash.com/photo-1517093788734-90fa7b733160?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'c4', cat: 'cereal', title: 'Cereal Hamper Package 4', price: 250, badge: '5 Items', 
        desc: 'Bokomo Corn Flakes 1kg, Weet-Bix 450g, Juice 6x300ml, Future Life 500g, Nutrifics.',
        img: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'j1', cat: 'juice', title: 'Juices Africa (4L Bottle)', price: 160, badge: 'Makes 20L', 
        desc: 'Guava, Mixed Berry, Cocktail, Tropical Punch. High yield fruit concentrate.',
        img: 'https://images.unsplash.com/photo-1613478223719-2ab802602423?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1546171753-97d7676eefa0?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'p1', cat: 'perfume', title: 'M-Scents Premium Perfumes (40ml)', price: 120, badge: '40ml Luxury', 
        desc: 'Silver Sense, Red Dezire, White OUD, Blue Dezire, StallioN, Sky OUD, Gorgeous Girl, Wild Intense.',
        img: 'https://images.unsplash.com/photo-1523293182086-7651a899d37f?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1594035910387-fea47794261f?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'e1', cat: 'essentials', title: 'Fresh Bakery & Bread Daily Pack', price: 35, badge: 'Fresh Daily', 
        desc: 'Fresh white/brown loaf, butter rolls, and morning tea treats.',
        img: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1549931319-a545dcf3bc73?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'e2', cat: 'essentials', title: '5L Sunflower Oil + 5kg Maize Meal', price: 145, badge: 'Pantry Essential', 
        desc: 'Golden Sunflower Cooking Oil (5L) + Top Quality Maize Meal (5kg).',
        img: 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'e3', cat: 'essentials', title: 'Cleaning & Hygiene Household Bucket', price: 185, badge: 'Home Care', 
        desc: 'Dishwashing Liquid, Bleach, Washing Powder (2kg), and Floor Cleaner.',
        img: 'https://images.unsplash.com/photo-1585421514284-efb74c2b69ba?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1563453392212-326f5e854473?auto=format&fit=crop&w=500&q=80'
    },
    { 
        id: 'e4', cat: 'essentials', title: 'School & Office Stationery Starter Pack', price: 95, badge: 'School Pack', 
        desc: '4x Exercise Books, Pen Set, Pencils, Eraser, Glue, and 30cm Ruler.',
        img: 'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?auto=format&fit=crop&w=500&q=80',
        fallback: 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=500&q=80'
    }
];

let cart = JSON.parse(localStorage.getItem('nollies_cart') || '[]');
const deliveryFee = 30;
let salesChartInstance = null;

document.addEventListener('DOMContentLoaded', () => {
    renderProducts(PRODUCTS);
    updateCartUI();
    initCharts();
    fetchLiveTicker();

    if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register('/sw.js').catch(() => {});
    }
});

async function fetchLiveTicker() {
    try {
        const res = await fetch('/api/public-activity');
        const data = await res.json();
        const ticker = document.getElementById('live-ticker');
        if (data.recent_orders && data.recent_orders.length > 0) {
            const latest = data.recent_orders[0];
            ticker.innerHTML = `💎 eNanda Activity: <strong>${latest.name}</strong> ordered ${latest.items_count} item(s) (Total: R${latest.total}) | Fulfilled: ${data.total_fulfilled}`;
        } else {
            ticker.innerHTML = `💎 eNanda Modern Silver Hub Active | Flat R30 Delivery`;
        }
    } catch (e) {
        document.getElementById('live-ticker').innerHTML = `💎 eNanda Modern Silver Hub Operational & Secure`;
    }
}

function showToast(message) {
    const toast = document.getElementById('toast');
    toast.innerText = message;
    toast.classList.remove('translate-y-24', 'opacity-0');
    setTimeout(() => {
        toast.classList.add('translate-y-24', 'opacity-0');
    }, 2500);
}

function triggerInstall() {
    const modal = document.getElementById('install-modal');
    if (modal) {
        modal.classList.remove('hidden');
        modal.classList.add('flex');
    }
}

function closeInstallModal() {
    const modal = document.getElementById('install-modal');
    if (modal) {
        modal.classList.add('hidden');
        modal.classList.remove('flex');
    }
}

function openProductModal(title, price, desc, img, fallback) {
    document.getElementById('modal-title').innerText = title;
    document.getElementById('modal-price').innerText = `R ${price.toFixed(2)}`;
    document.getElementById('modal-desc').innerText = desc;
    const modalImg = document.getElementById('modal-img');
    modalImg.src = img;
    modalImg.onerror = () => { modalImg.src = fallback; };
    
    const addBtn = document.getElementById('modal-add-btn');
    addBtn.onclick = () => {
        addToCart(title, price);
        closeProductModal();
    };

    const modal = document.getElementById('product-modal');
    modal.classList.remove('hidden');
    modal.classList.add('flex');
}

function closeProductModal() {
    const modal = document.getElementById('product-modal');
    modal.classList.add('hidden');
    modal.classList.remove('flex');
}

function submitSurvey() {
    const comment = document.getElementById('survey-comment').value;
    if (!comment) return alert('Please enter your feedback comment!');
    showToast('Thank you for your feedback!');
    document.getElementById('survey-comment').value = '';
}

function renderProducts(items) {
    const container = document.getElementById('product-list');
    if (!container) return;
    container.innerHTML = items.map(p => `
        <div class="product-card bg-glass rounded-3xl border silver-border shadow-xl overflow-hidden flex flex-col justify-between transition-all duration-300 hover:border-slate-400" data-cat="${p.cat}">
            <div onclick="openProductModal('${p.title}', ${p.price}, '${p.desc.replace(/'/g, "\\'")}', '${p.img}', '${p.fallback}')" class="cursor-pointer">
                <div class="h-44 overflow-hidden relative bg-slate-950 flex items-center justify-center">
                    <img src="${p.img}" alt="${p.title}" class="w-full h-full object-cover hover:scale-105 transition-transform duration-500" onerror="this.src='${p.fallback}'">
                    <span class="absolute top-3 left-3 silver-gradient text-slate-950 text-[10px] font-extrabold px-3 py-1 rounded-full uppercase shadow">${p.badge}</span>
                </div>
                <div class="p-4">
                    <h3 class="text-sm font-extrabold text-white mb-1 hover:text-slate-300 transition-colors">${p.title}</h3>
                    <p class="text-[11px] text-slate-300 line-clamp-2 font-medium">${p.desc}</p>
                </div>
            </div>
            <div class="p-4 pt-0 flex justify-between items-center">
                <span class="text-base font-black silver-text">R ${p.price.toFixed(2)}</span>
                <button onclick="addToCart('${p.title}', ${p.price})" class="press-effect silver-gradient text-slate-950 text-xs font-extrabold px-4 py-2.5 rounded-xl shadow-lg">+ Add</button>
            </div>
        </div>
    `).join('');
}

function addToCart(title, price) {
    cart.push({ title, price });
    localStorage.setItem('nollies_cart', JSON.stringify(cart));
    updateCartUI();
    showToast(`Added ${title} to cart!`);
}

function updateCartUI() {
    const badge = document.getElementById('cart-count');
    if (badge) badge.innerText = cart.length;
    const container = document.getElementById('cart-items');
    if (!container) return;
    container.innerHTML = '';

    let subtotal = 0;
    cart.forEach((item, index) => {
        subtotal += item.price;
        container.innerHTML += `
            <div class="flex justify-between items-center bg-slate-900/90 p-3 rounded-2xl border silver-border text-slate-200">
                <div>
                    <div class="font-extrabold text-white">${item.title}</div>
                    <div class="text-slate-400 text-[11px] font-semibold">R ${item.price.toFixed(2)}</div>
                </div>
                <button onclick="removeFromCart(${index})" class="press-effect text-red-400 font-bold bg-slate-800 w-7 h-7 rounded-full flex items-center justify-center hover:bg-slate-700">✕</button>
            </div>
        `;
    });

    const grandTotal = cart.length > 0 ? subtotal + deliveryFee : 0;
    const totalEl = document.getElementById('cart-total');
    if (totalEl) totalEl.innerText = `R ${grandTotal.toFixed(2)}`;
}

function removeFromCart(index) {
    cart.splice(index, 1);
    localStorage.setItem('nollies_cart', JSON.stringify(cart));
    updateCartUI();
    showToast('Item removed from cart.');
}

function toggleCart() {
    const modal = document.getElementById('cart-modal');
    if (modal) {
        modal.classList.toggle('hidden');
        modal.classList.toggle('flex');
    }
}

function switchTab(tabId, btn) {
    document.querySelectorAll('.tab-btn').forEach(b => {
        b.classList.remove('silver-gradient', 'text-slate-950', 'font-extrabold', 'shadow-md');
        b.classList.add('text-slate-400', 'font-semibold');
    });
    document.querySelectorAll('.tab-content').forEach(c => c.classList.add('hidden'));

    if (btn) {
        btn.classList.add('silver-gradient', 'text-slate-950', 'font-extrabold', 'shadow-md');
        btn.classList.remove('text-slate-400', 'font-semibold');
    }
    const tabTarget = document.getElementById(`tab-${tabId}`);
    if (tabTarget) tabTarget.classList.remove('hidden');

    if (tabId === 'analytics') {
        setTimeout(updateCharts, 100);
    }
}

function filterProducts() {
    const query = document.getElementById('search-input').value.toLowerCase();
    const filtered = PRODUCTS.filter(p => p.title.toLowerCase().includes(query) || p.desc.toLowerCase().includes(query));
    renderProducts(filtered);
}

function filterCat(cat, btn) {
    document.querySelectorAll('.cat-btn').forEach(b => {
        b.classList.remove('silver-gradient', 'text-slate-950', 'font-extrabold', 'shadow-md');
        b.classList.add('bg-slate-900', 'text-slate-300');
    });
    if (btn) btn.classList.add('silver-gradient', 'text-slate-950', 'font-extrabold', 'shadow-md');

    if (cat === 'all') {
        renderProducts(PRODUCTS);
    } else {
        renderProducts(PRODUCTS.filter(p => p.cat === cat));
    }
}

function initCharts() {
    const el = document.getElementById('salesChart');
    if (el) {
        const ctx = el.getContext('2d');
        salesChartInstance = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Cereal Hampers', 'Juices Africa', 'M-Scents Perfumes', 'Pantry Essentials'],
                datasets: [{
                    data: [45, 25, 20, 10],
                    backgroundColor: ['#e2e8f0', '#cbd5e1', '#94a3b8', '#64748b']
                }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });
    }
}

function updateCharts() {
    if (salesChartInstance) salesChartInstance.update();
}

function sendAiMessage() {
    const input = document.getElementById('chat-input');
    const box = document.getElementById('chat-box');
    if (!input || !box) return;
    const text = input.value.trim();
    if (!text) return;

    box.innerHTML += `<div class="text-right"><span class="inline-block silver-gradient text-slate-950 font-bold p-3 rounded-2xl shadow">${text}</span></div>`;

    setTimeout(() => {
        let reply = "We deliver across eNanda for a transparent R30 fee! Your cart is saved securely locally.";
        const lower = text.toLowerCase();
        if (lower.includes('offline') || lower.includes('install')) {
            reply = "Tap the '📲 Install' button at the top right to install Nollie's on your device home screen!";
        }
        box.innerHTML += `<div><span class="inline-block bg-slate-900 text-slate-200 border silver-border p-3 rounded-2xl shadow"><strong>Nollie AI:</strong> ${reply}</span></div>`;
        box.scrollTop = box.scrollHeight;
    }, 400);

    input.value = '';
}

async function checkoutWhatsApp() {
    if (cart.length === 0) return alert('Your cart is empty!');

    let subtotal = cart.reduce((sum, item) => sum + item.price, 0);
    let grandTotal = subtotal + deliveryFee;

    try {
        await fetch('/api/order', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                name: 'eNanda Modern PWA Customer',
                phone: 'WhatsApp User',
                total: grandTotal,
                items: cart
            })
        });
    } catch (e) {}

    let msg = "Hi Nollie's (eNanda Modern Hub), I would like to order:%0A%0A";
    cart.forEach(item => {
        msg += `• ${item.title} - R${item.price}%0A`;
    });
    msg += `%0ADelivery Fee: R30%0A*Total: R${grandTotal.toFixed(2)}*`;

    window.open(`https://wa.me/?text=${msg}`, '_blank');
}
