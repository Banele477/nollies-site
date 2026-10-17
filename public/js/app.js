const PRODUCTS = [
    { 
        id: 'c1', 
        cat: 'cereal', 
        title: 'Cereal Hamper Package 1', 
        price: 250, 
        badge: '5 Items', 
        desc: 'Jungle Oats 1kg, Future Life 500g, Noodles, Bokomo Corn Flakes 1kg, Weet-Bix 450g.', 
        img: 'https://images.unsplash.com/photo-1517093788734-90fa7b733160?auto=format&fit=crop&w=600&q=80', 
        fallback: 'https://images.unsplash.com/photo-1521483451571-9f5ce5f25d78?auto=format&fit=crop&w=600&q=80' 
    },
    { 
        id: 'c2', 
        cat: 'cereal', 
        title: 'Cereal Hamper Package 2', 
        price: 250, 
        badge: '5 Items', 
        desc: 'Bokomo Corn Flakes 1kg, Rice Puffs, Juice, Porridge, Noodles.', 
        img: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=600&q=80', 
        fallback: 'https://images.unsplash.com/photo-1521483451571?auto=format&fit=crop&w=600&q=80' 
    },
    { 
        id: 'c3', 
        cat: 'cereal', 
        title: 'Cereal Hamper Package 3', 
        price: 250, 
        badge: '5 Items', 
        desc: 'Bokomo Weet-Bix 450g, Corn Flakes 1kg, Future Life 500g, Nutrifics 450g, Noodles.', 
        img: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?auto=format&fit=crop&w=600&q=80', 
        fallback: 'https://images.unsplash.com/photo-1517093788734-90fa7b733160?auto=format&fit=crop&w=600&q=80' 
    },
    { 
        id: 'b1', 
        cat: 'essentials', 
        title: 'Family Bulk Grocery Hamper', 
        price: 380, 
        badge: 'Best Value', 
        desc: '10kg Maize Meal, 5L Sunflower Oil, 2kg White Sugar, 2kg Rice, 410g Baked Beans (x4).', 
        img: 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=600&q=80', 
        fallback: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=600&q=80' 
    },
    { 
        id: 'b2', 
        cat: 'essentials', 
        title: 'Weekend Braai & Pap Combo', 
        price: 295, 
        badge: 'Weekend Special', 
        desc: '5kg Iwisa Maize Meal, Braai Spice, Chakalaka (x3), Tomato & Onion Mix, 2L Soft Drink.', 
        img: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=600&q=80', 
        fallback: 'https://images.unsplash.com/photo-1549931319-a545dcf3bc73?auto=format&fit=crop&w=600&q=80' 
    },
    { 
        id: 'j1', 
        cat: 'juice', 
        title: 'Juices Africa (4L Bottle)', 
        price: 160, 
        badge: 'Makes 20L', 
        desc: 'Guava, Mixed Berry, Tropical Punch high yield fruit concentrate.', 
        img: 'https://images.unsplash.com/photo-1613478223719-2ab802602423?auto=format&fit=crop&w=600&q=80', 
        fallback: 'https://images.unsplash.com/photo-1546171753-97d7676eefa0?auto=format&fit=crop&w=600&q=80' 
    },
    { 
        id: 'p1', 
        cat: 'perfume', 
        title: 'M-Scents Perfumes (40ml)', 
        price: 120, 
        badge: '40ml Luxury', 
        desc: 'Silver Sense, Red Dezire, White OUD, Blue Dezire, StallioN.', 
        img: 'https://images.unsplash.com/photo-1523293182086-7651a899d37f?auto=format&fit=crop&w=600&q=80', 
        fallback: 'https://images.unsplash.com/photo-1594035910387-fea47794261f?auto=format&fit=crop&w=600&q=80' 
    },
    { 
        id: 'p2', 
        cat: 'perfume', 
        title: 'M-Scents Duo Gift Set (2x 40ml)', 
        price: 192, 
        badge: 'Save R48', 
        desc: 'Choose any two signature 40ml luxury fragrances in a gift presentation box.', 
        img: 'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?auto=format&fit=crop&w=600&q=80', 
        fallback: 'https://images.unsplash.com/photo-1523293182086-7651a899d37f?auto=format&fit=crop&w=600&q=80' 
    },
    { 
        id: 'e1', 
        cat: 'essentials', 
        title: 'Fresh Bakery Daily Pack', 
        price: 35, 
        badge: 'Fresh Daily', 
        desc: 'Fresh loaf, rolls, and morning treats.', 
        img: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=600&q=80', 
        fallback: 'https://images.unsplash.com/photo-1549931319-a545dcf3bc73?auto=format&fit=crop&w=600&q=80' 
    },
    { 
        id: 'e3', 
        cat: 'essentials', 
        title: 'Cleaning & Hygiene Household Bucket', 
        price: 185, 
        badge: 'Home Care', 
        desc: 'Dishwashing Liquid, Bleach, Washing Powder (2kg), and Floor Cleaner.', 
        img: 'https://images.unsplash.com/photo-1585421514284-efb74c2b69ba?auto=format&fit=crop&w=600&q=80', 
        fallback: 'https://images.unsplash.com/photo-1563453392212-326f5e854473?auto=format&fit=crop&w=600&q=80' 
    }
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
    window.renderProducts(PRODUCTS);
    window.renderBuilderOptions();
    window.updateCartUI();
    window.renderOrderHistory();
    window.initCharts();
});

