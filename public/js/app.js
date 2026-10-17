const PRODUCTS = [
    { id: 'c1', cat: 'cereal', title: 'Cereal Hamper Package 1', price: 250, badge: '5 Items', desc: 'Jungle Oats 1kg, Future Life 500g, Noodles, Bokomo Corn Flakes 1kg, Weet-Bix 450g.', img: 'https://images.unsplash.com/photo-1517093788734-90fa7b733160?w=500&q=80', fallback: 'https://images.unsplash.com/photo-1521483451571-9f5ce5f25d78?w=500&q=80' },
    { id: 'c2', cat: 'cereal', title: 'Cereal Hamper Package 2', price: 250, badge: '5 Items', desc: 'Bokomo Corn Flakes 1kg, Rice Puffs, Juice, Porridge, Noodles.', img: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500&q=80', fallback: 'https://images.unsplash.com/photo-1521483451571?w=500&q=80' },
    { id: 'c3', cat: 'cereal', title: 'Cereal Hamper Package 3', price: 250, badge: '5 Items', desc: 'Bokomo Weet-Bix 450g, Corn Flakes 1kg, Future Life 500g, Nutrifics 450g, Noodles.', img: 'https://images.unsplash.com/photo-1517093788734-90fa7b733160?w=500&q=80', fallback: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=500&q=80' },
    { id: 'j1', cat: 'juice', title: 'Juices Africa (4L Bottle)', price: 160, badge: 'Makes 20L', desc: 'Guava, Mixed Berry, Tropical Punch high yield fruit concentrate.', img: 'https://images.unsplash.com/photo-1613478223719-2ab802602423?w=500&q=80', fallback: 'https://images.unsplash.com/photo-1546171753-97d7676eefa0?w=500&q=80' },
    { id: 'p1', cat: 'perfume', title: 'M-Scents Perfumes (40ml)', price: 120, badge: '40ml Luxury', desc: 'Silver Sense, Red Dezire, White OUD, Blue Dezire, StallioN.', img: 'https://images.unsplash.com/photo-1523293182086-7651a899d37f?w=500&q=80', fallback: 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=500&q=80' },
    { id: 'e1', cat: 'essentials', title: 'Fresh Bakery Daily Pack', price: 35, badge: 'Fresh Daily', desc: 'Fresh loaf, rolls, and morning treats.', img: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=500&q=80', fallback: 'https://images.unsplash.com/photo-1549931319-a545dcf3bc73?w=500&q=80' },
    { id: 'e2', cat: 'essentials', title: 'Sunflower Oil + Maize Meal', price: 145, badge: 'Essential', desc: '5L Cooking Oil + 5kg Top Quality Maize Meal.', img: 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=500&q=80', fallback: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500&q=80' },
    { id: 'e3', cat: 'essentials', title: 'Cleaning & Hygiene Household Bucket', price: 185, badge: 'Home Care', desc: 'Dishwashing Liquid, Bleach, Washing Powder (2kg), and Floor Cleaner.', img: 'https://images.unsplash.com/photo-1585421514284-efb74c2b69ba?w=500&q=80', fallback: 'https://images.unsplash.com/photo-1563453392212-326f5e854473?w=500&q=80' }
];

const HAMPER_OPTIONS = [
    { name: 'Jungle Oats 1kg', category: 'Cereal' },
    { name: 'Future Life 500g', category: 'Cereal' },
    { name: 'Bokomo Corn Flakes 1kg', category: 'Cereal' },
    { name: 'Weet-Bix 450g', category: 'Cereal' },
    { name: 'Nutrifics 450g', category: 'Cereal' },
    { name: 'Happy Valley Rice Puffs', category: 'Cereal' },
    { name: 'Kellogg\'s Noodles (5 Pack)', category: 'Snacks' },
    { name: 'Juice Concentrate 300ml', category: 'Beverage' }
];

let cart = JSON.parse(localStorage.getItem('nollies_cart') || '[]');
let orders = JSON.parse(localStorage.getItem('nollies_orders') || '[]');
const deliveryFee = 30;
let discountPercent = 0;
let selectedHamperItems = [];

document.addEventListener('DOMContentLoaded', () => {
    renderProducts(PRODUCTS);
    renderBuilderOptions();
    updateCartUI();
    renderOrderHistory();
    initCharts();
});

function showToast(msg) {
    const t = document.getElementById('toast');
    t.innerText = msg;
    t.classList.remove('translate-y-24', 'opacity-0');
    setTimeout(() => t.classList.add('translate-y-24', 'opacity-0'), 2500);
}

function renderProducts(items) {
    const c = document.getElementById('product-list');
    if (!c) return;
    c.innerHTML = items.map(p => `
        <div class="bg-glass rounded-3xl border silver-border shadow-xl overflow-hidden flex flex-col justify-between transition-all duration-300 hover:scale-[1.02]">
            <div onclick="openProductModal('${p.title}', ${p.price}, '${p.desc.replace(/'/g, "\\'")}', '${p.img}', '${p.fallback}')" class="cursor-pointer">
                <div class="h-44 overflow-hidden relative bg-slate-950 flex items-center justify-center">
                    <img src="${p.img}" alt="${p.title}" class="w-full h-full object-cover hover:scale-110 transition-transform duration-500" onerror="this.src='${p.fallback}'">
                    <span class="absolute top-3 left-3 silver-gradient text-slate-950 text-[10px] font-extrabold px-3 py-1 rounded-full uppercase shadow">${p.badge}</span>
                </div>
                <div class="p-4">
                    <h3 class="text-sm font-extrabold text-white mb-1">${p.title}</h3>
                    <p class="text-[11px] text-slate-300 line-clamp-2">${p.desc}</p>
                </div>
            </div>
            <div class="p-4 pt-0 flex justify-between items-center">
                <span class="text-base font-black silver-text">R ${p.price.toFixed(2)}</span>
                <button onclick="addToCart('${p.title}', ${p.price})" class="press-effect silver-gradient text-slate-950 text-xs font-extrabold px-4 py-2.5 rounded-xl shadow">+ Add</button>
            </div>
        </div>
    `).join('');
}

function renderBuilderOptions() {
    const c = document.getElementById('builder-items');
    if (!c) return;
    c.innerHTML = HAMPER_OPTIONS.map((item, idx) => `
        <label class="flex items-center justify-between bg-slate-900/90 p-3 rounded-2xl border silver-border cursor-pointer hover:border-slate-300 transition-all">
            <span class="font-bold text-white">${item.name} <span class="text-[10px] text-slate-400 font-normal">(${item.category})</span></span>
            <input type="checkbox" value="${item.name}" onchange="toggleHamperItem(this)" class="w-4 h-4 accent-slate-300 rounded cursor-pointer">
        </label>
    `).join('');
}

function toggleHamperItem(checkbox) {
    if (checkbox.checked) {
        if (selectedHamperItems.length >= 5) {
            checkbox.checked = false;
            return alert('You can only select up to 5 items for your custom hamper!');
        }
        selectedHamperItems.push(checkbox.value);
    } else {
        selectedHamperItems = selectedHamperItems.filter(i => i !== checkbox.value);
    }
    document.getElementById('builder-count').innerText = selectedHamperItems.length;
}

function addCustomHamper() {
    if (selectedHamperItems.length < 5) {
        return alert('Please select exactly 5 items for your custom hamper!');
    }
    addToCart(`Custom Hamper (${selectedHamperItems.join(', ')})`, 250);
    switchTab('shop', document.querySelectorAll('.tab-btn')[1]);
}

function addToCart(title, price) {
    cart.push({ title, price });
    localStorage.setItem('nollies_cart', JSON.stringify(cart));
    updateCartUI();
    showToast(`Added ${title} to cart!`);
}

function updateCartUI() {
    document.getElementById('cart-count').innerText = cart.length;
    const c = document.getElementById('cart-items');
    if (!c) return;
    c.innerHTML = '';
    let sub = 0;
    cart.forEach((i, idx) => {
        sub += i.price;
        c.innerHTML += `
            <div class="flex justify-between items-center bg-slate-900/90 p-3 rounded-2xl border silver-border text-slate-200">
                <div><div class="font-extrabold text-white">${i.title}</div><div class="text-slate-400 text-[11px]">R ${i.price.toFixed(2)}</div></div>
                <button onclick="removeFromCart(${idx})" class="text-red-400 font-bold bg-slate-800 w-7 h-7 rounded-full flex items-center justify-center">✕</button>
            </div>
        `;
    });

    let discount = (sub * discountPercent) / 100;
    let grand = cart.length > 0 ? (sub - discount) + deliveryFee : 0;

    document.getElementById('cart-subtotal').innerText = `R ${sub.toFixed(2)}`;
    document.getElementById('cart-discount').innerText = `-R ${discount.toFixed(2)}`;
    document.getElementById('cart-total').innerText = `R ${grand.toFixed(2)}`;
}

function removeFromCart(idx) {
    cart.splice(idx, 1);
    localStorage.setItem('nollies_cart', JSON.stringify(cart));
    updateCartUI();
    showToast('Removed item.');
}

function toggleCart() { document.getElementById('cart-modal').classList.toggle('hidden'); document.getElementById('cart-modal').classList.toggle('flex'); }

function applyPromo() {
    const code = document.getElementById('promo-input').value.trim().toUpperCase();
    if (code === 'NOLLIE10') {
        discountPercent = 10;
        showToast('Promo code applied: 10% Off!');
        updateCartUI();
    } else {
        alert('Invalid promo code!');
    }
}

function openProductModal(title, price, desc, img, fallback) {
    document.getElementById('modal-title').innerText = title;
    document.getElementById('modal-price').innerText = `R ${price.toFixed(2)}`;
    document.getElementById('modal-desc').innerText = desc;
    const mImg = document.getElementById('modal-img');
    mImg.src = img; mImg.onerror = () => { mImg.src = fallback; };
    document.getElementById('modal-add-btn').onclick = () => { addToCart(title, price); closeProductModal(); };
    document.getElementById('product-modal').classList.remove('hidden');
    document.getElementById('product-modal').classList.add('flex');
}

function closeProductModal() { document.getElementById('product-modal').classList.add('hidden'); document.getElementById('product-modal').classList.remove('flex'); }

function switchTab(id, btn) {
    document.querySelectorAll('.tab-btn').forEach(b => { b.classList.remove('silver-gradient', 'text-slate-950', 'font-extrabold'); b.classList.add('text-slate-400', 'font-semibold'); });
    document.querySelectorAll('.tab-content').forEach(c => c.classList.add('hidden'));
    if (btn) { btn.classList.add('silver-gradient', 'text-slate-950', 'font-extrabold'); btn.classList.remove('text-slate-400', 'font-semibold'); }
    document.getElementById(`tab-${id}`).classList.remove('hidden');
    if (id === 'orders') renderOrderHistory();
}

function filterProducts() {
    const q = document.getElementById('search-input').value.toLowerCase();
    renderProducts(PRODUCTS.filter(p => p.title.toLowerCase().includes(q) || p.desc.toLowerCase().includes(q)));
}

function filterCat(cat, btn) {
    document.querySelectorAll('.cat-btn').forEach(b => { b.classList.remove('silver-gradient', 'text-slate-950', 'font-extrabold'); b.classList.add('bg-slate-900', 'text-slate-300'); });
    if (btn) btn.classList.add('silver-gradient', 'text-slate-950', 'font-extrabold');
    if (cat === 'all') renderProducts(PRODUCTS);
    else renderProducts(PRODUCTS.filter(p => p.cat === cat));
}

function renderOrderHistory() {
    const c = document.getElementById('order-history-list');
    if (!c) return;
    if (orders.length === 0) {
        c.innerHTML = `<p class="text-slate-400 italic">No previous orders found.</p>`;
        return;
    }
    c.innerHTML = orders.map((o, idx) => `
        <div class="bg-slate-900/90 p-3.5 rounded-2xl border silver-border space-y-1">
            <div class="flex justify-between font-bold text-white"><span>Order #${idx + 1}</span><span class="silver-text">R ${o.total.toFixed(2)}</span></div>
            <div class="text-slate-400 text-[10px]">${o.date}</div>
            <div class="text-slate-300 text-[11px]">${o.items.length} item(s) ordered</div>
        </div>
    `).join('');
}

function initCharts() {
    const el = document.getElementById('salesChart');
    if (el) {
        new Chart(el.getContext('2d'), {
            type: 'doughnut',
            data: { labels: ['Cereal', 'Juices', 'Perfumes', 'Pantry'], datasets: [{ data: [40, 30, 20, 10], backgroundColor: ['#e2e8f0', '#cbd5e1', '#94a3b8', '#64748b'] }] },
            options: { responsive: true, maintainAspectRatio: false }
        });
    }
}

function sendAiMessage() {
    const input = document.getElementById('chat-input');
    const box = document.getElementById('chat-box');
    if (!input || !box || !input.value.trim()) return;
    box.innerHTML += `<div class="text-right"><span class="inline-block silver-gradient text-slate-950 font-bold p-3 rounded-2xl">${input.value}</span></div>`;
    setTimeout(() => {
        box.innerHTML += `<div><span class="inline-block bg-slate-900 text-slate-200 border silver-border p-3 rounded-2xl"><strong>Nollie AI:</strong> Try our new 'Build Hamper' feature! We deliver across eNanda for R30.</span></div>`;
        box.scrollTop = box.scrollHeight;
    }, 400);
    input.value = '';
}

function checkoutWhatsApp() {
    if (cart.length === 0) return alert('Your cart is empty!');
    let sub = cart.reduce((s, i) => s + i.price, 0);
    let discount = (sub * discountPercent) / 100;
    let grand = (sub - discount) + deliveryFee;

    orders.push({
        date: new Date().toLocaleString(),
        total: grand,
        items: [...cart]
    });
    localStorage.setItem('nollies_orders', JSON.stringify(orders));

    let msg = "Hi Nollie's (eNanda Ultimate Hub), I would like to order:%0A%0A";
    cart.forEach(i => msg += `• ${i.title} - R${i.price}%0A`);
    if (discountPercent > 0) msg += `%0ADiscount (${discountPercent}%): -R${discount.toFixed(2)}`;
    msg += `%0ADelivery Fee: R30%0A*Total: R${grand.toFixed(2)}*`;

    cart = [];
    localStorage.removeItem('nollies_cart');
    updateCartUI();
    toggleCart();

    window.open(`https://wa.me/?text=${msg}`, '_blank');
}

function triggerInstall() { alert('Tap your browser settings menu and select "Install App" or "Add to Home Screen".'); }
function closeInstallModal() {}
