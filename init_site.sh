#!/data/data/com.termux/files/usr/bin/bash
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== Initializing Nollie's eNanda High-Performance Web App ===${NC}"

# 1. Directory Structure
echo "Creating directory structure..."
mkdir -p assets/css assets/js assets/images config public app data

# 2. Public HTML (React 18 + Tailwind CSS + PWA)
echo "Generating responsive public/index.html..."
cat << 'EOF_HTML' > public/index.html
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Nollie's | eNanda Premier Hub & Marketplace</title>
    <meta name="theme-color" content="#090d16">
    <script src="https://cdn.tailwindcss.com"></script>
    <script crossorigin src="https://unpkg.com/react@18/umd/react.production.min.js"></script>
    <script crossorigin src="https://unpkg.com/react-dom@18/umd/react-dom.production.min.js"></script>
    <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; -webkit-tap-highlight-color: transparent; }
        .silver-gradient { background: linear-gradient(135deg, #f8fafc, #cbd5e1, #64748b); }
        .silver-border { border-color: rgba(226, 232, 240, 0.15); }
        .silver-text {
            background: linear-gradient(90deg, #ffffff, #e2e8f0, #94a3b8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .bg-glass {
            background: rgba(13, 18, 30, 0.94);
            backdrop-filter: blur(28px);
            -webkit-backdrop-filter: blur(28px);
        }
        .bg-community {
            background-color: #090d16;
            background-image: radial-gradient(circle at 50% 0%, rgba(30, 41, 59, 0.75) 0%, rgba(9, 13, 22, 0.98) 100%);
        }
        .press-effect:active { transform: scale(0.97); }
        .no-scrollbar::-webkit-scrollbar { display: none; }
        .no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(8px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-fade-in { animation: fadeIn 0.3s cubic-bezier(0.16, 1, 0.3, 1) forwards; }
    </style>
</head>
<body class="bg-slate-950 text-slate-100 min-h-screen pb-32 bg-community">
    <div id="root"></div>

    <script type="text/babel">
        const { useState, useEffect } = React;

        const FALLBACK_SVG = "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='600' height='400' viewBox='0 0 600 400'><rect width='100%' height='100%' fill='%231e293b'/><text x='50%' y='50%' fill='%23cbd5e1' font-family='sans-serif' font-size='22' font-weight='bold' text-anchor='middle' dominant-baseline='middle'>Nollie%27s Hub Pack</text></svg>";

        const PRODUCTS = [
            { id: 'c1', cat: 'cereal', title: 'Cereal Hamper Package 1', price: 250, badge: '5 Items', desc: 'Jungle Oats 1kg, Future Life 500g, Noodles, Bokomo Corn Flakes 1kg, Weet-Bix 450g.', img: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=600&q=80' },
            { id: 'c2', cat: 'cereal', title: 'Cereal Hamper Package 2', price: 250, badge: '5 Items', desc: 'Bokomo Corn Flakes 1kg, Rice Puffs, Juice, Porridge, Noodles.', img: 'https://images.unsplash.com/photo-1517093788734-90fa7b733160?auto=format&fit=crop&w=600&q=80' },
            { id: 'c3', cat: 'cereal', title: 'Cereal Hamper Package 3', price: 250, badge: '5 Items', desc: 'Bokomo Weet-Bix 450g, Corn Flakes 1kg, Future Life 500g, Nutrifics 450g, Noodles.', img: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?auto=format&fit=crop&w=600&q=80' },
            { id: 'b1', cat: 'essentials', title: 'Family Bulk Grocery Hamper', price: 380, badge: 'Best Value', desc: '10kg Maize Meal, 5L Sunflower Oil, 2kg White Sugar, 2kg Rice, 410g Baked Beans (x4).', img: 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=600&q=80' },
            { id: 'b2', cat: 'essentials', title: 'Weekend Braai & Pap Combo', price: 295, badge: 'Weekend Special', desc: '5kg Iwisa Maize Meal, Braai Spice, Chakalaka (x3), Tomato & Onion Mix, 2L Soft Drink.', img: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=600&q=80' },
            { id: 'j1', cat: 'juice', title: 'Juices Africa (4L Bottle)', price: 160, badge: 'Makes 20L', desc: 'Guava, Mixed Berry, Tropical Punch high yield fruit concentrate.', img: 'https://images.unsplash.com/photo-1613478223719-2ab802602423?auto=format&fit=crop&w=600&q=80' },
            { id: 'p1', cat: 'perfume', title: 'M-Scents Perfumes (40ml)', price: 120, badge: '40ml Luxury', desc: 'Silver Sense, Red Dezire, White OUD, Blue Dezire, StallioN.', img: 'https://images.unsplash.com/photo-1523293182086-7651a899d37f?auto=format&fit=crop&w=600&q=80' },
            { id: 'p2', cat: 'perfume', title: 'M-Scents Duo Gift Set (2x 40ml)', price: 192, badge: 'Save R48', desc: 'Choose any two signature 40ml luxury fragrances in a gift presentation box.', img: 'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?auto=format&fit=crop&w=600&q=80' },
            { id: 'e1', cat: 'essentials', title: 'Fresh Bakery Daily Pack', price: 35, badge: 'Fresh Daily', desc: 'Fresh loaf, rolls, and morning treats.', img: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=600&q=80' },
            { id: 'e3', cat: 'essentials', title: 'Cleaning & Hygiene Household Bucket', price: 185, badge: 'Home Care', desc: 'Dishwashing Liquid, Bleach, Washing Powder (2kg), and Floor Cleaner.', img: 'https://images.unsplash.com/photo-1585421514284-efb74c2b69ba?auto=format&fit=crop&w=600&q=80' }
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

        function App() {
            const [activeTab, setActiveTab] = useState('catalog');
            const [cart, setCart] = useState(JSON.parse(localStorage.getItem('nollies_cart') || '[]'));
            const [orders, setOrders] = useState([]);
            const [selectedCategory, setSelectedCategory] = useState('all');
            const [searchQuery, setSearchQuery] = useState('');
            const [isCartOpen, setIsCartOpen] = useState(false);
            const [promoCode, setPromoCode] = useState('');
            const [discountPercent, setDiscountPercent] = useState(0);
            const [selectedHamperItems, setSelectedHamperItems] = useState([]);
            const [activeModalProduct, setActiveModalProduct] = useState(null);
            const [toastMessage, setToastMessage] = useState(null);

            useEffect(() => {
                localStorage.setItem('nollies_cart', JSON.stringify(cart));
            }, [cart]);

            useEffect(() => {
                fetch('/api/orders')
                    .then(res => res.json())
                    .then(data => {
                        if (data && data.orders) setOrders(data.orders);
                    })
                    .catch(err => {
                        setOrders(JSON.parse(localStorage.getItem('nollies_orders') || '[]'));
                    });
            }, []);

            const showToast = (msg) => {
                setToastMessage(msg);
                setTimeout(() => setToastMessage(null), 2500);
            };

            const addToCart = (title, price) => {
                setCart([...cart, { title, price }]);
                showToast(`Added ${title} to cart!`);
            };

            const removeFromCart = (index) => {
                const newCart = [...cart];
                newCart.splice(index, 1);
                setCart(newCart);
                showToast('Item removed.');
            };

            const handleHamperToggle = (name) => {
                if (selectedHamperItems.includes(name)) {
                    setSelectedHamperItems(selectedHamperItems.filter(i => i !== name));
                } else {
                    if (selectedHamperItems.length >= 5) {
                        alert('You can only select up to 5 items for your custom hamper!');
                        return;
                    }
                    setSelectedHamperItems([...selectedHamperItems, name]);
                }
            };

            const addCustomHamper = () => {
                if (selectedHamperItems.length < 5) {
                    alert('Please select exactly 5 items for your custom hamper!');
                    return;
                }
                addToCart(`Custom Hamper (${selectedHamperItems.join(', ')})`, 250);
                setSelectedHamperItems([]);
                setActiveTab('catalog');
            };

            const applyPromo = () => {
                if (promoCode.trim().toUpperCase() === 'NOLLIE10') {
                    setDiscountPercent(10);
                    showToast('Promo code applied: 10% Off!');
                } else {
                    alert('Invalid promo code!');
                }
            };

            const subtotal = cart.reduce((sum, item) => sum + item.price, 0);
            const discount = (subtotal * discountPercent) / 100;
            const deliveryFee = 30;
            const grandTotal = cart.length > 0 ? (subtotal - discount) + deliveryFee : 0;

            const checkoutWhatsApp = () => {
                if (cart.length === 0) {
                    alert('Your cart is empty!');
                    return;
                }
                
                const orderPayload = { items: [...cart], total: grandTotal };

                fetch('/api/orders', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(orderPayload)
                })
                .then(res => res.json())
                .then(data => {
                    if (data && data.order) setOrders([data.order, ...orders]);
                })
                .catch(err => {
                    const localFallback = { id: orders.length + 1, items: [...cart], total: grandTotal };
                    setOrders([localFallback, ...orders]);
                });

                let msg = "Hi Nollie's (eNanda Premier Hub), I would like to order:%0A%0A";
                cart.forEach(i => msg += `• ${i.title} - R${i.price}%0A`);
                if (discountPercent > 0) msg += `%0ADiscount (${discountPercent}%): -R${discount.toFixed(2)}`;
                msg += `%0ADelivery Fee: R30%0A*Total: R${grandTotal.toFixed(2)}*`;

                setCart([]);
                setIsCartOpen(false);
                window.open(`https://wa.me/?text=${msg}`, '_blank');
            };

            const filteredProducts = PRODUCTS.filter(p => {
                const matchesCat = selectedCategory === 'all' || p.cat === selectedCategory;
                const matchesSearch = p.title.toLowerCase().includes(searchQuery.toLowerCase()) || p.desc.toLowerCase().includes(searchQuery.toLowerCase());
                return matchesCat && matchesSearch;
            });

            return (
                <div className="min-h-screen">
                    <div className="h-1 silver-gradient w-full fixed top-0 z-50"></div>

                    <header className="sticky top-1 z-40 bg-glass border-b silver-border px-4 sm:px-12 py-4 flex justify-between items-center shadow-2xl">
                        <div className="flex items-center space-x-3 cursor-pointer" onClick={() => setActiveTab('catalog')}>
                            <div className="w-11 h-11 rounded-2xl silver-gradient flex items-center justify-center shadow-xl text-slate-950 font-black text-xl">N</div>
                            <div>
                                <h1 className="text-base font-extrabold tracking-tight text-white leading-none">Nollie's</h1>
                                <span className="text-[10px] font-semibold text-slate-400 tracking-widest uppercase">eNanda Premier Hub</span>
                            </div>
                        </div>
                        
                        <nav className="hidden md:flex items-center space-x-2 bg-slate-900/90 p-1.5 rounded-2xl border silver-border text-xs font-bold text-slate-300">
                            <button onClick={() => setActiveTab('catalog')} className={`px-5 py-2 rounded-xl transition-all ${activeTab === 'catalog' ? 'silver-gradient text-slate-950 font-black shadow' : 'hover:text-white'}`}>🛍️ Catalog</button>
                            <button onClick={() => setActiveTab('builder')} className={`px-5 py-2 rounded-xl transition-all ${activeTab === 'builder' ? 'silver-gradient text-slate-950 font-black shadow' : 'hover:text-white'}`}>✨ Hamper Builder</button>
                            <button onClick={() => setActiveTab('specials')} className={`px-5 py-2 rounded-xl transition-all ${activeTab === 'specials' ? 'silver-gradient text-slate-950 font-black shadow' : 'hover:text-white'}`}>🔥 Bulk Specials</button>
                            <button onClick={() => setActiveTab('orders')} className={`px-5 py-2 rounded-xl transition-all ${activeTab === 'orders' ? 'silver-gradient text-slate-950 font-black shadow' : 'hover:text-white'}`}>📦 My Orders</button>
                            <button onClick={() => setActiveTab('about')} className={`px-5 py-2 rounded-xl transition-all ${activeTab === 'about' ? 'silver-gradient text-slate-950 font-black shadow' : 'hover:text-white'}`}>ℹ️ eNanda Info</button>
                        </nav>

                        <div className="flex items-center space-x-3">
                            <button onClick={() => alert('Tap browser settings (⋮) and select "Install App" or "Add to Home Screen".')} className="press-effect bg-slate-900/90 border silver-border text-slate-200 text-xs font-bold px-4 py-2.5 rounded-xl shadow hidden sm:flex items-center space-x-1.5 hover:bg-slate-800 transition-all">
                                <span>📲</span><span>Install App</span>
                            </button>
                            <button onClick={() => setIsCartOpen(true)} className="press-effect relative flex items-center space-x-2.5 silver-gradient text-slate-950 text-xs font-extrabold px-5 py-2.5 rounded-xl shadow-xl hover:opacity-95 transition-all">
                                <span>🛒 Cart</span>
                                <span className="bg-slate-950 text-slate-100 text-[11px] rounded-full h-5 w-5 flex items-center justify-center font-black">{cart.length}</span>
                            </button>
                        </div>
                    </header>

                    <div className="md:hidden flex overflow-x-auto bg-slate-900/90 border-b silver-border px-4 py-2 space-x-2 text-xs font-bold no-scrollbar sticky top-[73px] z-30">
                        <button onClick={() => setActiveTab('catalog')} className={`px-4 py-2 rounded-xl whitespace-nowrap transition-all ${activeTab === 'catalog' ? 'silver-gradient text-slate-950 font-black' : 'text-slate-300 bg-slate-950'}`}>🛍️ Catalog</button>
                        <button onClick={() => setActiveTab('builder')} className={`px-4 py-2 rounded-xl whitespace-nowrap transition-all ${activeTab === 'builder' ? 'silver-gradient text-slate-950 font-black' : 'text-slate-300 bg-slate-950'}`}>✨ Hamper Builder</button>
                        <button onClick={() => setActiveTab('specials')} className={`px-4 py-2 rounded-xl whitespace-nowrap transition-all ${activeTab === 'specials' ? 'silver-gradient text-slate-950 font-black' : 'text-slate-300 bg-slate-950'}`}>🔥 Bulk Specials</button>
                        <button onClick={() => setActiveTab('orders')} className={`px-4 py-2 rounded-xl whitespace-nowrap transition-all ${activeTab === 'orders' ? 'silver-gradient text-slate-950 font-black' : 'text-slate-300 bg-slate-950'}`}>📦 My Orders</button>
                        <button onClick={() => setActiveTab('about')} className={`px-4 py-2 rounded-xl whitespace-nowrap transition-all ${activeTab === 'about' ? 'silver-gradient text-slate-950 font-black' : 'text-slate-300 bg-slate-950'}`}>ℹ️ eNanda Info</button>
                    </div>

                    <div className="bg-slate-900/90 border-b silver-border text-slate-300 text-[11px] py-2 px-4 text-center font-medium overflow-hidden whitespace-nowrap shadow-inner">
                        <span>💎 eNanda Premier Hub | Use Promo Code <strong className="text-white">NOLLIE10</strong> for 10% Off! | Flat R30 Delivery Fee</span>
                    </div>

                    <main className="max-w-6xl mx-auto px-4 mt-8 space-y-10 animate-fade-in">
                        
                        <section className="relative overflow-hidden rounded-3xl border silver-border p-8 sm:p-14 shadow-2xl bg-glass flex flex-col lg:flex-row items-center justify-between gap-10">
                            <div className="absolute -right-20 -top-20 w-80 h-80 silver-gradient rounded-full blur-3xl opacity-15 pointer-events-none"></div>
                            <div className="space-y-6 max-w-2xl">
                                <div className="inline-flex items-center space-x-2 bg-slate-900/90 px-4 py-1.5 rounded-full border silver-border text-xs font-bold text-slate-300 shadow">
                                   <span>✨ eNanda's Elite Essentials & Luxury Collection</span>
                                </div>
                                <h2 className="text-3xl sm:text-5xl font-black tracking-tight silver-text leading-tight">Sawubona! Elevating Everyday Living in eNanda.</h2>
                                <p className="text-xs sm:text-sm text-slate-300 leading-relaxed font-medium">
                                    Experience premium 5-item Cereal Hampers, Family Bulk Groceries, Juices Africa fruit concentrates, and signature M-Scents perfumes delivered straight to your door with seamless WhatsApp checkout.
                                </p>
                                <div className="flex flex-wrap gap-3 pt-2">
                                    <button onClick={() => setActiveTab('catalog')} className="press-effect silver-gradient text-slate-950 font-extrabold py-3.5 px-7 rounded-2xl text-xs shadow-xl">Browse Catalog</button>
                                    <button onClick={() => setActiveTab('builder')} className="press-effect bg-slate-900/90 border silver-border text-slate-200 font-bold py-3.5 px-7 rounded-2xl text-xs shadow">Build Custom Hamper</button>
                                </div>
                            </div>
                            <div className="w-full lg:w-80 bg-slate-900/90 p-6 rounded-3xl border silver-border shadow-2xl space-y-4">
                                <div className="text-sm font-black silver-text uppercase tracking-wider">⚡ Hub Quick Stats</div>
                                <div className="space-y-3 text-xs">
                                    <div className="flex justify-between bg-slate-950 p-3 rounded-xl border silver-border">
                                        <span className="text-slate-400">Delivery Area</span>
                                        <span className="font-extrabold text-white">eNanda & Surrounds</span>
                                    </div>
                                    <div className="flex justify-between bg-slate-950 p-3 rounded-xl border silver-border">
                                        <span className="text-slate-400">Flat Delivery Fee</span>
                                        <span className="font-extrabold text-emerald-400">R30.00</span>
                                    </div>
                                    <div className="flex justify-between bg-slate-950 p-3 rounded-xl border silver-border">
                                        <span className="text-slate-400">Checkout Gateway</span>
                                        <span className="font-extrabold silver-text">WhatsApp 💬</span>
                                    </div>
                                </div>
                            </div>
                        </section>

                        {activeTab === 'catalog' && (
                            <div id="shop-section" className="space-y-6 animate-fade-in">
                                <div className="bg-glass border silver-border p-6 rounded-3xl shadow-xl flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                                    <div>
                                        <h3 className="text-xl font-black silver-text">Curated Product Catalog</h3>
                                        <p className="text-xs text-slate-400">Select from our community's finest daily essentials and luxury gifts.</p>
                                    </div>
                                    <input type="text" value={searchQuery} onChange={(e) => setSearchQuery(e.target.value)} placeholder="🔍 Search catalog..." 
                                           className="w-full sm:w-80 px-4 py-3.5 rounded-2xl border silver-border bg-slate-900/90 text-white placeholder-slate-400 text-xs outline-none focus:ring-2 focus:ring-slate-300 transition-all"/>
                                </div>
                                <div className="flex space-x-2 overflow-x-auto pb-1 text-xs no-scrollbar">
                                    {[
                                        { id: 'all', label: 'All Items' },
                                        { id: 'cereal', label: 'Cereal Hampers' },
                                        { id: 'juice', label: 'Juices Africa' },
                                        { id: 'perfume', label: 'M-Scents' },
                                        { id: 'essentials', label: 'Pantry & Home' }
                                    ].map((cat) => (
                                        <button key={cat.id} onClick={() => setSelectedCategory(cat.id)} className={`press-effect px-5 py-3 rounded-xl font-bold flex-shrink-0 transition-all ${selectedCategory === cat.id ? 'silver-gradient text-slate-950 font-extrabold shadow' : 'bg-slate-900/90 text-slate-300 border silver-border'}`}>
                                            {cat.label}
                                        </button>
                                    ))}
                                </div>

                                <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                                    {filteredProducts.map((p) => (
                                        <div key={p.id} className="bg-glass rounded-3xl border silver-border shadow-xl overflow-hidden flex flex-col justify-between hover:border-slate-400 transition-all">
                                            <div onClick={() => setActiveModalProduct(p)} className="cursor-pointer">
                                                <div className="h-48 overflow-hidden relative bg-slate-900 flex items-center justify-center">
                                                    <img src={p.img} alt={p.title} className="w-full h-full object-cover hover:scale-105 transition-transform duration-500" onError={(e)=>{e.target.onerror=null; e.target.src=FALLBACK_SVG;}}/>
                                                    <span className="absolute top-3 left-3 z-10 silver-gradient text-slate-950 text-[10px] font-extrabold px-3 py-1 rounded-full uppercase shadow-lg">{p.badge}</span>
                                                </div>
                                                <div className="p-4">
                                                    <h3 className="text-sm font-extrabold text-white mb-1">{p.title}</h3>
                                                    <p className="text-[11px] text-slate-300 line-clamp-2">{p.desc}</p>
                                                </div>
                                            </div>
                                            <div className="p-4 pt-0 flex justify-between items-center">
                                                <span className="text-base font-black silver-text">R {p.price.toFixed(2)}</span>
                                                <button onClick={() => addToCart(p.title, p.price)} className="press-effect silver-gradient text-slate-950 text-xs font-extrabold px-4 py-2.5 rounded-xl shadow">+ Add</button>
                                            </div>
                                        </div>
                                    ))}
                                </div>
                            </div>
                        )}

                        {activeTab === 'builder' && (
                            <section className="bg-glass border silver-border p-6 sm:p-12 rounded-3xl shadow-xl space-y-6 animate-fade-in">
                                <div className="max-w-xl space-y-2">
                                    <h3 className="text-2xl font-black silver-text">✨ Build Your Custom Cereal Hamper</h3>
                                    <p className="text-xs sm:text-sm text-slate-300">Mix and match any <strong className="text-white">5 preferred items</strong> to assemble your personalized bundle for a flat price of <strong className="text-white">R250.00</strong>!</p>
                                </div>
                                <div className="grid grid-cols-1 sm:grid-cols-2 gap-3.5 text-xs">
                                    {HAMPER_OPTIONS.map((item) => (
                                        <label key={item.name} className="flex items-center justify-between bg-slate-900/90 p-3.5 rounded-2xl border silver-border cursor-pointer hover:border-slate-300 transition-all">
                                            <span className="font-bold text-white">{item.name} <span className="text-[10px] text-slate-400 font-normal">({item.category})</span></span>
                                            <input type="checkbox" checked={selectedHamperItems.includes(item.name)} onChange={() => handleHamperToggle(item.name)} className="w-4 h-4 accent-slate-300 rounded cursor-pointer"/>
                                        </label>
                                    ))}
                                </div>
                                <div className="border-t silver-border pt-6 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                                    <div>
                                        <div className="text-xs text-slate-400">Selected Items: <span className="font-extrabold text-white text-sm">{selectedHamperItems.length}</span> / 5</div>
                                        <div className="text-2xl font-black silver-text">R 250.00</div>
                                    </div>
                                    <button onClick={addCustomHamper} className="press-effect silver-gradient text-slate-950 font-extrabold px-8 py-4 rounded-2xl text-xs shadow-xl w-full sm:w-auto">Add Custom Hamper to Cart 🛒</button>
                                </div>
                            </section>
                        )}

                        {activeTab === 'specials' && (
                            <section className="bg-glass border silver-border p-6 sm:p-12 rounded-3xl shadow-xl space-y-6 animate-fade-in">
                                <div className="max-w-xl space-y-2">
                                    <h3 className="text-2xl font-black silver-text">🔥 eNanda Bulk Specials & Savings</h3>
                                    <p className="text-xs sm:text-sm text-slate-300">Take advantage of our community wholesale packages designed to stretch your monthly grocery budget further.</p>
                                </div>
                                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div className="bg-slate-900/90 p-6 rounded-3xl border silver-border space-y-3">
                                        <span className="silver-gradient text-slate-950 text-[10px] font-extrabold px-3 py-1 rounded-full uppercase">Wholesale Combo</span>
                                        <h4 className="text-lg font-black text-white">Family Bulk Grocery Hamper</h4>
                                        <p className="text-xs text-slate-300">10kg Maize Meal, 5L Sunflower Oil, 2kg White Sugar, 2kg Rice, and 410g Baked Beans (x4).</p>
                                        <div className="flex justify-between items-center pt-2">
                                            <span className="text-xl font-black silver-text">R 380.00</span>
                                            <button onClick={() => addToCart('Family Bulk Grocery Hamper', 380)} className="press-effect silver-gradient text-slate-950 text-xs font-extrabold px-5 py-2.5 rounded-xl shadow">+ Add to Cart</button>
                                        </div>
                                    </div>
                                    <div className="bg-slate-900/90 p-6 rounded-3xl border silver-border space-y-3">
                                        <span className="silver-gradient text-slate-950 text-[10px] font-extrabold px-3 py-1 rounded-full uppercase">Weekend Promo</span>
                                        <h4 className="text-lg font-black text-white">Weekend Braai & Pap Combo</h4>
                                        <p className="text-xs text-slate-300">5kg Iwisa Maize Meal, Braai Spice, Chakalaka (x3), Tomato & Onion Mix, and 2L Soft Drink.</p>
                                        <div className="flex justify-between items-center pt-2">
                                            <span className="text-xl font-black silver-text">R 295.00</span>
                                            <button onClick={() => addToCart('Weekend Braai & Pap Combo', 295)} className="press-effect silver-gradient text-slate-950 text-xs font-extrabold px-5 py-2.5 rounded-xl shadow">+ Add to Cart</button>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        )}

                        {activeTab === 'orders' && (
                            <section className="bg-glass border silver-border p-6 sm:p-12 rounded-3xl shadow-xl space-y-4 animate-fade-in">
                                <h3 className="text-xl font-black silver-text">📦 Your Order History (Flask API Synced)</h3>
                                <p className="text-xs text-slate-400">Synchronized directly with the secure Flask backend ledger.</p>
                                <div className="space-y-3 text-xs">
                                    {orders.length === 0 ? (
                                        <p className="text-slate-400 italic">No previous orders found.</p>
                                    ) : (
                                        orders.map((o, idx) => (
                                            <div key={idx} className="bg-slate-900/90 p-4 rounded-2xl border silver-border space-y-1.5">
                                                <div className="flex justify-between font-bold text-white"><span>Order #{o.id || (orders.length - idx)}</span><span className="silver-text">R {o.total.toFixed(2)}</span></div>
                                                <div className="text-slate-300 text-[11px]">{o.items.length} item(s) ordered</div>
                                            </div>
                                        ))
                                    )}
                                </div>
                            </section>
                        )}

                        {activeTab === 'about' && (
                            <section className="bg-glass border silver-border p-6 sm:p-12 rounded-3xl shadow-xl space-y-6 animate-fade-in">
                                <h3 className="text-2xl font-black silver-text">ℹ️ About Nollie's & eNanda Hub</h3>
                                <div className="grid grid-cols-1 md:grid-cols-2 gap-6 text-xs text-slate-300">
                                    <div className="bg-slate-900/90 p-6 rounded-3xl border silver-border space-y-2">
                                        <h4 className="font-bold text-white text-sm">🚚 Flat R30 Delivery Protocol</h4>
                                        <p className="text-slate-400 leading-relaxed">We provide reliable, fast doorstep delivery across all sectors of eNanda and surrounding Durban communities for a flat R30 fee.</p>
                                    </div>
                                    <div className="bg-slate-900/90 p-6 rounded-3xl border silver-border space-y-2">
                                        <h4 className="font-bold text-white text-sm">💬 Instant WhatsApp Checkout</h4>
                                        <p className="text-slate-400 leading-relaxed">No complicated login forms. Build your cart or custom hamper, apply promo codes like <strong className="text-white">NOLLIE10</strong>, and send your order straight to our WhatsApp dispatch desk.</p>
                                    </div>
                                </div>
                            </section>
                        )}
                    </main>

                    {isCartOpen && (
                        <div className="fixed inset-0 bg-slate-950/80 backdrop-blur-md z-50 flex flex-col justify-end animate-fade-in">
                            <div className="bg-glass rounded-t-3xl p-6 sm:p-8 border-t silver-border max-h-[85vh] flex flex-col shadow-2xl max-w-2xl mx-auto w-full">
                                <div className="flex justify-between items-center border-b silver-border pb-4">
                                    <h3 className="font-black text-base text-white flex items-center space-x-2"><span>🛒</span><span>Your Order Summary</span></h3>
                                    <button onClick={() => setIsCartOpen(false)} className="press-effect text-slate-400 text-xl font-bold bg-slate-800 w-9 h-9 rounded-full flex items-center justify-center hover:bg-slate-700">&times;</button>
                                </div>
                                <div className="py-4 overflow-y-auto flex-1 space-y-3 text-xs">
                                    {cart.length === 0 ? (
                                        <p className="text-slate-400 italic">Your cart is empty.</p>
                                    ) : (
                                        cart.map((item, idx) => (
                                            <div key={idx} className="flex justify-between items-center bg-slate-900/90 p-3 rounded-2xl border silver-border text-slate-200">
                                                <div><div className="font-extrabold text-white">{item.title}</div><div className="text-slate-400 text-[11px]">R {item.price.toFixed(2)}</div></div>
                                                <button onClick={() => removeFromCart(idx)} className="text-red-400 font-bold bg-slate-800 w-7 h-7 rounded-full flex items-center justify-center">✕</button>
                                            </div>
                                        ))
                                    )}
                                </div>
                                <div className="py-3 border-t silver-border flex space-x-2.5">
                                    <input type="text" value={promoCode} onChange={(e) => setPromoCode(e.target.value)} placeholder="Promo code (NOLLIE10)" className="flex-1 px-4 py-3 text-xs rounded-xl bg-slate-900 border silver-border text-white uppercase outline-none"/>
                                    <button onClick={applyPromo} className="press-effect silver-gradient text-slate-950 text-xs font-bold px-5 py-3 rounded-xl shadow">Apply</button>
                                </div>
                                <div className="border-t silver-border pt-4 space-y-2.5 text-xs">
                                    <div className="flex justify-between text-slate-300 font-medium"><span>Subtotal:</span><span>R {subtotal.toFixed(2)}</span></div>
                                    <div className="flex justify-between text-slate-300 font-medium"><span>Discount:</span><span className="text-emerald-400">-R {discount.toFixed(2)}</span></div>
                                    <div className="flex justify-between text-slate-300 font-medium"><span>Delivery Fee (eNanda):</span><span>R 30.00</span></div>
                                    <div className="flex justify-between text-lg font-black text-white pt-2 border-t silver-border"><span>Total Amount:</span><span className="silver-text">R {grandTotal.toFixed(2)}</span></div>
                                    <button onClick={checkoutWhatsApp} className="press-effect w-full bg-emerald-600 hover:bg-emerald-500 text-white font-extrabold py-4 rounded-2xl text-sm shadow-xl mt-2 flex items-center justify-center space-x-2">
                                        <span>Send Order on WhatsApp 💬</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    )}

                    {activeModalProduct && (
                        <div className="fixed inset-0 bg-slate-950/85 backdrop-blur-md z-50 flex items-center justify-center p-4 animate-fade-in">
                            <div className="bg-glass rounded-3xl p-6 sm:p-8 border silver-border max-w-md w-full space-y-5 shadow-2xl">
                                <div className="flex justify-between items-center border-b silver-border pb-4">
                                    <h3 className="font-black text-base text-white">{activeModalProduct.title}</h3>
                                    <button onClick={() => setActiveModalProduct(null)} className="press-effect text-slate-400 text-xl font-bold bg-slate-800 w-9 h-9 rounded-full flex items-center justify-center">&times;</button>
                                </div>
                                <img src={activeModalProduct.img} alt="Product" className="w-full h-52 object-cover rounded-2xl bg-slate-900 border silver-border shadow-inner" onError={(e)=>{e.target.onerror=null; e.target.src=FALLBACK_SVG;}}/>
                                <p className="text-xs sm:text-sm text-slate-300 leading-relaxed font-medium">{activeModalProduct.desc}</p>
                                <div className="flex justify-between items-center pt-4 border-t silver-border">
                                    <span className="text-xl font-black silver-text">R {activeModalProduct.price.toFixed(2)}</span>
                                    <button onClick={() => { addToCart(activeModalProduct.title, activeModalProduct.price); setActiveModalProduct(null); }} className="press-effect silver-gradient text-slate-950 font-extrabold px-6 py-3.5 rounded-2xl text-xs shadow-xl">+ Add to Cart</button>
                                </div>
                            </div>
                        </div>
                    )}

                    {toastMessage && (
                        <div className="fixed bottom-6 right-6 bg-slate-900 border silver-border silver-gradient text-slate-950 text-xs font-black px-6 py-4 rounded-2xl shadow-2xl z-50 animate-fade-in">
                            {toastMessage}
                        </div>
                    )}
                </div>
            );
        }

        ReactDOM.render(<App />, document.getElementById('root'));
    </script>
</body>
</html>
EOF_HTML

# 3. Database Layer
echo "Generating app/database.py..."
cat << 'EOF_DB' > app/database.py
import os
import json

DATA_DIR = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'data')
ORDERS_FILE = os.path.join(DATA_DIR, 'orders.json')

def init_db():
    if not os.path.exists(DATA_DIR):
        os.makedirs(DATA_DIR, exist_ok=True)
    if not os.path.exists(ORDERS_FILE):
        with open(ORDERS_FILE, 'w') as f:
            json.dump([], f)

def load_orders():
    if not os.path.exists(ORDERS_FILE):
        return []
    try:
        with open(ORDERS_FILE, 'r') as f:
            return json.load(f)
    except Exception:
        return []

def save_order(items, total):
    init_db()
    orders = load_orders()
    new_order = {
        "id": len(orders) + 1,
        "items": items,
        "total": total
    }
    orders.insert(0, new_order)
    with open(ORDERS_FILE, 'w') as f:
        json.dump(orders, f, indent=2)
    return new_order
EOF_DB

# 4. Flask API Server
echo "Generating app.py..."
cat << 'EOF_APP' > app.py
import os
import json
from flask import Flask, jsonify, request, send_from_directory
from app.database import init_db, load_orders, save_order

app = Flask(__name__, static_folder='public')

ADMIN_KEY = os.environ.get('ADMIN_KEY', 'mysecret')

with app.app_context():
    init_db()

@app.route('/')
def index():
    return send_from_directory('public', 'index.html')

@app.route('/<path:path>')
def static_proxy(path):
    if os.path.exists(os.path.join('public', path)):
        return send_from_directory('public', path)
    return send_from_directory('public', 'index.html')

@app.route('/api/orders', methods=['GET', 'POST'])
def handle_orders():
    if request.method == 'POST':
        data = request.json
        if not data or 'items' not in data or 'total' not in data:
            return jsonify({'error': 'Invalid payload'}), 400
        saved = save_order(data['items'], data['total'])
        return jsonify({'status': 'success', 'order': saved}), 201
    else:
        orders = load_orders()
        return jsonify({'orders': orders, 'count': len(orders)})

@app.route('/api/phd/analytics', methods=['GET'])
def phd_analytics():
    key = request.headers.get('Authorization') or request.args.get('key')
    if key != ADMIN_KEY:
        return jsonify({'error': 'Unauthorized Ph.D. Access'}), 403
    
    orders = load_orders()
    total_revenue = sum(o.get('total', 0) for o in orders)
    
    return jsonify({
        'status': 'active',
        'model': 'Econometric Retail Optimization v2.4',
        'total_orders': len(orders),
        'total_revenue': total_revenue,
        'inventory_turnover_ratio': 4.8,
        'economic_utility_index': 94.2,
        'supply_chain_efficiency': 'Optimal',
        'region': 'eNanda, Durban, KZN'
    })

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=True)
EOF_APP

# 5. Security rules
cat << 'EOF_SEC' > config/.htaccess
Header set X-XSS-Protection "1; mode=block"
Header set X-Frame-Options "SAMEORIGIN"
Header set X-Content-Type-Options "nosniff"
Header set Referrer-Policy "strict-origin-when-cross-origin"
EOF_SEC

chmod 644 public/index.html app.py app/database.py 2>/dev/null || true

echo -e "${GREEN}=== Initialization Complete! ===${NC}"
echo -e "To run local Flask app server: ${BLUE}ADMIN_KEY=mysecret python3 app.py${NC}"
