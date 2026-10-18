(function(){
  if(window.__nqCat) return;
  window.__nqCat = 1;

  var OWNER = "banele477", REPO = "nollies-site", BRANCH = "main", WA = "27625873479";
  var photosData = window.NQ_PHOTOS || [];

  var cssStyles = `
    #nqc-app { max-width: 1200px; margin: 30px auto 120px; padding: 0 16px; color: #f8fafc; font-family: system-ui, -apple-system, sans-serif; box-sizing: border-box; }
    #nqc-app *, #nqc-app *:before, #nqc-app *:after { box-sizing: inherit; }

    /* Header & Branding */
    .nqc-header { background: rgba(15, 23, 42, 0.9); backdrop-filter: blur(20px); border: 1px solid rgba(56, 189, 248, 0.3); border-radius: 24px; padding: 24px; margin-bottom: 24px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 20px; box-shadow: 0 20px 50px rgba(0,0,0,0.5); }
    .nqc-header h1 { font-size: 26px; font-weight: 900; color: #fff; margin: 0 0 6px 0; }
    .nqc-header p { color: #94a3b8; font-size: 13.5px; margin: 0; line-height: 1.5; }
    .nqc-meta { background: rgba(30, 41, 59, 0.8); border: 1px solid rgba(255,255,255,0.1); border-radius: 16px; padding: 14px 20px; font-size: 13px; color: #cbd5e1; }
    .nqc-meta b { color: #38bdf8; }

    /* Navigation Bar */
    .nqc-nav { display: flex; gap: 8px; overflow-x: auto; padding: 4px 4px 24px; scrollbar-width: none; justify-content: center; flex-wrap: wrap; }
    .nqc-nav::-webkit-scrollbar { display: none; }
    .nqc-nav-btn { flex: none; padding: 10px 18px; border-radius: 999px; border: 1px solid rgba(255,255,255,0.1); background: rgba(15, 23, 42, 0.7); color: #cbd5e1; font-weight: 700; font-size: 12.5px; cursor: pointer; transition: all 0.25s ease; display: flex; align-items: center; gap: 6px; backdrop-filter: blur(10px); }
    .nqc-nav-btn:hover { border-color: #38bdf8; color: #fff; transform: translateY(-2px); }
    .nqc-nav-btn.active { background: linear-gradient(135deg, #38bdf8 0%, #2563eb 100%); color: #0f172a; border-color: transparent; font-weight: 900; box-shadow: 0 6px 20px rgba(56, 189, 248, 0.4); }

    /* Views / Sections */
    .nqc-section { display: none; }
    .nqc-section.active { display: block; }

    /* Grid & Cards */
    .nqc-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 24px; }
    .nqc-card { background: rgba(15, 23, 42, 0.75); backdrop-filter: blur(16px); border: 1px solid rgba(255,255,255,0.08); border-radius: 22px; overflow: hidden; display: flex; flex-direction: column; transition: all 0.3s ease; box-shadow: 0 10px 30px rgba(0,0,0,0.3); }
    .nqc-card:hover { transform: translateY(-6px); border-color: rgba(56, 189, 248, 0.4); box-shadow: 0 20px 40px rgba(56, 189, 248, 0.15); }
    .nqc-img-box { position: relative; width: 100%; aspect-ratio: 1.2; background: #080c14; overflow: hidden; display: flex; align-items: center; justify-content: center; }
    .nqc-card img { width: 100%; height: 100%; object-fit: cover; display: block; }
    .nqc-badge { position: absolute; top: 12px; left: 12px; background: rgba(15, 23, 42, 0.9); backdrop-filter: blur(10px); border: 1px solid rgba(34, 197, 94, 0.3); color: #4ade80; font-size: 10px; font-weight: 800; text-transform: uppercase; padding: 5px 12px; border-radius: 999px; }
    .nqc-card-body { padding: 18px; display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between; }
    .nqc-card-body h3 { font-size: 15px; font-weight: 800; color: #fff; margin: 0 0 8px 0; }
    .nqc-card-body p { font-size: 13px; color: #94a3b8; margin: 0 0 14px 0; line-height: 1.4; }
    .nqc-price { font-size: 18px; font-weight: 900; color: #38bdf8; margin-bottom: 14px; }
    
    /* Buttons & Interactive Elements */
    .nqc-btn { width: 100%; padding: 12px; border-radius: 12px; background: linear-gradient(135deg, #38bdf8 0%, #2563eb 100%); color: #fff; font-weight: 800; font-size: 13.5px; border: none; cursor: pointer; transition: all 0.2s ease; box-shadow: 0 4px 15px rgba(37, 99, 235, 0.3); text-align: center; text-decoration: none; display: inline-block; }
    .nqc-btn:hover { opacity: 0.95; transform: scale(1.02); }
    .nqc-panel { background: rgba(15, 23, 42, 0.85); backdrop-filter: blur(20px); border: 1px solid rgba(255,255,255,0.1); border-radius: 24px; padding: 28px; }
  `;

  function initApp() {
    var styleEl = document.createElement("style");
    styleEl.textContent = cssStyles;
    document.head.appendChild(styleEl);

    var appContainer = document.createElement("div");
    appContainer.id = "nqc-app";

    appContainer.innerHTML = `
      <!-- Header -->
      <div class="nqc-header">
        <div>
          <h1>Sawubona! Nollie's Quantum Hub</h1>
          <p>Delivering high-grade groceries, essentials, and bulk packages to eNqanda & surrounds with a flat R30 delivery fee.</p>
        </div>
        <div class="nqc-meta">
          <div>Founder & Director: <b>Nolly</b></div>
          <div style="color:#4ade80; margin-top:2px;">Master Developer & Architect: <b>Banele Gumbi</b></div>
          <div style="margin-top:6px; font-size:12px;">Coverage: <b>eNqanda & Surrounds</b> | Fee: <b>R30.00</b></div>
        </div>
      </div>

      <!-- Navigation Bar -->
      <div class="nqc-nav">
        <button class="nqc-nav-btn active" data-target="home">🏠 Home</button>
        <button class="nqc-nav-btn" data-target="catalog">🛍️ Catalog</button>
        <button class="nqc-nav-btn" data-target="console">⚙️ Owner Console</button>
        <button class="nqc-nav-btn" data-target="security">🔒 POPIA Security</button>
      </div>

      <!-- TAB 1: HOME -->
      <div id="nqc-sec-home" class="nqc-section active">
        <h2 style="font-size:20px; font-weight:800; margin-bottom:16px;">🔥 Featured Quantized Selection</h2>
        <div class="nqc-grid" id="nqc-home-grid"></div>
      </div>

      <!-- TAB 2: CATALOG -->
      <div id="nqc-sec-catalog" class="nqc-section">
        <h2 style="font-size:20px; font-weight:800; margin-bottom:16px;">🛍️ Complete Product Catalog</h2>
        <div class="nqc-grid" id="nqc-catalog-grid"></div>
      </div>

      <!-- TAB 3: OWNER CONSOLE -->
      <div id="nqc-sec-console" class="nqc-section">
        <div class="nqc-panel">
          <h2 style="color:#38bdf8; margin-top:0;">⚙️ Owner Control Console</h2>
          <p style="color:#94a3b8; font-size:13.5px;">Managed under the architectural direction of Banele Gumbi for Nollie's Hub.</p>
          <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(200px, 1fr)); gap:16px; margin-top:20px;">
            <div style="background:rgba(30,41,59,0.7); padding:16px; border-radius:14px; border:1px solid rgba(255,255,255,0.08);">
              <div style="font-size:12px; color:#94a3b8; text-transform:uppercase;">System Status</div>
              <div style="font-size:20px; font-weight:900; color:#4ade80; margin-top:4px;">Operational ⚡</div>
            </div>
            <div style="background:rgba(30,41,59,0.7); padding:16px; border-radius:14px; border:1px solid rgba(255,255,255,0.08);">
              <div style="font-size:12px; color:#94a3b8; text-transform:uppercase;">Deployment</div>
              <div style="font-size:20px; font-weight:900; color:#38bdf8; margin-top:4px;">GitHub Pages</div>
            </div>
          </div>
        </div>
      </div>

      <!-- TAB 4: SECURITY / POPIA -->
      <div id="nqc-sec-security" class="nqc-section">
        <div class="nqc-panel">
          <h2 style="color:#38bdf8; margin-top:0;">🔒 POPIA Compliance & Security</h2>
          <p style="color:#94a3b8; font-size:13.5px;">All client interactions and dispatch requests adhere strictly to the Protection of Personal Information Act (POPIA).</p>
        </div>
      </div>
    `;

    document.body.appendChild(appContainer);

    // Populate Cards Safely
    var homeGrid = appContainer.querySelector("#nqc-home-grid");
    var catalogGrid = appContainer.querySelector("#nqc-catalog-grid");

    var displayItems = photosData.length ? photosData : [
      { t: "Family Bulk Grocery Hamper", c: "hamper" },
      { t: "Cereal & Breakfast Combo", c: "cereal" }
    ];

    function renderGrid(container, items) {
      container.innerHTML = "";
      items.forEach(function(item) {
        var card = document.createElement("div");
        card.className = "nqc-card";
        card.innerHTML = `
          <div class="nqc-img-box">
            <div class="nqc-badge">In Stock</div>
            <img alt="${item.t}" loading="lazy">
          </div>
          <div class="nqc-card-body">
            <div>
              <h3>${item.t}</h3>
              <p>High-grade verified item ready for eNqanda dispatch.</p>
            </div>
            <div>
              <div class="nqc-price">R 250.00</div>
              <a href="https://wa.me/${WA}?text=${encodeURIComponent('Hi Nollie\'s Hub, I would like to order: ' + item.t)}" target="_blank" class="nqc-btn">💬 Order via WhatsApp</a>
            </div>
          </div>
        `;
        
        // Safe Fallback SVG Art Generation
        var imgTag = card.querySelector("img");
        if (item.n && item.n.length > 0) {
          imgTag.src = item.n;
        } else {
          imgTag.src = "data:image/svg+xml;utf8," + encodeURIComponent(
            "<svg xmlns='http://www.w3.org/2000/svg' width='600' height='600' viewBox='0 0 600 600'>" +
            "<rect width='100%' height='100%' fill='#0f172a'/>" +
            "<circle cx='300' cy='240' r='90' fill='#38bdf8' opacity='0.15'/>" +
            "<text x='300' y='265' font-size='70' text-anchor='middle'>📦</text>" +
            "<text x='300' y='380' fill='#ffffff' font-family='sans-serif' font-size='20' font-weight='800' text-anchor='middle'>NOLLIE'S HUB</text>" +
            "<text x='300' y='415' fill='#38bdf8' font-family='sans-serif' font-size='15' font-weight='600' text-anchor='middle'>" + item.t.substring(0, 25) + "</text>" +
            "</svg>"
          );
        }

        container.appendChild(card);
      });
    }

    renderGrid(homeGrid, displayItems.slice(0, 4));
    renderGrid(catalogGrid, displayItems);

    // Tab Switching Logic
    var navButtons = appContainer.querySelectorAll(".nqc-nav-btn");
    var sections = appContainer.querySelectorAll(".nqc-section");

    navButtons.forEach(function(btn) {
      btn.addEventListener("click", function() {
        navButtons.forEach(function(b) { b.classList.remove("active"); });
        btn.classList.add("active");
        var targetId = "nqc-sec-" + btn.dataset.target;
        sections.forEach(function(sec) {
          sec.classList.toggle("active", sec.id === targetId);
        });
      });
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initApp);
  } else {
    initApp();
  }
})();