window.showToast = function(msg) {
    const t = document.getElementById('toast');
    if (!t) return;
    t.innerText = msg;
    t.classList.remove('translate-y-24', 'opacity-0');
    setTimeout(() => t.classList.add('translate-y-24', 'opacity-0'), 2500);
}

window.renderProducts = function(items) {
    const c = document.getElementById('product-list');
    if (!c) return;
    c.innerHTML = items.map(p => `
        <div class="bg-glass rounded-3xl border silver-border shadow-xl overflow-hidden flex flex-col justify-between hover:border-slate-400 transition-all">
            <div onclick="openProductModal('${p.title.replace(/'/g, "\\'")}', ${p.price}, '${p.desc.replace(/'/g, "\\'")}', '${p.img}', '${p.fallback}')" class="cursor-pointer">
                <div class="h-48 overflow-hidden relative bg-slate-950 flex items-center justify-center">
                    <img src="${p.img}" alt="${p.title}" class="w-full h-full object-cover hover:scale-105 transition-transform duration-500" onerror="this.onerror=null;this.src='${p.fallback}';">
                    <span class="absolute top-3 left-3 silver-gradient text-slate-950 text-[10px] font-extrabold px-3 py-1 rounded-full uppercase shadow">${p.badge}</span>
                </div>
                <div class="p-4">
                    <h3 class="text-sm font-extrabold text-white mb-1">${p.title}</h3>
                    <p class="text-[11px] text-slate-300 line-clamp-2">${p.desc}</p>
                </div>
            </div>
            <div class="p-4 pt-0 flex justify-between items-center">
                <span class="text-base font-black silver-text">R ${p.price.toFixed(2)}</span>
                <button onclick="addToCart('${p.title.replace(/'/g, "\\'")}', ${p.price})" class="press-effect silver-gradient text-slate-950 text-xs font-extrabold px-4 py-2.5 rounded-xl shadow">+ Add</button>
            </div>
        </div>
    `).join('');
}

window.renderBuilderOptions = function() {
    const c = document.getElementById('builder-items');
    if (!c) return;
    c.innerHTML = HAMPER_OPTIONS.map((item) => `
        <label class="flex items-center justify-between bg-slate-900/90 p-3.5 rounded-2xl border silver-border cursor-pointer hover:border-slate-300 transition-all">
            <span class="font-bold text-white">${item.name} <span class="text-[10px] text-slate-400 font-normal">(${item.category})</span></span>
            <input type="checkbox" value="${item.name}" onchange="toggleHamperItem(this)" class="w-4 h-4 accent-slate-300 rounded cursor-pointer">
        </label>
    `).join('');
}

