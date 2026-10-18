(function(){
  if(window.__nqCat) return;
  window.__nqCat = 1;

  var WA = "27625873479";
  var inventory = window.NQ_PHOTOS || [];

  var css = `
    #mh-app { max-width: 1100px; margin: 20px auto 100px; padding: 0 16px; color: #f8fafc; font-family: system-ui, -apple-system, sans-serif; box-sizing: border-box; }
    #mh-app *, #mh-app *:before, #mh-app *:after { box-sizing: inherit; }

    .mh-hero { background: rgba(15, 23, 42, 0.95); border: 1px solid rgba(56, 189, 248, 0.2); border-radius: 20px; padding: 20px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 16px; }
    .mh-hero h1 { font-size: 20px; font-weight: 900; color: #fff; margin: 0 0 4px 0; }
    .mh-hero p { color: #94a3b8; font-size: 12.5px; margin: 0; line-height: 1.4; }

    /* Bottom Navigation Bar mimicking mobile app layout */
    .mh-bottom-nav { position: fixed; bottom: 0; left: 0; right: 0; background: rgba(15, 23, 42, 0.95); backdrop-filter: blur(16px); border-top: 1px solid rgba(255,255,255,0.1); display: flex; justify-content: space-around; padding: 10px 0; z-index: 9999; }
    .mh-nav-item { background: none; border: none; color: #94a3b8; font-size: 11px; font-weight: 700; cursor: pointer; display: flex; flex-direction: column; align-items: center; gap: 4px; position: relative; transition: color 0.2s; }
    .mh-nav-item.active { color: #38bdf8; }
    .mh-nav-item span.icon { font-size: 20px; }
    .mh-badge-dot { position: absolute; top: 0; right: 8px; background: #ef4444; color: #fff; font-size: 9px; font-weight: 800; padding: 1px 5px; border-radius: 999px; }

    .mh-sec { display: none; }
    .mh-sec.active { display: block; }

    .mh-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 16px; margin-bottom: 40px; }
    .mh-card { background: rgba(15, 23, 42, 0.85); border: 1px solid rgba(255,255,255,0.08); border-radius: 16px; overflow: hidden; display: flex; flex-direction: column; }
    .mh-img { position: relative; width: 100%; aspect-ratio: 1.25; background: #080c14; display: flex; align-items: center; justify-content: center; overflow: hidden; }
    .mh-card img { width: 100%; height: 100%; object-fit: cover; }
    .mh-tag { position: absolute; top: 10px; left: 10px; background: rgba(15,23,42,0.9); border: 1px solid rgba(34,197,94,0.3); color: #4ade80; font-size: 10px; font-weight: 800; padding: 3px 8px; border-radius: 999px; text-transform: uppercase; }
    .mh-body { padding: 14px; display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between; }
    .mh-body h3 { font-size: 13.5px; font-weight: 800; color: #fff; margin: 0 0 6px 0; }
    .mh-price { font-size: 15px; font-weight: 900; color: #38bdf8; margin-bottom: 10px; }
    .mh-action { width: 100%; padding: 10px; border-radius: 10px; background: linear-gradient(135deg, #38bdf8, #2563eb); color: #fff; font-weight: 800; font-size: 12px; border: none; cursor: pointer; text-align: center; text-decoration: none; display: inline-block; }

    .mh-panel { background: rgba(15, 23, 42, 0.9); border: 1px solid rgba(255,255,255,0.08); border-radius: 16px; padding: 20px; }
  `;

  function init(){
    var s = document.createElement("style");
    s.textContent = css;
    document.head.appendChild(s);

    var app = document.createElement("div");
    app.id = "mh-app";
    app.innerHTML = `
      <div class="mh-hero">
        <div>
          <h1>Nqbobile's Verified Durban Business Hub</h1>
          <p>Official Business Account | R30 delivery across Durban & surrounds.</p>
        </div>
        <div style="font-size:12px; color:#cbd5e1;">
          Director: <b>Nqbobile</b><br>
          Developer: <b style="color:#4ade80;">Banele Gumbi</b>
        </div>
      </div>

      <!-- TAB 1: HOME -->
      <div id="mh-sec-home" class="mh-sec">
        <div class="mh-panel">
          <h2 style="color:#38bdf8; margin-top:0;">Sawubona! Welcome Home</h2>
          <p style="color:#94a3b8; font-size:13px;">Explore our verified business services, quick FAQ, or jump straight into the Shop and Order tabs below.</p>
        </div>
      </div>

      <!-- TAB 2: SHOP (CATALOG) -->
      <div id="mh-sec-shop" class="mh-sec active">
        <h2 style="font-size:18px; font-weight:900; margin-bottom:14px;">🛍️ Product & Service Catalog</h2>
        <div class="mh-grid" id="mh-shop-grid"></div>
      </div>

      <!-- TAB 3: ORDER -->
      <div id="mh-sec-order" class="mh-sec">
        <div class="mh-panel">
          <h2 style="color:#38bdf8; margin-top:0;">⚡ Active Orders & Dispatch</h2>
          <p style="color:#94a3b8; font-size:13px; margin-bottom:16px;">You have 1 active order pending delivery dispatch in Durban.</p>
          <div style="background:rgba(30,41,59,0.7); padding:14px; border-radius:12px; border:1px solid rgba(56,189,248,0.3);">
            <div style="font-weight:800; color:#38bdf8;">Order #NQ-8824 (Bulk Grocery & Perfume Bundle)</div>
            <div style="font-size:12px; color:#cbd5e1; margin-top:4px;">Status: Out for Delivery (R30 Flat Fee) 🚀</div>
          </div>
        </div>
      </div>

      <!-- TAB 4: CHAT / CONTACT -->
      <div id="mh-sec-chat" class="mh-sec">
        <div class="mh-panel">
          <h2 style="color:#38bdf8; margin-top:0;">💬 Direct Support & WhatsApp</h2>
          <p style="color:#94a3b8; font-size:13px;">Connect instantly with Nqbobile's Hub team.</p>
          <a href="https://wa.me/${WA}?text=Hi%20Nqbobile's%20Hub,%20I%20need%20assistance!" target="_blank" class="mh-action" style="margin-top:12px; max-width:250px;">Open WhatsApp Chat ↗</a>
        </div>
      </div>

      <!-- BOTTOM APP NAVIGATION BAR -->
      <div class="mh-bottom-nav">
        <button class="mh-nav-item" data-target="home"><span class="icon">🏠</span>Home</button>
        <button class="mh-nav-item active" data-target="shop"><span class="icon">🛍️</span>Shop</button>
        <button class="mh-nav-item" data-target="order"><span class="icon">⚡</span>Order<span class="mh-badge-dot">1</span></button>
        <button class="mh-nav-item" data-target="chat"><span class="icon">💬</span>Chat</button>
      </div>
    `;

    document.body.appendChild(app);

    var grid = app.querySelector("#mh-shop-grid");
    inventory.forEach(function(item){
      var card = document.createElement("div");
      card.className = "mh-card";
      card.innerHTML = `
        <div class="mh-img">
          <div class="mh-tag">In Stock</div>
          <img alt="${item.t}" loading="lazy">
        </div>
        <div class="mh-body">
          <div>
            <h3>${item.t}</h3>
            <div class="mh-price">R 250.00</div>
          </div>
          <a href="https://wa.me/${WA}?text=${encodeURIComponent('Hi Nqbobile\'s Hub, I want to order: ' + item.t)}" target="_blank" class="mh-action">💬 Order via WhatsApp</a>
        </div>
      `;

      var img = card.querySelector("img");
      var bg = "#0f172a", accent = "#38bdf8", icon = "📦";
      var t = item.t.toLowerCase();
      if(t.includes("perfume")) { bg = "#4c0519"; accent = "#f43f5e"; icon = "✨"; }
      else if(t.includes("juice")) { bg = "#064e3b"; accent = "#34d399"; icon = "🧃"; }
      else if(t.includes("hamper") || t.includes("combo")) { bg = "#1e3a8a"; accent = "#60a5fa"; icon = "🧺"; }

      img.src = "data:image/svg+xml;utf8,+ encodeURIComponent(
        "<svg xmlns='http://www.w3.org/2000/svg' width='600' height='600' viewBox='0 0 600 600'>" +
        "<defs><linearGradient id='g' x1='0' y1='0' x2='1' y2='1'><stop offset='0%' stop-color='" + bg + "'/><stop offset='100%' stop-color='#020617'/></linearGradient></defs>" +
        "<rect width='100%' height='100%' fill='url(#g)'/>" +
        "<circle cx='300' cy='240' r='90' fill='" + accent + "' opacity='0.15'/>" +
        "<text x='300' y='265' font-size='70' text-anchor='middle'>" + icon + "</text>" +
        "<text x='300' y='380' fill='#ffffff' font-family='sans-serif' font-size='20' font-weight='800' text-anchor='middle'>NQOBILE'S HUB</text>" +
        "<text x='300' y='415' fill='" + accent + "' font-family='sans-serif' font-size='15' font-weight='600' text-anchor='middle'>" + item.t.substring(0, 25) + "</text>" +
        "</svg>"
      );

      grid.appendChild(card);
    });

    var navItems = app.querySelectorAll(".mh-nav-item");
    var secs = app.querySelectorAll(".mh-sec");
    navItems.forEach(function(item){
      item.addEventListener("click", function(){
        navItems.forEach(function(i){ i.classList.remove("active"); });
        item.classList.add("active");
        var target = "mh-sec-" + item.dataset.target;
        secs.forEach(function(s){
          s.classList.toggle("active", s.id === target);
        });
      });
    });
  }

  if(document.readyState==="loading") document.addEventListener("DOMContentLoaded", init); else init();
})();
