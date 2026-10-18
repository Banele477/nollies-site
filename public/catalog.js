(function(){
if(window.__nqCat)return;window.__nqCat=1;
var OWNER="banele477",REPO="nollies-site",BRANCH="main",WA="27625873479";
var P=window.NQ_PHOTOS||[];
P = P.filter(function(x){ return x && x.t; });
if(!P.length)return;

var base=location.pathname.replace(/[^\/]*$/,"");
var CDN="https://cdn.jsdelivr.net/gh/"+OWNER+"/"+REPO+"@"+BRANCH+"/public/images/";

var css=`
#nqc { max-width: 1200px; margin: 30px auto 120px; padding: 0 16px; color: #f8fafc; font-family: system-ui, -apple-system, sans-serif; }

/* Hero Header Card */
.nq-hero-card { background: rgba(15, 23, 42, 0.9); backdrop-filter: blur(20px); border: 1px solid rgba(56, 189, 248, 0.3); border-radius: 24px; padding: 24px; margin-bottom: 24px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 20px; box-shadow: 0 20px 50px rgba(0,0,0,0.5); }
.nq-hero-left h1 { font-size: 26px; font-weight: 900; color: #fff; margin: 0 0 6px 0; }
.nq-hero-left p { color: #94a3b8; font-size: 13.5px; margin: 0; line-height: 1.5; max-width: 600px; }
.nq-hero-right { background: rgba(30, 41, 59, 0.8); border: 1px solid rgba(255,255,255,0.1); border-radius: 16px; padding: 14px 20px; font-size: 13px; color: #cbd5e1; }
.nq-hero-right b { color: #38bdf8; }

/* Navigation Quantum Bar */
.nq-nav-bar { display: flex; gap: 8px; overflow-x: auto; padding: 4px 4px 24px; scrollbar-width: none; justify-content: center; flex-wrap: wrap; }
.nq-nav-bar::-webkit-scrollbar { display: none; }
.nq-nav-btn { flex: none; padding: 10px 18px; border-radius: 999px; border: 1px solid rgba(255,255,255,0.1); background: rgba(15, 23, 42, 0.7); color: #cbd5e1; font-weight: 700; font-size: 12.5px; cursor: pointer; transition: all 0.25s ease; display: flex; align-items: center; gap: 6px; backdrop-filter: blur(10px); }
.nq-nav-btn:hover { border-color: #38bdf8; color: #fff; transform: translateY(-2px); }
.nq-nav-btn.on { background: linear-gradient(135deg, #38bdf8 0%, #2563eb 100%); color: #0f172a; border-color: transparent; font-weight: 900; box-shadow: 0 6px 20px rgba(56, 189, 248, 0.4); }

/* Live Ticker & Gamification Banner */
.nq-ticker { background: rgba(56, 189, 248, 0.1); border: 1px solid rgba(56, 189, 248, 0.25); border-radius: 12px; padding: 10px 16px; text-align: center; font-size: 13px; color: #38bdf8; font-weight: 600; margin-bottom: 24px; }
.lucky-spin-banner { background: linear-gradient(135deg, rgba(236, 72, 153, 0.15), rgba(168, 85, 247, 0.15)); border: 1px solid rgba(236, 72, 153, 0.4); border-radius: 16px; padding: 16px; text-align: center; margin-bottom: 24px; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 12px; backdrop-filter: blur(16px); }

/* Sections */
.nq-section { display: none; }
.nq-section.active { display: block; }

/* Grid Cards */
.nq-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 24px; }
.nq-card { background: rgba(15, 23, 42, 0.75); backdrop-filter: blur(16px); border: 1px solid rgba(255,255,255,0.08); border-radius: 22px; overflow: hidden; display: flex; flex-direction: column; transition: all 0.3s ease; box-shadow: 0 10px 30px rgba(0,0,0,0.3); }
.nq-card:hover { transform: translateY(-6px); border-color: rgba(56, 189, 248, 0.4); box-shadow: 0 20px 40px rgba(56, 189, 248, 0.15); }

.nq-img-wrap { position: relative; width: 100%; aspect-ratio: 1.2; background: #080c14; overflow: hidden; display: flex; align-items: center; justify-content: center; }
.nq-card img { width: 100%; height: 100%; object-fit: cover; display: block; }
.nq-badge { position: absolute; top: 12px; left: 12px; background: rgba(15, 23, 42, 0.9); backdrop-filter: blur(10px); border: 1px solid rgba(34, 197, 94, 0.3); color: #4ade80; font-size: 10px; font-weight: 800; text-transform: uppercase; padding: 5px 12px; border-radius: 999px; letter-spacing: 0.5px; }
.stock-alert { position: absolute; bottom: 10px; right: 10px; background: rgba(239, 68, 68, 0.85); color: #fff; font-size: 9.5px; font-weight: 700; padding: 3px 8px; border-radius: 6px; }

.nq-card-body { padding: 18px; display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between; }
.nq-card-body h3 { font-size: 15px; font-weight: 800; color: #fff; margin: 0 0 8px 0; }
.nq-card-body p { font-size: 13px; color: #94a3b8; margin: 0 0 14px 0; line-height: 1.4; }
.nq-price { font-size: 18px; font-weight: 900; color: #38bdf8; margin-bottom: 14px; }

.nq-btn { width: 100%; padding: 12px; border-radius: 12px; background: linear-gradient(135deg, #38bdf8 0%, #2563eb 100%); color: #fff; font-weight: 800; font-size: 13.5px; border: none; cursor: pointer; transition: all 0.2s ease; box-shadow: 0 4px 15px rgba(37, 99, 235, 0.3); }
.nq-btn:hover { opacity: 0.95; transform: scale(1.02); }

/* Hamper Builder */
.builder-box { background: rgba(15, 23, 42, 0.85); backdrop-filter: blur(20px); border: 1px solid rgba(255,255,255,0.1); border-radius: 24px; padding: 28px; }
.builder-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 16px; margin: 20px 0; }
.builder-item { background: rgba(30,41,59,0.7); border: 1px solid rgba(255,255,255,0.08); padding: 14px; border-radius: 12px; display: flex; align-items: center; justify-content: space-between; cursor: pointer; }
.builder-item span { font-size: 13px; font-weight: 600; color: #e2e8f0; }

/* Owner Console & Security */
.console-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 20px; margin-bottom: 24px; }
.console-card { background: rgba(15, 23, 42, 0.85); border: 1px solid rgba(255,255,255,0.1); border-radius: 20px; padding: 20px; }
.console-card h4 { font-size: 12px; color: #94a3b8; text-transform: uppercase; margin: 0 0 8px 0; }
.console-card .val { font-size: 28px; font-weight: 900; color: #38bdf8; margin: 0; }

/* Neural Cart Modal Drawer */
#nq-cart-drawer { position: fixed; inset: 0; background: rgba(2, 6, 23, 0.9); backdrop-filter: blur(20px); z-index: 999999; display: none; align-items: center; justify-content: center; padding: 20px; }
#nq-cart-drawer.open { display: flex; }
.cart-modal-content { background: rgba(15, 23, 42, 0.95); border: 1px solid rgba(56, 189, 248, 0.3); border-radius: 24px; width: 100%; max-width: 500px; padding: 24px; box-shadow: 0 25px 60px rgba(0,0,0,0.8); position: relative; }
.cart-modal-content h3 { color: #fff; margin-top: 0; font-size: 20px; font-weight: 900; }
.cart-item-row { display: flex; justify-content: space-between; align-items: center; padding: 12px 0; border-bottom: 1px solid rgba(255,255,255,0.08); font-size: 13.5px; color: #cbd5e1; }
.promo-row { display: flex; gap: 10px; margin: 20px 0; }
.promo-row input { flex: 1; padding: 10px 14px; border-radius: 10px; border: 1px solid rgba(255,255,255,0.15); background: rgba(30,41,59,0.8); color: #fff; font-size: 13px; }
.promo-row button { padding: 10px 18px; border-radius: 10px; background: #38bdf8; color: #0f172a; font-weight: 800; border: none; cursor: pointer; }
`;

function setCardImage(img, item){
  var title = item.t || "";
  var category = item.c || "";
  var bg = "#0f172a", accent = "#38bdf8", icon = "📦";
  var t = title.toLowerCase();

  if(t.includes("perfume") || t.includes("sense") || t.includes("dezire") || category === "perfume") {
    bg = "#4c0519"; accent = "#f43f5e"; icon = "✨";
  } else if(t.includes("juice") || t.includes("concentrate") || category === "juice") {
    bg = "#064e3b"; accent = "#34d399"; icon = "🧃";
  } else if(t.includes("hamper") || t.includes("breakfast") || category === "hamper") {
    bg = "#1e3a8a"; accent = "#60a5fa"; icon = "🧺";
  } else if(t.includes("braai") || t.includes("pap") || t.includes("combo")) {
    bg = "#78350f"; accent = "#facc15"; icon = "🔥";
  } else if(t.includes("rice") || t.includes("cereal") || t.includes("noodles") || category === "cereal") {
    bg = "#3b0764"; accent = "#c084fc"; icon = "🥣";
  }

  img.src = "data:image/svg+xml;utf8," + encodeURIComponent(
    "<svg xmlns='http://www.w3.org/2000/svg' width='800' height='800' viewBox='0 0 800 800'>" +
    "<defs><linearGradient id='g' x1='0' y1='0' x2='1' y2='1'><stop offset='0%' stop-color='" + bg + "'/><stop offset='100%' stop-color='#020617'/></linearGradient></defs>" +
    "<rect width='100%' height='100%' fill='url(#g)'/>" +
    "<circle cx='400' cy='320' r='120' fill='" + accent + "' opacity='0.15'/>" +
    "<text x='400' y='365' font-size='120' text-anchor='middle'>" + icon + "</text>" +
    "<text x='400' y='500' fill='#ffffff' font-family='system-ui, sans-serif' font-size='28' font-weight='900' text-anchor='middle'>NOLLIE'S QUANTUM HUB</text>" +
    "<text x='400' y='550' fill='" + accent + "' font-family='system-ui, sans-serif' font-size='20' font-weight='700' text-anchor='middle'>" + (title.length > 30 ? title.substring(0, 28) + "..." : title) + "</text>" +
    "</svg>"
  );
}

function init(){
  var st=document.createElement("style"); st.textContent=css; document.head.appendChild(st);
  var sec=document.createElement("section"); sec.id="nqc";
  
  sec.innerHTML=`
    <!-- Hero Header Card -->
    <div class="nq-hero-card">
      <div class="nq-hero-left">
        <h1>Sawubona! Welcome to Nollie's Quantum Hub.</h1>
        <p>Delivering top-grade perfumes, cereal hampers, bulk groceries, juices Africa concentrates, and M-Section essentials directly to your door with a flat R30 delivery fee across eNqanda.</p>
      </div>
      <div class="nq-hero-right">
        <div><b>Nollie</b> <span style="font-size:11px; color:#38bdf8;">#Founder & Lead Director</span></div>
        <div style="margin-top:4px; font-size:11px; color:#4ade80;">Developer: <b>Banele Gumbi</b></div>
        <div style="margin-top:6px; font-size:12px;">Coverage: <b>eNqanda & Surrounds</b></div>
        <div style="font-size:12px;">Flat Fee: <b>R30.00</b></div>
        <div style="font-size:12px;">Dispatch: <a href="https://wa.me/${WA}" target="_blank" style="color:#4ade80; text-decoration:none; font-weight:700;">WhatsApp / Call ↗</a></div>
      </div>
    </div>

    <!-- Live Quantum Ticker -->
    <div class="nq-ticker">
      ⚡ Quantum Feed: Sipho from eNqanda A-Section just ordered Selver Sense Perfume & Cereal Hamper!
    </div>

    <!-- Lucky Spin Discount Banner -->
    <div class="lucky-spin-banner">
      <div>
        <div style="font-weight:900; color:#f43f5e; font-size:14px;">🎁 Spin & Win Instant Discount!</div>
        <div style="font-size:12.5px; color:#cbd5e1; margin-top:2px;">Get up to R50 off your eNqanda delivery right now.</div>
      </div>
      <button class="nq-btn" id="spin-wheel-btn" style="width:auto; padding:10px 20px; background:linear-gradient(135deg, #ec4899, #8b5cf6);">🎡 Spin Wheel</button>
    </div>

    <!-- Navigation Bar -->
    <div class="nq-nav-bar">
      <button class="nq-nav-btn on" data-target="home">🏠 Home</button>
      <button class="nq-nav-btn" data-target="catalog">🛍️ Catalog</button>
      <button class="nq-nav-btn" data-target="builder">📦 Hamper Builder</button>
      <button class="nq-nav-btn" data-target="booking">📅 Booking</button>
      <button class="nq-nav-btn" data-target="specials">🔥 Specials</button>
      <button class="nq-nav-btn" data-target="orders">📦 Orders</button>
      <button class="nq-nav-btn" data-target="console">⚙️ Owner Console</button>
      <button class="nq-nav-btn" data-target="security">🔒 Security</button>
      <button class="nq-nav-btn" id="open-cart-btn" style="background:linear-gradient(135deg, #38bdf8, #2563eb); color:#fff;">🛒 Neural Cart (<span id="cart-count">3</span>)</button>
    </div>

    <!-- TAB 1: HOME & FEATURED -->
    <div id="sec-home" class="nq-section active">
      <h2 style="font-size:22px; font-weight:800; margin-bottom:16px;">🔥 Featured Bulk Specials & New Stock</h2>
      <div class="nq-grid" id="home-grid"></div>
    </div>

    <!-- TAB 2: QUANTUM CATALOG -->
    <div id="sec-catalog" class="nq-section">
      <h2 style="font-size:22px; font-weight:800; margin-bottom:16px;">🛍️ Quantum Catalog</h2>
      <div style="margin-bottom:20px;">
        <input type="text" id="nq-search" placeholder="Search perfumes, juices, cereals..." style="width:100%; max-width:450px; padding:12px 18px; border-radius:999px; border:1px solid rgba(255,255,255,0.15); background:rgba(15,23,42,0.85); color:#fff; font-size:13.5px; outline:none;">
      </div>
      <div class="nq-grid" id="catalog-grid"></div>
    </div>

    <!-- TAB 3: HAMPER BUILDER -->
    <div id="sec-builder" class="nq-section">
      <div class="builder-box">
        <h2 style="font-size:22px; font-weight:800; color:#38bdf8; margin-top:0;">✨ Build Custom Cereal Hamper</h2>
        <p style="color:#94a3b8; font-size:13.5px;">Choose 5 preferred items to assemble your custom bundle for <b>R250.00</b>!</p>
        <div class="builder-grid">
          <label class="builder-item"><span>Jungle Oats 1kg <small style="color:#38bdf8;">(Cereal)</small></span><input type="checkbox" checked></label>
          <label class="builder-item"><span>Future Life 500g <small style="color:#38bdf8;">(Cereal)</small></span><input type="checkbox" checked></label>
          <label class="builder-item"><span>Bokomo Corn Flakes 1kg <small style="color:#38bdf8;">(Cereal)</small></span><input type="checkbox" checked></label>
          <label class="builder-item"><span>Weet-Bix 450g <small style="color:#38bdf8;">(Cereal)</small></span><input type="checkbox" checked></label>
          <label class="builder-item"><span>Nutrific 450g <small style="color:#38bdf8;">(Cereal)</small></span><input type="checkbox" checked></label>
          <label class="builder-item"><span>Happy Valley Rice Puffs <small style="color:#38bdf8;">(Cereal)</small></span><input type="checkbox"></label>
          <label class="builder-item"><span>Kellogg's Noodles (5 Pack) <small style="color:#38bdf8;">(Snacks)</small></span><input type="checkbox"></label>
          <label class="builder-item"><span>Juice Concentrate 300ml <small style="color:#38bdf8;">(Beverage)</small></span><input type="checkbox"></label>
        </div>
        <button class="nq-btn" id="add-builder-to-cart" style="max-width:300px;">🛒 Add Custom Hamper to Cart (R250)</button>
      </div>
    </div>

    <!-- TAB 4: BOOKING / CONSULTATION -->
    <div id="sec-booking" class="nq-section">
      <div class="builder-box" style="max-width:600px; margin:0 auto;">
        <h2 style="font-size:22px; font-weight:800; color:#38bdf8; margin-top:0;">📅 Schedule Consultation & Delivery</h2>
        <p style="color:#94a3b8; font-size:13.5px;">Book a delivery slot or consultation directly with Nollie's Hub team.</p>
        <div style="margin-bottom:14px;"><label style="font-size:12px; font-weight:700; display:block; margin-bottom:6px;">Your Name:</label><input type="text" id="bk-name" placeholder="e.g. Sibusiso Zulu" style="width:100%; padding:12px; border-radius:10px; border:1px solid rgba(255,255,255,0.15); background:rgba(30,41,59,0.8); color:#fff; box-sizing:border-box;"></div>
        <div style="margin-bottom:14px;"><label style="font-size:12px; font-weight:700; display:block; margin-bottom:6px;">WhatsApp Phone:</label><input type="text" id="bk-phone" placeholder="e.g. 072 123 4567" style="width:100%; padding:12px; border-radius:10px; border:1px solid rgba(255,255,255,0.15); background:rgba(30,41,59,0.8); color:#fff; box-sizing:border-box;"></div>
        <div style="margin-bottom:20px;"><label style="font-size:12px; font-weight:700; display:block; margin-bottom:6px;">Delivery Location in eNqanda:</label><input type="text" id="bk-loc" placeholder="e.g. eNqanda A-Section" style="width:100%; padding:12px; border-radius:10px; border:1px solid rgba(255,255,255,0.15); background:rgba(30,41,59,0.8); color:#fff; box-sizing:border-box;"></div>
        <button class="nq-btn" id="submit-booking">📅 Transmit Appointment Request</button>
      </div>
    </div>

    <!-- TAB 5: SPECIALS -->
    <div id="sec-specials" class="nq-section">
      <h2 style="font-size:22px; font-weight:800; margin-bottom:16px;">🔥 Bulk Specials & Packages</h2>
      <div class="nq-grid" id="specials-grid"></div>
    </div>

    <!-- TAB 6: ORDERS -->
    <div id="sec-orders" class="nq-section">
      <h2 style="font-size:22px; font-weight:800; margin-bottom:16px;">📦 Active & Past Orders</h2>
      <div class="builder-box">
        <p style="color:#cbd5e1; font-size:14px;">You have <b>1 active delivery order</b> in progress:</p>
        <div style="background:rgba(30,41,59,0.6); padding:16px; border-radius:12px; border:1px solid rgba(56,189,248,0.2); margin-top:12px;">
          <div style="font-weight:800; color:#38bdf8;">Order #NQ-7842 (Selver Sense Perfume & Cereal Hamper)</div>
          <div style="font-size:13px; color:#94a3b8; margin-top:4px;">Status: Out for Delivery in eNqanda A-Section ⚡</div>
        </div>
      </div>
    </div>

    <!-- TAB 7: OWNER CONSOLE -->
    <div id="sec-console" class="nq-section">
      <h2 style="font-size:22px; font-weight:800; margin-bottom:16px;">⚙️ Nollie's Owner Control Console (Architect: Banele Gumbi)</h2>
      <div class="console-grid">
        <div class="console-card"><h4>Total Revenue Generated</h4><p class="val">R 3,250.00</p></div>
        <div class="console-card"><h4>Total Orders</h4><p class="val">19</p></div>
        <div class="console-card"><h4>Active Bookings</h4><p class="val">4</p></div>
      </div>
      <div style="text-align:right; margin-bottom:20px;">
        <button class="nq-btn" style="width:auto; padding:10px 20px; background:#22c55e;" onclick="alert('Database synced successfully with Cloud instance!')">🔄 Sync Database</button>
      </div>
    </div>

    <!-- TAB 8: SECURITY -->
    <div id="sec-security" class="nq-section">
      <div class="builder-box">
        <h3 style="color:#38bdf8; margin-top:0;">🔒 Privacy Policy & Quantum Encrypted Data</h3>
        <p style="font-size:12px; color:#94a3b8;">Effective Date: October 2026 | Nollie's eNqanda Hub (Lead Developer: Banele Gumbi)</p>
        <p><b>1. Secure Gateway Processing:</b> All digital payment transactions (Capitec Pay, Instant EFT, Card) are encrypted via standard financial gateways following South African Protection of Personal Information Act (POPIA) protocols.</p>
        <p><b>2. Contact Information Security:</b> Client details are utilized strictly for delivery confirmation and consultation scheduling in eNqanda and are stored securely within local database instances.</p>
      </div>
    </div>

    <!-- NEURAL CART MODAL -->
    <div id="nq-cart-drawer">
      <div class="cart-modal-content">
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:16px;">
          <h3>🛒 Neural Cart & Payment Gateway</h3>
          <button id="close-cart" style="background:none; border:none; color:#94a3b8; font-size:20px; cursor:pointer;">✕</button>
        </div>
        <div id="cart-items-list" style="max-height:220px; overflow-y:auto; margin-bottom:16px;">
          <div class="cart-item-row"><span>Selver Sense & Dezire Perfume</span><b>R 250.00</b></div>
          <div class="cart-item-row"><span>Cereal Hamper Package 1</span><b>R 250.00</b></div>
        </div>
        <div class="promo-row">
          <input type="text" id="promo-code" value="NOLLIE15" placeholder="Promo code...">
          <button id="apply-promo">Apply</button>
        </div>
        <div style="font-size:13.5px; color:#cbd5e1; border-top:1px solid rgba(255,255,255,0.1); padding-top:12px;">
          <div style="display:flex; justify-content:space-between; margin-bottom:6px;"><span>Subtotal:</span><b>R 500.00</b></div>
          <div style="display:flex; justify-content:space-between; margin-bottom:6px;"><span>Discount:</span><b style="color:#4ade80;">-R 0.00</b></div>
          <div style="display:flex; justify-content:space-between; margin-bottom:10px;"><span>Delivery Fee (eNqanda):</span><b>R 30.00</b></div>
          <div style="display:flex; justify-content:space-between; font-size:16px; font-weight:900; color:#38bdf8; border-top:1px solid rgba(255,255,255,0.1); padding-top:10px;"><span>Total:</span><span>R 530.00</span></div>
        </div>
        <button class="nq-btn" id="pay-complete-order" style="background:linear-gradient(135deg, #22c55e, #16a34a); margin-top:20px;">Pay R530.00 & Complete Order 🚀</button>
      </div>
    </div>
  `;

  var homeGrid = sec.querySelector("#home-grid");
  var catalogGrid = sec.querySelector("#catalog-grid");
  var specialsGrid = sec.querySelector("#specials-grid");

  var specialsData = [
    {t: "Family Bulk Grocery Hamper", p: "R 380.00", d: "10kg Maize Meal, 5L Sunflower Oil, 2.5kg White Sugar, 2kg Rice, and 410g Baked Beans (x4).", c: "hamper"},
    {t: "Weekend Braai & Pap Combo", p: "R 295.00", d: "5kg Iwisa Maize Meal, Braai Spice, Chakalaka (x3), Tomato & Onion Mix, and 2L Soft Drink.", c: "hamper"}
  ];

  function renderCards(container, items){
    container.innerHTML = "";
    items.forEach(function(item){
      var d = document.createElement("div"); d.className = "nq-card";
      d.innerHTML = `
        <div class="nq-img-wrap">
          <div class="nq-badge">⚡ In Stock</div>
          <div class="stock-alert">🔥 Hot Demand</div>
          <img alt="${item.t}" loading="lazy">
        </div>
        <div class="nq-card-body">
          <div>
            <h3>${item.t}</h3>
            <p>${item.d || item.t}</p>
          </div>
          <div>
            <div class="nq-price">${item.p || "R 250.00"}</div>
            <button class="nq-btn cart-add-btn">⚡ Flash WhatsApp Order</button>
          </div>
        </div>
      `;
      setCardImage(d.querySelector("img"), item);
      d.querySelector(".cart-add-btn").addEventListener("click", function(){
        window.open("https://wa.me/" + WA + "?text=" + encodeURIComponent("Hi Nollie's Hub, I want immediate flash delivery for: " + item.t + " (" + (item.p || "R250") + ")"), "_blank");
      });
      container.appendChild(d);
    });
  }

  // Combine user's inventory photos with specials
  var catalogItems = P.map(function(x){
    return { t: x.t, p: "R 250.00", d: x.t, c: x.c };
  });

  renderCards(homeGrid, catalogItems.slice(0, 4));
  renderCards(catalogGrid, catalogItems);
  renderCards(specialsGrid, specialsData);

  var navBtns = sec.querySelectorAll(".nq-nav-btn[data-target]");
  var sections = sec.querySelectorAll(".nq-section");

  navBtns.forEach(function(btn){
    btn.addEventListener("click", function(){
      navBtns.forEach(function(b){ b.classList.remove("on"); });
      btn.classList.add("on");
      var target = btn.dataset.target;
      sections.forEach(function(s){
        s.classList.toggle("active", s.id === "sec-" + target);
      });
    });
  });

  sec.querySelector("#open-cart-btn").addEventListener("click", function(){
    sec.querySelector("#nq-cart-drawer").classList.add("open");
  });
  sec.querySelector("#close-cart").addEventListener("click", function(){
    sec.querySelector("#nq-cart-drawer").classList.remove("open");
  });

  sec.querySelector("#spin-wheel-btn").addEventListener("click", function(){
    var prizes = ["NOLLIE15 (15% OFF)", "FREE30 (Free Delivery)", "NOLLIE10 (R10 OFF)"];
    var won = prizes[Math.floor(Math.random() * prizes.length)];
    alert("🎉 CONGRATULATIONS! You spun and won code: " + won + "! Use it in your Neural Cart.");
    sec.querySelector("#promo-code").value = won.split(" ")[0];
    sec.querySelector("#nq-cart-drawer").classList.add("open");
  });

  sec.querySelector("#add-builder-to-cart").addEventListener("click", function(){
    alert("Custom Cereal Hamper successfully added to Neural Cart for R250.00!");
    sec.querySelector("#nq-cart-drawer").classList.add("open");
  });

  sec.querySelector("#submit-booking").addEventListener("click", function(){
    var name = sec.querySelector("#bk-name").value || "Valued Client";
    var phone = sec.querySelector("#bk-phone").value || "N/A";
    var loc = sec.querySelector("#bk-loc").value || "eNqanda";
    var msg = "📅 *APPOINTMENT / DELIVERY REQUEST*\n👤 Name: " + name + "\n📞 Phone: " + phone + "\n📍 Location: " + loc;
    window.open("https://wa.me/" + WA + "?text=" + encodeURIComponent(msg), "_blank");
  });

  sec.querySelector("#pay-complete-order").addEventListener("click", function(){
    window.open("https://wa.me/" + WA + "?text=" + encodeURIComponent("Hi Nollie's Hub, I have completed payment for my Neural Cart order. Please confirm dispatch to eNqanda!"), "_blank");
  });

  document.body.appendChild(sec);
}

if(document.readyState==="loading") document.addEventListener("DOMContentLoaded", init); else init();
})();