window.toggleHamperItem = function(checkbox) {
    if (checkbox.checked) {
        if (selectedHamperItems.length >= 5) {
            checkbox.checked = false;
            alert('You can only select up to 5 items for your custom hamper!');
            return;
        }
        selectedHamperItems.push(checkbox.value);
    } else {
        selectedHamperItems = selectedHamperItems.filter(i => i !== checkbox.value);
    }
    const countEl = document.getElementById('builder-count');
    if (countEl) countEl.innerText = selectedHamperItems.length;
}

window.addCustomHamper = function() {
    if (selectedHamperItems.length < 5) {
        alert('Please select exactly 5 items for your custom hamper!');
        return;
    }
    addToCart(`Custom Hamper (${selectedHamperItems.join(', ')})`, 250);
    switchTab('shop', document.querySelectorAll('.tab-btn')[1]);
}

window.addToCart = function(title, price) {
    cart.push({ title, price });
    localStorage.setItem('nollies_cart', JSON.stringify(cart));
    updateCartUI();
    showToast(`Added ${title} to cart!`);
}

window.updateCartUI = function() {
    const badge = document.getElementById('cart-count');
    if (badge) badge.innerText = cart.length;
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

    const subEl = document.getElementById('cart-subtotal');
    const discEl = document.getElementById('cart-discount');
    const totEl = document.getElementById('cart-total');
    if (subEl) subEl.innerText = `R ${sub.toFixed(2)}`;
    if (discEl) discEl.innerText = `-R ${discount.toFixed(2)}`;
    if (totEl) totEl.innerText = `R ${grand.toFixed(2)}`;
}

window.removeFromCart = function(idx) {
    cart.splice(idx, 1);
    localStorage.setItem('nollies_cart', JSON.stringify(cart));
    updateCartUI();
    showToast('Removed item.');
}

window.toggleCart = function() {
    const modal = document.getElementById('cart-modal');
    if (modal) {
        modal.classList.toggle('hidden');
        modal.classList.toggle('flex');
    }
}

window.applyPromo = function() {
    const promoInput = document.getElementById('promo-input');
    if (!promoInput) return;
    const code = promoInput.value.trim().toUpperCase();
    if (code === 'NOLLIE10') {
        discountPercent = 10;
        showToast('Promo code applied: 10% Off!');
        updateCartUI();
    } else {
        alert('Invalid promo code!');
    }
}

window.openProductModal = function(title, price, desc, img, fallback) {
    const mTitle = document.getElementById('modal-title');
    const mPrice = document.getElementById('modal-price');
    const mDesc = document.getElementById('modal-desc');
    const mImg = document.getElementById('modal-img');
    const mBtn = document.getElementById('modal-add-btn');

    if (mTitle) mTitle.innerText = title;
    if (mPrice) mPrice.innerText = `R ${price.toFixed(2)}`;
    if (mDesc) mDesc.innerText = desc;
    if (mImg) {
        mImg.src = img;
        mImg.onerror = function() { this.onerror=null; this.src=fallback; };
    }
    if (mBtn) {
        mBtn.onclick = () => {
            addToCart(title, price);
            closeProductModal();
        };
    }
    const modal = document.getElementById('product-modal');
    if (modal) {
        modal.classList.remove('hidden');
        modal.classList.add('flex');
    }
}

window.closeProductModal = function() {
    const modal = document.getElementById('product-modal');
    if (modal) {
        modal.classList.add('hidden');
        modal.classList.remove('flex');
    }
}

