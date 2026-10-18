(function(){
  if(window.__nqCat) return;
  window.__nqCat = 1;

  var WA = "27625873479";
  var inventory = window.NQ_PHOTOS || [];

  var strategicCSS = `
    #mh-hub { max-width: 1100px; margin: 40px auto 100px; padding: 0 20px; color: #f8fafc; font-family: system-ui, -apple-system, sans-serif; box-sizing: border-box; }
    #mh-hub *, #mh-hub *:before, #mh-hub *:after { box-sizing: inherit; }

    /* Strategic Header Card */
    .mh-header { background: rgba(15, 23, 42, 0.95); backdrop-filter: blur(20px); border: 1px solid rgba(56, 189, 248, 0.25); border-radius: 20px; padding: 30px; margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 24px; box-shadow: 0 20px 40px rgba(0,0,0,0.6); }
    .mh-header h1 { font-size: 24px; font-weight: 900; color: #fff; margin: 0 0 6px 0; letter-spacing: -0.5px; }
    .mh-header p { color: #94a3b8; font-size: 13.5px; margin: 0; line-height: 1.5; }
    .mh-directors { background: rgba(30, 41, 59, 0.85); border: 1px solid rgba(255,255,255,0.08); border-radius: 14px; padding: 14px 20px; font-size: 13px; color: #cbd5e1; }
    .mh-directors b { color: #38bdf8; }

    /* Strategic Navigation Tabs */
    .mh-nav { display: flex; gap: 10px; margin-bottom: 30px; flex-wrap: wrap; justify-content: center; }
    .mh-tab { padding: 10px 20px; border-radius: 999px; border: 1px solid rgba(255,255,255,0.1); background: rgba(15, 23, 42, 0.8); color: #cbd5e1; font-weight: 700; font-size: 13px; cursor: pointer; transition: all 0.2s ease; }
    .mh-tab:hover { border-color: #38bdf8; color: #fff; }
    .mh-tab.active { background: #38bdf8; color: #0f172a; border-color: transparent; font-weight: 900; box-shadow: 0 4px 15px rgba(56, 189, 248, 0.4); }

    /* Sections */
    .mh-section { display: none; }
    .mh-section.active { display: block; }

    /* Product Grid */
    .mh-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 20px; }
    .mh-card { background: rgba(15, 23, 42, 0.8); border: 1px solid rgba(255,255,255,0.08); border-radius: 18px; overflow: hidden; display: flex; flex-direction: column; transition: all 0.25s ease; box-shadow: 0 10px 25px rgba(0,0,0,0.3); }
    .mh-card:hover { transform: translateY(-4px); border-color: rgba(56, 189, 248, 0.3); }
    .mh-img-wrap { position: relative; width: 100%; aspect-ratio: 1.25; background: #080c14; display: flex; align-items: center; justify-content: center; overflow: hidden; }
    .mh-card img { width: 100%; height: 100%; object-fit: cover; }
    .mh-tag { position: absolute; top: 10px; left: 10px; background: rgba(15,23,42,0.9); border: 1px solid rgba(34,197,94,0.3); color: #4ade80; font-size: 10px; font-weight: 800; padding: 4px 10px; border-radius: 999px; text-transform: uppercase; }
    .mh-body { padding: 18px; display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between; }
    .mh-body h3 { font-size: 14.5px; font-weight: 800; color: #fff; margin: 0 0 6px 0; }
    .mh-body p { font-size: 12.5px; color: #94a3b8; margin: 0 0 14px 0; line-height: 1.4; }
    .mh-price { font-size: 17px; font-weight: 900; color: #38bdf8; margin-bottom: 12px; }
    .mh-btn { width: 100%; padding: 11px; border-radius: 10px; background: linear-gradient(135deg, #38bdf8 0%, #2563eb 100%); color: #fff; font-weight: 800; font-size: 13px; border: none; cursor: pointer; text-align: center; text-decoration: none; display: inline-block; transition: opacity 0.2s; }
    .mh-btn:hover { opacity: 0.92; }

    /* Strategic Panels */
    .mh-panel { background: rgba(15, 23, 42, 0.9); border: 1px solid rgba(255,255,255,0.08); border-radius: 20px; padding: 24px; }
  `;

  function initHub() {
    var style = document.createElement("style");
    style.textContent = strategicCSS;
    document.head.appendChild(style);

    var app = document.createElement("div");
    app.id = "mh-hub";
    app.innerHTML = `
      <div class="mh-header">
        <div>
          <h1>Nollie's Quantum Hub (MH Strategy)</h1>
          <p>Streamlined e-commerce operations, bulk grocery distribution, and high-value essentials across eNqanda & surrounds (Flat R30 Delivery Fee).</p>
        </div>
        <div class="mh-directors">
          <div>Founder & Lead Director: <b>Nolly</b></div>
          <div style="color:#4ade80; margin-top:2px;">Master Developer & Architect: <b>Banele Gumbi</b></div>
          <div style="margin-top:6px; font-size:12px;">Coverage: <b>eNqanda & Surrounds</b></div>
        </div>
      </div>

      <div class="mh-nav">
        <button class="mh-tab active" data-target="catalog">🛍️ Catalog & Storefront</button>
        <button class="mh-tab" data-target="strategy">📊 Strategic Framework</button>
        <button class="mh-tab" data-target="security">🔒 POPIA Compliance</button>
      </div>

      <div id="mh-sec-catalog" class="mh-section active">
        <div class="mh-grid" id="mh-catalog-grid"></div>
      </div>

      <div id="mh-sec-strategy" class="mh-section">
        <div class="mh-panel">
          <h2 style="color:#38bdf8; margin-top:0;">📈 Operational & Financial Strategy</h2>
          <p style="color:#94a3b8; font-size:13.5px;">Designed and engineered under the technical leadership of Banele Gumbi to maximize local conversion rates, maintain low logistics overhead, and ensure robust digital inventory tracking for eNqanda clients.</p>
        </div>
      </div>

      <div id="mh-sec-security" class="mh-section">
        <div class="mh-panel">
          <h2 style="color:#38bdf8; margin-top:0;">🔒 Data Governance & POPIA Protocol</h2>
          <p style="color:#94a3b8; font-size:13.5px;">All customer records, orders, and WhatsApp dispatch logs are encrypted and handled in strict accordance with South African POPIA regulations.</p>
        </div>
      </div>
    `;

    document.body.appendChild(app);

    var grid = app.querySelector("#mh-catalog-grid");
    inventory.forEach(function(item){
      var card = document.createElement("div");
      card.className = "mh-card";
      card.innerHTML = `
        <div class="mh-img-wrap">
          <div class="mh-tag">In Stock</div>
          <img alt="${item.t}" loading="lazy">
        </div>
        <div class="mh-body">
          <div>
            <h3>${item.t}</h3>
            <p>Verified premium stock ready for immediate dispatch.</p>
          </div>
          <div>
            <div class="mh-price">R 250.00</div>
            <a href="https://wa.me/${WA}?text=${encodeURIComponent('Hi Nollie\'s Hub, I would like to order: ' + item.t)}" target="_blank" class="mh-btn">💬 Order via WhatsApp</a>
          </div>
        </div>
      `;

      var img = card.querySelector("img");
      if(item.n && item.n.length > 0) {
        img.src = item.n;
      } else {
        var bg = "#0f172a", accent = "#38bdf8", icon = "📦";
        var t = item.t.toLowerCase();
        if(t.includes("perfume")) { bg = "#4c0519"; accent = "#f43f5e"; icon = "✨"; }
        else if(t.includes("juice")) { bg = "#064e3b"; accent = "#34d399"; icon = "🧃"; }
        else if(t.includes("hamper") || t.includes("combo")) { bg = "#1e3a8a"; accent = "#60a5fa"; icon = "🧺"; }

        img.src = "data:image/svg+xml;utf8," + encodeURIComponent(
          "<svg xmlns='http://www.w3.org/2000/svg' width='600' height='600' viewBox='0 0 600 600'>" +
          "<defs><linearGradient id='g' x1='0' y1='0' x2='1' y2='1'><stop offset='0%' stop-color='" + bg + "'/><stop offset='100%' stop-color='#020617'/></linearGradient></defs>" +
          "<rect width='100%' height='100%' fill='url(#g)'/>" +
          "<circle cx='300' cy='240' r='90' fill='" + accent + "' opacity='0.15'/>" +
          "<text x='300' y='265' font-size='70' text-anchor='middle'>" + icon + "</text>" +
          "<text x='300' y='380' fill='#ffffff' font-family='sans-serif' font-size='20' font-weight='800' text-anchor='middle'>NOLLIE'S HUB</text>" +
          "<text x='300' y='415' fill='" + accent + "' font-family='sans-serif' font-size='15' font-weight='600' text-anchor='middle'>" + item.t.substring(0, 25) + "</text>" +
          "</svg>"
        );
      }
      grid.appendChild(card);
    });

    var tabs = app.querySelectorAll(".mh-tab");
    var secs = app.querySelectorAll(".mh-section");
    tabs.forEach(function(tab){
      tab.addEventListener("click", function(){
        tabs.forEach(function(t){ t.classList.remove("active"); });
        tab.classList.add("active");
        var target = "mh-sec-" + tab.dataset.target;
        secs.forEach(function(s){
          s.classList.toggle("active", s.id === target);
        });
      });
    });
  }

  if(document.readyState==="loading") document.addEventListener("DOMContentLoaded", initHub); else initHub();
})();
