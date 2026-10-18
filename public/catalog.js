(function(){
if(window.__nqCat)return;window.__nqCat=1;
var OWNER="banele477",REPO="nollies-site",BRANCH="main",WA="27625873479";
var P=window.NQ_PHOTOS||[];
P = P.filter(function(x){ return x && x.n && x.t; });
if(!P.length)return;

var base=location.pathname.replace(/[^\/]*$/,"");
var CDN="https://cdn.jsdelivr.net/gh/"+OWNER+"/"+REPO+"@"+BRANCH+"/public/images/";
var FALL="data:image/svg+xml;utf8,"+encodeURIComponent("<svg xmlns='http://www.w3.org/2000/svg' width='600' height='600'><rect width='100%' height='100%' fill='#080c14'/></svg>");

var TABS={
  all:"🔥 All Highlights",
  trending:"⚡ Trending Deals",
  bundle:"📦 Bulk & Hampers",
  pantry:"🥣 Pantry Essentials",
  campus:"🎓 DUT Campus Specials",
  meeting:"📅 Book Meeting",
  popia:"🔒 POPIA Policy"
};

var css=`
#nqc { max-width: 1200px; margin: 30px auto 120px; padding: 0 16px; color: #f8fafc; font-family: system-ui, -apple-system, sans-serif; }
#nqc .nq-header { text-align: center; margin-bottom: 24px; }
#nqc h2 { font-size: 32px; font-weight: 900; background: linear-gradient(135deg, #f8fafc 0%, #38bdf8 50%, #818cf8 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; margin: 0 0 8px 0; letter-spacing: -0.5px; }
#nqc .s { color: #94a3b8; font-size: 14px; font-weight: 500; }

.nq-banner { background: linear-gradient(135deg, rgba(56, 189, 248, 0.12), rgba(129, 140, 248, 0.12)); border: 1px solid rgba(56, 189, 248, 0.3); border-radius: 16px; padding: 12px 20px; text-align: center; margin-bottom: 24px; font-size: 13px; color: #38bdf8; font-weight: 600; display: flex; align-items: center; justify-content: center; gap: 8px; backdrop-filter: blur(12px); box-shadow: 0 8px 32px rgba(0,0,0,0.2); }

.search-box { max-width: 520px; margin: 0 auto 20px; position: relative; }
.search-box input { width: 100%; padding: 14px 20px 14px 46px; border-radius: 999px; border: 1px solid rgba(255, 255, 255, 0.15); background: rgba(15, 23, 42, 0.85); backdrop-filter: blur(16px); color: #fff; font-size: 14px; outline: none; box-sizing: border-box; transition: all 0.3s ease; box-shadow: 0 4px 20px rgba(0,0,0,0.3); }
.search-box input:focus { border-color: #38bdf8; box-shadow: 0 0 20px rgba(56, 189, 248, 0.25); }
.search-box svg { position: absolute; left: 16px; top: 50%; transform: translateY(-50%); width: 18px; height: 18px; fill: #94a3b8; }

#nqc .ch { display: flex; gap: 10px; overflow-x: auto; padding: 4px 4px 20px; scrollbar-width: none; justify-content: center; flex-wrap: wrap; }
#nqc .ch::-webkit-scrollbar { display: none; }
#nqc .ch button { flex: none; padding: 10px 18px; border-radius: 999px; border: 1px solid rgba(255, 255, 255, 0.1); background: rgba(30, 41, 59, 0.6); color: #cbd5e1; font-weight: 600; font-size: 13px; cursor: pointer; transition: all 0.25s ease; backdrop-filter: blur(8px); }
#nqc .ch button:hover { border-color: rgba(56, 189, 248, 0.4); color: #fff; transform: translateY(-2px); }
#nqc .ch button.on { background: linear-gradient(135deg, #38bdf8 0%, #2563eb 100%); color: #0f172a; border-color: transparent; font-weight: 800; box-shadow: 0 4px 15px rgba(56, 189, 248, 0.35); }

.social-hub-row { display: flex; justify-content: center; gap: 12px; margin-bottom: 24px; flex-wrap: wrap; }
.social-btn { display: inline-flex; align-items: center; gap: 6px; padding: 8px 16px; border-radius: 999px; background: rgba(30, 41, 59, 0.7); border: 1px solid rgba(255,255,255,0.1); color: #cbd5e1; font-size: 12px; font-weight: 700; text-decoration: none; transition: all 0.2s ease; backdrop-filter: blur(8px); }
.social-btn:hover { border-color: #38bdf8; color: #38bdf8; transform: translateY(-2px); }

#nqc .g { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 24px; }
#nqc .c { background: rgba(15, 23, 42, 0.7); backdrop-filter: blur(16px); border: 1px solid rgba(255, 255, 255, 0.08); border-radius: 22px; overflow: hidden; display: flex; flex-direction: column; transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); box-shadow: 0 10px 30px rgba(0,0,0,0.3); }
#nqc .c:hover { transform: translateY(-6px); border-color: rgba(56, 189, 248, 0.4); box-shadow: 0 20px 40px rgba(56, 189, 248, 0.15); }

.img-wrap { position: relative; width: 100%; aspect-ratio: 1; background: #080c14; overflow: hidden; }
#nqc .c img { width: 100%; height: 100%; object-fit: cover; display: block; transition: transform 0.5s ease; cursor: zoom-in; }
#nqc .c:hover img { transform: scale(1.05); }

.stock-tag { position: absolute; top: 12px; left: 12px; background: rgba(15, 23, 42, 0.85); backdrop-filter: blur(12px); border: 1px solid rgba(34, 197, 94, 0.3); color: #4ade80; font-size: 10px; font-weight: 700; text-transform: uppercase; padding: 5px 12px; border-radius: 999px; letter-spacing: 0.5px; }

.content-box { padding: 18px; display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between; }
#nqc .c p { margin: 0 0 14px 0; font-size: 13.5px; line-height: 1.5; color: #cbd5e1; font-weight: 500; }

.features-row { display: flex; gap: 6px; margin-bottom: 14px; flex-wrap: wrap; }
.feature-pill { font-size: 10px; padding: 4px 10px; border-radius: 6px; background: rgba(56, 189, 248, 0.08); border: 1px solid rgba(56, 189, 248, 0.18); color: #38bdf8; font-weight: 600; }

#nqc .c button.order-btn { width: 100%; padding: 12px; border-radius: 14px; background: linear-gradient(135deg, #38bdf8 0%, #2563eb 100%); color: #fff; font-weight: 700; font-size: 13.5px; border: none; cursor: pointer; transition: all 0.2s ease; box-shadow: 0 4px 15px rgba(37, 99, 235, 0.3); }
#nqc .c button.order-btn:hover { opacity: 0.95; transform: scale(1.02); }

.dynamic-view { display: none; background: rgba(15, 23, 42, 0.85); backdrop-filter: blur(20px); border: 1px solid rgba(255,255,255,0.1); border-radius: 24px; padding: 30px; margin-top: 20px; box-shadow: 0 20px 50px rgba(0,0,0,0.5); }
.dynamic-view.active { display: block; }
.dynamic-view h3 { color: #38bdf8; margin-top: 0; font-size: 22px; }
.dynamic-view p, .dynamic-view li { color: #cbd5e1; font-size: 14px; line-height: 1.6; }
.form-group { margin-bottom: 16px; }
.form-group label { display: block; font-size: 13px; font-weight: 600; color: #fff; margin-bottom: 6px; }
.form-group input, .form-group textarea, .form-group select { width: 100%; padding: 12px; border-radius: 10px; border: 1px solid rgba(255,255,255,0.15); background: rgba(30,41,59,0.8); color: #fff; box-sizing: border-box; font-size: 14px; }
.submit-form-btn { padding: 12px 24px; border-radius: 12px; background: #22c55e; color: #fff; font-weight: 800; border: none; cursor: pointer; box-shadow: 0 4px 15px rgba(34, 197, 94, 0.3); }

.cart-floating-bar { position: fixed; bottom: 20px; left: 50%; transform: translateX(-50%); background: rgba(15, 23, 42, 0.92); backdrop-filter: blur(20px); border: 1px solid rgba(56, 189, 248, 0.35); padding: 12px 24px; border-radius: 999px; z-index: 99999; display: flex; align-items: center; gap: 16px; box-shadow: 0 10px 40px rgba(0,0,0,0.6); }
.cart-floating-bar span { font-size: 13px; font-weight: 600; color: #e2e8f0; }
.cart-floating-bar button { padding: 8px 18px; border-radius: 999px; background: #22c55e; color: #fff; font-weight: 800; font-size: 12px; border: none; cursor: pointer; box-shadow: 0 4px 12px rgba(34, 197, 94, 0.4); }

#nqlb { position: fixed; inset: 0; background: rgba(2, 6, 23, 0.96); backdrop-filter: blur(24px); z-index: 9999999; display: none; align-items: center; justify-content: center; flex-direction: column; padding: 20px; opacity: 0; transition: opacity 0.3s ease; }
#nqlb.open { display: flex; opacity: 1; }
#nqlb img { max-width: 90%; max-height: 65vh; border-radius: 20px; box-shadow: 0 20px 50px rgba(0,0,0,0.7); border: 1px solid rgba(255,255,255,0.1); }
#nqlb p { color: #f8fafc; font-size: 15px; font-weight: 600; text-align: center; margin: 16px 0; max-width: 500px; }
#nqlb button { padding: 12px 28px; border-radius: 999px; background: linear-gradient(135deg, #22c55e 0%, #16a34a 100%); color: #fff; font-weight: 800; font-size: 14px; border: none; cursor: pointer; box-shadow: 0 6px 20px rgba(34, 197, 94, 0.4); }

.footer-links { text-align: center; margin-top: 50px; padding-top: 20px; border-top: 1px solid rgba(255,255,255,0.1); font-size: 12px; color: #94a3b8; display: flex; justify-content: center; gap: 20px; flex-wrap: wrap; }
.footer-links a { color: #38bdf8; text-decoration: none; cursor: pointer; font-weight: 600; }
.footer-links a:hover { text-decoration: underline; }
`;

function setSrc(img, n){
  if(n.indexOf("data:image") === 0) { img.src = n; return; }
  var l=[base+"images/"+n, CDN+n], i=0;
  function nx(){ if(i < l.length) img.src = l[i++]; else img.src = FALL; }
  img.onerror = nx; nx();
}

function init(){
  var st=document.createElement("style"); st.textContent=css; document.head.appendChild(st);
  var sec=document.createElement("section"); sec.id="nqc";
  sec.innerHTML=`
    <div class="nq-header">
      <h2>🛍️ Nqobile's Hub Durban</h2>
      <div class="s">Fast Local Durban CBD & DUT Campus Delivery</div>
    </div>
    <div class="nq-banner">
      <span>🔥 <strong>WEEKLY SPECIAL:</strong> Free Same-Day Doorstep Delivery Around Durban CBD & DUT Campuses!</span>
    </div>

    <div class="social-hub-row">
      <a class="social-btn" href="https://wa.me/${WA}" target="_blank">💬 WhatsApp Hub</a>
      <a class="social-btn" href="https://instagram.com" target="_blank">📸 Instagram</a>
      <a class="social-btn" href="https://facebook.com" target="_blank">👥 Facebook Page</a>
      <a class="social-btn" href="https://tiktok.com" target="_blank">🎵 TikTok Reels</a>
    </div>

    <div class="search-box">
      <svg viewBox="0 0 24 24"><path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/></svg>
      <input type="text" id="nq-search" placeholder="Search hampers, cereals, juices, or flyers...">
    </div>

    <div class="ch"></div>

    <div id="catalog-container">
      <div class="g"></div>
    </div>

    <div id="meeting-view" class="dynamic-view">
      <h3>📅 Schedule a Consultation or Business Meeting</h3>
      <p>Book a meeting with Nqobile's Hub team for bulk campus orders, supplier partnerships, or event catering in Durban.</p>
      <div class="form-group">
        <label>Your Full Name:</label>
        <input type="text" id="meet-name" placeholder="e.g. Banele Gumbi">
      </div>
      <div class="form-group">
        <label>Phone Number / WhatsApp:</label>
        <input type="text" id="meet-phone" placeholder="e.g. 072 123 4567">
      </div>
      <div class="form-group">
        <label>Meeting Purpose:</label>
        <select id="meet-type">
          <option value="Bulk Order Consultation">📦 Bulk Campus / Household Order</option>
          <option value="Partnership & Supplier">🤝 Business Partnership</option>
          <option value="General Inquiry">💬 General Inquiry</option>
        </select>
      </div>
      <div class="form-group">
        <label>Preferred Date & Time:</label>
        <input type="datetime-local" id="meet-datetime">
      </div>
      <button class="submit-form-btn" id="submit-meet">📅 Confirm & Send via WhatsApp</button>
    </div>

    <div id="popia-view" class="dynamic-view">
      <h3>🔒 POPIA Compliance & Privacy Policy</h3>
      <p><strong>Nqobile's Hub</strong> is committed to protecting your personal information in accordance with the Protection of Personal Information Act (POPIA) of South Africa.</p>
      <p><strong>1. Information We Collect:</strong> We collect only necessary details required to process your orders and local deliveries (e.g., Name, Phone Number, and Delivery Address in Durban).</p>
      <p><strong>2. Purpose of Processing:</strong> Your information is used strictly to fulfill customer purchases, coordinate campus deliveries via WhatsApp or direct communication, and improve our services.</p>
      <p><strong>3. Security Safeguards:</strong> We do not sell, rent, or trade your personal data to third parties. All communications are securely encrypted via WhatsApp and standard web protocols.</p>
      <p><strong>4. Your Rights:</strong> You have the right to request access to your stored personal data or ask for its deletion at any time by contacting us directly.</p>
    </div>

    <div class="footer-links">
      <span>© 2026 Nqobile's Hub Durban</span>
      <a id="nav-catalog">🛍️ Catalog</a>
      <a id="nav-meeting">📅 Book Meeting</a>
      <a id="nav-popia">🔒 POPIA & Privacy Policy</a>
    </div>
  `;

  var ch=sec.querySelector(".ch"), g=sec.querySelector(".g");
  var catalogContainer = sec.querySelector("#catalog-container");
  var meetingView = sec.querySelector("#meeting-view");
  var popiaView = sec.querySelector("#popia-view");

  var tabButtons = {};

  Object.keys(TABS).forEach(function(k){
    var b=document.createElement("button");
    b.textContent=TABS[k];
    b.dataset.tab=k;
    if(k==="all") b.className="on";
    ch.appendChild(b);
    tabButtons[k] = b;
  });

  function switchTab(tabKey) {
    Object.keys(tabButtons).forEach(function(k){
      tabButtons[k].classList.toggle("on", k === tabKey);
    });

    if(tabKey === "meeting") {
      catalogContainer.style.display = "none";
      meetingView.classList.add("active");
      popiaView.classList.remove("active");
    } else if(tabKey === "popia") {
      catalogContainer.style.display = "none";
      meetingView.classList.remove("active");
      popiaView.classList.add("active");
    } else {
      catalogContainer.style.display = "block";
      meetingView.classList.remove("active");
      popiaView.classList.remove("active");
      renderGrid(tabKey, sec.querySelector("#nq-search").value);
    }
  }

  function renderGrid(activeTab, searchQuery) {
    g.innerHTML = "";
    P.forEach(function(p){
      var isTrending = (p.c === 'flyer' || p.c === 'juice' || p.t.toLowerCase().includes('special') || p.t.toLowerCase().includes('combo'));
      var isBundle = (p.c === 'hamper' || p.c === 'bulk' || p.t.toLowerCase().includes('hamper') || p.t.toLowerCase().includes('box'));
      var isPantry = (p.c === 'cereal' || p.c === 'juice' || p.t.toLowerCase().includes('cereal') || p.t.toLowerCase().includes('noodles'));
      var isCampus = (p.t.toLowerCase().includes('student') || p.t.toLowerCase().includes('campus') || p.c === 'flyer');

      var matchTab = true;
      if(activeTab === "trending") matchTab = isTrending;
      else if(activeTab === "bundle") matchTab = isBundle;
      else if(activeTab === "pantry") matchTab = isPantry;
      else if(activeTab === "campus") matchTab = isCampus;

      var matchSearch = (!searchQuery || p.t.toLowerCase().includes(searchQuery.toLowerCase()));
      if(!matchTab || !matchSearch) return;
      
      var d=document.createElement("div"); d.className="c";
      d.innerHTML=`
        <div class="img-wrap">
          <div class="stock-tag">⚡ In Stock</div>
          <img alt="${p.t}" loading="lazy">
        </div>
        <div class="content-box">
          <p>${p.t}</p>
          <div class="features-row">
            <span class="feature-pill">✓ Verified Fresh</span>
            <span class="feature-pill">✓ Durban Express</span>
          </div>
          <button class="order-btn">💬 Order via WhatsApp</button>
        </div>
      `;
      setSrc(d.querySelector("img"), p.n);

      var triggerWhatsApp = function(){
        var msg = "Hi Nqobile's Hub, I would like to order: " + p.t + ". Please confirm availability and delivery details!";
        window.open("https://wa.me/" + WA + "?text=" + encodeURIComponent(msg), "_blank");
      };

      d.querySelector(".order-btn").addEventListener("click", triggerWhatsApp);
      d.querySelector("img").addEventListener("click", function(){
        lb.querySelector("img").src = this.src;
        lb.querySelector("p").textContent = p.t;
        lb.classList.add("open");
      });

      g.appendChild(d);
    });
  }

  renderGrid("all", "");

  ch.addEventListener("click",function(e){
    var b=e.target.closest("button"); if(!b) return;
    switchTab(b.dataset.tab);
  });

  sec.querySelector("#nq-search").addEventListener("input", function(e){
    var activeBtn = ch.querySelector("button.on");
    var activeKey = activeBtn ? activeBtn.dataset.tab : "all";
    if(activeKey !== "meeting" && activeKey !== "popia") {
      renderGrid(activeKey, e.target.value);
    }
  });

  sec.querySelector("#nav-catalog").addEventListener("click", function(){ switchTab("all"); window.scrollTo({top:0, behavior:'smooth'}); });
  sec.querySelector("#nav-meeting").addEventListener("click", function(){ switchTab("meeting"); window.scrollTo({top:0, behavior:'smooth'}); });
  sec.querySelector("#nav-popia").addEventListener("click", function(){ switchTab("popia"); window.scrollTo({top:0, behavior:'smooth'}); });

  sec.querySelector("#submit-meet").addEventListener("click", function(){
    var name = sec.querySelector("#meet-name").value || "Valued Client";
    var phone = sec.querySelector("#meet-phone").value || "N/A";
    var type = sec.querySelector("#meet-type").value;
    var dt = sec.querySelector("#meet-datetime").value || "As soon as possible";
    var m = "📅 *MEETING / CONSULTATION REQUEST*\n👤 Name: " + name + "\n📞 Phone: " + phone + "\n🎯 Type: " + type + "\n🕒 Time: " + dt;
    window.open("https://wa.me/" + WA + "?text=" + encodeURIComponent(m), "_blank");
  });

  var floatBar = document.createElement("div"); floatBar.className = "cart-floating-bar";
  floatBar.innerHTML = `
    <span>💬 Need a custom bulk order?</span>
    <button id="float-wa-btn">Chat on WhatsApp</button>
  `;
  document.body.appendChild(floatBar);
  floatBar.querySelector("#float-wa-btn").addEventListener("click", function(){
    window.open("https://wa.me/" + WA + "?text=" + encodeURIComponent("Hi Nqobile's Hub, I would like to inquire about a custom bulk order or delivery."), "_blank");
  });

  var lb=document.createElement("div"); lb.id="nqlb";
  lb.innerHTML=`<img alt=""><p></p><button id="lb-order-btn">💬 Quick Order on WhatsApp</button>`;
  lb.addEventListener("click",function(e){ if(e.target.tagName!=="BUTTON" && e.target.tagName!=="IMG") lb.classList.remove("open"); });
  lb.querySelector("#lb-order-btn").addEventListener("click", function(){
    var title = lb.querySelector("p").textContent;
    window.open("https://wa.me/" + WA + "?text=" + encodeURIComponent("Hi Nqobile's Hub, I want to order: " + title), "_blank");
    lb.classList.remove("open");
  });

  document.body.appendChild(sec);
}

if(document.readyState==="loading") document.addEventListener("DOMContentLoaded", init); else init();
})();