window.switchTab = function(id, btn) {
    document.querySelectorAll('.tab-btn').forEach(b => {
        b.classList.remove('silver-gradient', 'text-slate-950', 'font-extrabold');
        b.classList.add('text-slate-400', 'font-semibold');
    });
    document.querySelectorAll('.tab-content').forEach(c => c.classList.add('hidden'));
    if (btn) {
        btn.classList.add('silver-gradient', 'text-slate-950', 'font-extrabold');
        btn.classList.remove('text-slate-400', 'font-semibold');
    }
    const target = document.getElementById(`tab-${id}`);
    if (target) target.classList.remove('hidden');
    if (id === 'orders') renderOrderHistory();
}

window.filterProducts = function() {
    const searchInput = document.getElementById('search-input');
    if (!searchInput) return;
    const q = searchInput.value.toLowerCase();
    renderProducts(PRODUCTS.filter(p => p.title.toLowerCase().includes(q) || p.desc.toLowerCase().includes(q)));
}

window.filterCat = function(cat, btn) {
    document.querySelectorAll('.cat-btn').forEach(b => {
        b.classList.remove('silver-gradient', 'text-slate-950', 'font-extrabold');
        b.classList.add('bg-slate-900', 'text-slate-300');
    });
    if (btn) btn.classList.add('silver-gradient', 'text-slate-950', 'font-extrabold');
    if (cat === 'all') renderProducts(PRODUCTS);
    else renderProducts(PRODUCTS.filter(p => p.cat === cat));
}

window.renderOrderHistory = function() {
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

window.initCharts = function() {
    const el = document.getElementById('salesChart');
    if (el && window.Chart) {
        new Chart(el.getContext('2d'), {
            type: 'doughnut',
            data: { labels: ['Cereal', 'Juices', 'Perfumes', 'Pantry'], datasets: [{ data: [40, 30, 20, 10], backgroundColor: ['#e2e8f0', '#cbd5e1', '#94a3b8', '#64748b'] }] },
            options: { responsive: true, maintainAspectRatio: false }
        });
    }
}

window.sendAiMessage = function() {
    const input = document.getElementById('chat-input');
    const box = document.getElementById('chat-box');
    if (!input || !box || !input.value.trim()) return;
    const text = input.value;
    box.innerHTML += `<div class="text-right"><span class="inline-block silver-gradient text-slate-950 font-bold p-3 rounded-2xl">${text}</span></div>`;
    input.value = '';
    setTimeout(() => {
        box.innerHTML += `<div><span class="inline-block bg-slate-900 text-slate-200 border silver-border p-3 rounded-2xl"><strong>Nollie AI:</strong> We deliver across eNanda for R30! Check out our new high-res catalog images!</span></div>`;
        box.scrollTop = box.scrollHeight;
    }, 400);
}

window.checkoutWhatsApp = async function() {
    if (cart.length === 0) {
        alert('Your cart is empty!');
        return;
    }
    let sub = cart.reduce((s, i) => s + i.price, 0);
    let discount = (sub * discountPercent) / 100;
    let grand = (sub - discount) + deliveryFee;

    orders.push({
        date: new Date().toLocaleString(),
        total: grand,
        items: [...cart]
    });
    localStorage.setItem('nollies_orders', JSON.stringify(orders));

    if (typeof BackendBridge !== 'undefined') {
        await BackendBridge.syncOrder(cart, grand);
    }

    let msg = "Hi Nollie's (eNanda Modern Hub), I would like to order:%0A%0A";
    cart.forEach(i => msg += `• ${i.title} - R${i.price}%0A`);
    if (discountPercent > 0) msg += `%0ADiscount (${discountPercent}%): -R${discount.toFixed(2)}`;
    msg += `%0ADelivery Fee: R30%0A*Total: R${grand.toFixed(2)}*`;

    cart = [];
    localStorage.removeItem('nollies_cart');
    updateCartUI();
    toggleCart();

    window.open(`https://wa.me/?text=${msg}`, '_blank');
}

window.triggerInstall = function() {
    alert('Tap your browser settings menu (⋮ or Share) and select "Install App" or "Add to Home Screen".');
}
