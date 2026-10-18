(function(){
if(window.__nqCat)return;window.__nqCat=1;
var OWNER="banele477",REPO="nollies-site",BRANCH="main",WA="27625873479";
var P=window.NQ_PHOTOS||[];
P = P.filter(function(x){ return x && x.n && x.t; });
if(!P.length)return;

var base=location.pathname.replace(/[^\/]*$/,"");
var CDN="https://cdn.jsdelivr.net/gh/"+OWNER+"/"+REPO+"@"+BRANCH+"/public/images/";

// Luxury Branded Visual Asset Generator
function makeCardSvg(title, category){
  var bg = "#090d16", accent = "#f59e0b", icon = "👑";
  var tLower = title.toLowerCase();
  if(category === "juice" || tLower.includes("juice") || tLower.includes("concentrate")){ bg = "#022c22"; accent = "#34d399"; icon = "✨"; }
  else if(category === "hamper" || tLower.includes("hamper") || tLower.includes("breakfast")){ bg = "#172554"; accent = "#60a5fa"; icon = "💎"; }
  else if(category === "cereal" || tLower.includes("cereal") || tLower.includes("noodles") || tLower.includes("oats")){ bg = "#451a03"; accent = "#fbbf24"; icon = "🌟"; }
  else if(category === "flyer" || tLower.includes("flyer") || tLower.includes("poster") || tLower.includes("supply")){ bg = "#500724"; accent = "#f43f5e"; icon = "🔥"; }

  var safeTitle = title.length > 30 ? title.substring(0, 28) + "..." : title;
  return "data:image/svg+xml;utf8," + encodeURIComponent(
    "<svg xmlns='http://www.w3.org/2000/svg' width='800' height='800' viewBox='0 0 800 800'>" +
    "<defs><linearGradient id='bg' x1='0' y1='0' x2='1' y2='1'><stop offset='0%' stop-color='" + bg + "'/><stop offset='100%' stop-color='#020617'/></linearGradient></defs>" +
    "<rect width='100%' height='100%' fill='url(#bg)'/>" +
    "<rect x='30' y='30' width='740' height='740' rx='36' fill='none' stroke='" + accent + "' stroke-width='3' opacity='0.4'/>" +
    "<circle cx='400' cy='300' r='100' fill='" + accent + "' opacity='0.1'/>" +
    "<text x='400' y='335' font-size='90' text-anchor='middle'>" + icon + "</text>" +
    "<text x='400' y='460' fill='#ffffff' font-family='system-ui, sans-serif' font-size='26' font-weight='900' letter-spacing='3px' text-anchor='middle'>NQOBILE'S HUB</text>" +
    "<text x='400' y='510' fill='" + accent + "' font-family='system-ui, sans-serif' font-size='18' font-weight='700' text-anchor='middle'>" + safeTitle + "</text>" +
    "<rect x='240' y='600' width='320' height='56' rx='28' fill='" + accent + "'/>" +
    "<text x='400' y='636' fill='#0f172a' font-family='system-ui, sans-serif' font-size='16' font-weight='900' letter-spacing='1px' text-anchor='middle'>OFFICIAL BRAND STORE</text>" +
    "</svg>"
  );
}

var TABS={
  all:"👑 All Collections",
  trending:"✨ Luxury Trends",
  bundle:"💎 Bulk & Hampers",
  pantry:"🌟 Pantry Essentials",
  campus:"🎓 DUT Campus Elite",
  meeting:"📅 VIP Consultation",
  popia:"🔒 Privacy & POPIA"
};

var css=`
#nqc { max-width: 1200px; margin: 40px auto 120px; padding: 0 16px; color: #f8fafc; font-family: system-ui, -apple-system, sans-serif; }
#nqc .nq-header { text-align: center; margin-bottom: 28px; }
#nqc h2 { font-size: 36px; font-weight: 900; background: linear-gradient(135deg, #ffffff 0%, #fbbf24 50%, #f59e0b 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; margin: 0 0 8px 0; letter-spacing: -0.5px; }
#nqc .s { color: #94a3b8; font-size: 14px; font-weight: 600; letter-spacing: 1px; text-transform: uppercase; }

/* Luxury Brand Banner */
.nq-banner { background: linear-gradient(135deg, rgba(245, 158, 11, 0.15), rgba(59, 130, 246, 0.15)); border: 1px solid rgba(245, 158, 11, 0.4); border-radius: 20px; padding: 14px 24px; text-align: center; margin-bottom: 28px; font-size: 13.5px; color: #fbbf24; font-weight: 700; display: flex; align-items: center; justify-content: center; gap: 10px; backdrop-filter: blur(16px); box-shadow: 0 10px 30px rgba(0,0,0,0.3); }

/* Luxury Glass Search Bar */
.search-box { max-width: 540px; margin: 0 auto 24px; position: relative; }
.search-box input { width: 100%; padding: 15px 20px 15px 48px; border-radius: 999px; border: 1px solid rgba(245, 158, 11, 0.3); background: rgba(15, 23, 42, 0.9); backdrop-filter: blur(20px); color: #fff; font-size: 14px; outline: none; box-sizing: border-box; transition: all 0.3s ease; box-shadow: 0 4px 25px rgba(0,0,0,0.4); }
.search-box input:focus { border-color: #fbbf24; box-shadow: 0 0 25px rgba(251, 191, 36, 0.3); }
.search-box svg { position: absolute; left: 18px; top: 50%; transform: translateY(-50%); width: 18px; height: 18px; fill: #fbbf24; }

/* Branded Luxury Tabs */
#nqc .ch { display: flex; gap: 10px; overflow-x: auto; padding: 4px 4px 20px; scrollbar-width: none; justify-content: center; flex-wrap: wrap; }
#nqc .ch::-webkit-scrollbar { display: none; }
#nqc .ch button { flex: none; padding: 11px 20px; border-radius: 999px; border: 1px solid rgba(255, 255, 255, 0.1); background: rgba(30, 41, 59, 0.7); color: #cbd5e1; font-weight: 600; font-size: 13px; cursor: pointer; transition: all 0.25s ease; backdrop-filter: blur(10px); }
#nqc .ch button:hover { border-color: #fbbf24; color: #fff; transform: translateY(-2px); }
#nqc .ch button.on { background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%); color: #0f172a; border-color: transparent; font-weight: 900; box-shadow: 0 6px 20px rgba(245, 158, 11, 0.4); }

/* Social Media VIP Row */
.social-hub-row { display: flex; justify-content: center; gap: 12px; margin-bottom: 28px; flex-wrap: wrap; }
.social-btn { display: inline-flex; align-items: center; gap: 6px; padding: 9px 18px; border-radius: 999px; background: rgba(30, 41, 59, 0.8); border: 1px solid rgba(245, 158, 11, 0.2); color: #cbd5e1; font-size: 12px; font-weight: 700; text-decoration: none; transition: all 0.2s ease; backdrop-filter: blur(10px); }
.social-btn:hover { border-color: #fbbf24; color: #fbbf24; transform: translateY(-2px); box-shadow: 0 4px 15px rgba(245, 158, 11, 0.2); }

/* Product Grid & Luxury Cards */
#nqc .g { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 24px; }
#nqc .c { background: rgba(15, 23, 42, 0.8); backdrop-filter: blur(20px); border: 1px solid rgba(245, 158, 11, 0.2); border-radius: 24px; overflow: hidden; display: flex; flex-direction: column; transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); box-shadow: 0 15px 35px rgba(0,0,0,0.4); }
#nqc .c:hover { transform: translateY(-6px); border-color: #fbbf24; box-shadow: 0 20px 45px rgba(245, 158, 11, 0.2); }

.img-wrap { position: relative; width: 100%; aspect-ratio: 1; background: #080c14; overflow: hidden; }
#nqc .c img { width: 100%; height: 100%; object-fit: cover; display: block; transition: transform 0.5s ease; cursor: zoom-in; }
#nqc .c:hover img { transform: scale(1.05); }

.stock-tag { position: absolute; top: 12px; left: 12px; background: rgba(15, 23, 42, 0.9); backdrop-filter: blur(12px); border: 1px solid rgba(245, 158, 11, 0.4); color: #fbbf24; font-size: 10px; font-weight: 800; text-transform: uppercase; padding: 5px 12px; border-radius: 999px; letter-spacing: 1px; z-index: 2; }

.content-box { padding: 20px; display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between; }
#nqc .c p { margin: 0 0 14px 0; font-size: 14px; line-height: 1.5; color: #f8fafc; font-weight: 600; }

.features-row { display: flex; gap: 6px; margin-bottom: 16px; flex-wrap: wrap; }
.feature-pill { font-size: 10px; padding: 4px 10px; border-radius: 6px; background: rgba(245, 158, 11, 0.1); border: 1px solid rgba(245, 158, 11, 0.3); color: #fbbf24; font-weight: 700; }

#nqc .c button.order-btn { width: 100%; padding: 13px; border-radius: 14px; background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%); color: #0f172a; font-weight: 900; font-size: 14px; border: none; cursor: pointer; transition: all 0.2s ease; box-shadow: 0 6px 20px rgba(245, 158, 11, 0.4); letter-spacing: 0.5px; }
#nqc .c button.order-btn:hover { opacity: 0.95; transform: scale(1.02); }

.dynamic-view { display: none; background: rgba(15, 23, 42, 0.9); backdrop-filter: blur(24px); border: 1px solid rgba(245, 158, 11, 0.3); border-radius: 28px; padding: 32px; margin-top: 20px; box-shadow: 0 25px 60px rgba(0,0,0,0.6); }
.dynamic-view.active { display: block; }
.dynamic-view h3 { color: #fbbf24; margin-top: 0; font-size: 24px; font-weight: 900; }
.dynamic-view p, .dynamic-view li { color: #cbd5e1; font-size: 14px; line-height: 1.7; }
.form-group { margin-bottom: 18px; }
.form-group label { display: block; font-size: 13px; font-weight: 700; color: #fbbf24; margin-bottom: 6px; }
.form-group input, .form-group textarea, .form-group select { width: 100%; padding: 13px; border-radius: 12px; border: 1px solid rgba(245, 158, 11, 0.3); background: rgba(30,41,59,0.8); color: #fff; box-sizing: border-box; font-size: 14px; }
.submit-form-btn { padding: 13px 26px; border-radius: 12px; background: linear-gradient(135deg, #22c55e 0%, #16a34a 100%); color: #fff; font-weight: 900; border: none; cursor: pointer; box-shadow: 0 6px 20px rgba(34, 197, 94, 0.4); }

.cart-floating-bar { position: fixed; bottom: 20px; left: 50%; transform: translateX(-50%); background: rgba(15, 23, 42, 0.95); backdrop-filter: blur(24px); border: 1px solid rgba(245, 158, 11, 0.5); padding: 14px 28px; border-radius: 999px; z-index: 99999; display: flex; align-items: center; gap: 16px; box-shadow: 0 15px 50px rgba(0,0,0,0.7); }
.cart-floating-bar span { font-size: 13.5px; font-weight: 700; color: #f8fafc; }
.cart-floating-bar button { padding: 9px 20px; border-radius: 999px; background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%); color: #0f172a; font-weight: 900; font-size: 12.5px; border: none; cursor: pointer; box-shadow: 0 4px 15px rgba(245, 158, 11, 0.4); }

#nqlb { position: fixed; inset: 0; background: rgba(2, 6, 23, 0.97); backdrop-filter: blur(28px); z-index: 9999999; display: none; align-items: center; justify-content: center; flex-direction: column; padding: 20px; opacity: 0; transition: opacity 0.3s ease; }
#nqlb.open { display: flex; opacity: 1; }
#nqlb img { max-width: 90%; max-height: 65vh; border-radius: 24px; box-shadow: 0 25px 60px rgba(0,0,0,0.8); border: 1px solid rgba(245, 158, 11, 0.4); }
#nqlb p { color: #f8fafc; font-size: 16px; font-weight: 700; text-align: center; margin: 16px 0; max-width: 500px; }
#nqlb button { padding: 13px 30px; border-radius: 999px; background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%); color: #0f172a; font-weight: 900; font-size: 14px; border: none; cursor: pointer; box-shadow: 0 8px 25px rgba(245, 158, 11, 0.5); }

.footer-links { text-align: center; margin-top: 50px; padding-top: 20px; border-top: 1px solid rgba(255,255,255,0.1); font-size: 12px; color: #94a3b8; display: flex; justify-content: center; gap: 20px; flex-wrap: wrap; }
.footer-links a { color: #fbbf24; text-decoration: none; cursor: pointer; font-weight: 700; }
.footer-links a:hover { text-decoration: underline; }
`;

function setSrc(img, p){
  var n = p.n;
  if(n.indexOf("data:image") === 0) { img.src = n; return; }
  img.src = makeCardSvg(p.t, p.c);
}

function init(){
  var st=document.createElement("style"); st.textContent=css; document.head.appendChild(st);
  var sec=document.createElement("section"); sec.id="nqc";
  sec.innerHTML=`
    <div class="nq-header">
      <h2>👑 NQOBILE'S LUXURY HUB</h2>
      <div class="s">Official Durban CBD & DUT Campus Elite Store</div>
    </div>
    <div class="nq-banner">
      <span>✨ <strong>VIP MEMBER PERK:</strong> Free Priority Express Delivery Across Durban CBD & DUT Campuses!</span>
    </div>

    <div class="social-hub-row">
      <a class="social-btn" href="https://wa.me/${WA}" target="_blank">💬 VIP WhatsApp</a>
      <a class="social-btn" href="https://instagram.com" target="_blank">📸 Instagram</a>
      <a class="social-btn" href="https://facebook.com" target="_blank">👥 Facebook Page</a>
      <a class="social-btn" href="https://tiktok.com" target="_blank">🎵 TikTok Reels</a>
    </div>

    <div class="search-box">
      <svg viewBox="0 0 24 24"><path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/></svg>
      <input type="text" id="nq-search" placeholder="Search luxury hampers, premium cereals, juices...">
    </div>

    <div class="ch"></div>

    <div id="catalog-container">
      <div class="g"></div>
    </div>

    <div id="meeting-view" class="dynamic-view">
      <h3>📅 Schedule a VIP Consultation</h3>
      <p>Book an exclusive appointment with Nqobile's Hub management for bulk corporate orders, private campus supply, or partnerships.</p>
      <div class="form-group">
        <label>Your Full Name:</label>
        <input type="text" id="meet-name" placeholder="e.g. Banele Gumbi">
      </div>
      <div class="form-group">
        <label>Phone Number / WhatsApp:</label>
        <input type="text" id="meet-phone" placeholder="e.g. 072 123 4567">
      </div>
      <div class="form-group">
        <label>Appointment Type:</label>
        <select id="meet-type">
          <option value="VIP Bulk Order">📦 VIP Bulk Order Inquiry</option>
          <option value="Business Partnership">🤝 Strategic Partnership</option>
          <option value="General Inquiry">💬 General Consultation</option>
        </select>
      </div>
      <div class="form-group">
        <label>Preferred Date & Time:</label>
        <input type="datetime-local" id="meet-datetime">
      </div>
      <button class="submit-form-btn" id="submit-meet">📅 Confirm Appointment via WhatsApp</button>
    </div>

    <div id="popia-view" class="dynamic-view">
      <h3>🔒 POPIA Compliance & Privacy Charter</h3>
      <p><strong>Nqobile's Hub</strong> adheres strictly to the Protection of Personal Information Act (POPIA) of South Africa to safeguard your client data.</p>
      <p><strong>1. Data Collection:</strong> We collect only essential details (Name, Contact Number, Delivery Location) required for secure local order fulfillment in Durban.</p>
      <p><strong>2. Confidentiality:</strong> Your information remains strictly confidential and is never shared, sold, or exposed to third parties.</p>
      <p><strong>3. Secure Transactions:</strong> All communications occur over encrypted channels directly via official business WhatsApp protocols.</p>
    </div>

    <div class="footer-links">
      <span>© 2026 Nqobile's Luxury Hub Durban</span>
      <a id="nav-catalog">👑 Collections</a>
      <a id="nav-meeting">📅 VIP Booking</a>
      <a id="nav-popia">🔒 Privacy Policy</a>
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
          <div class="stock-tag">👑 Verified Stock</div>
          <img alt="${p.t}" loading="lazy">
        </div>
        <div class="content-box">
          <p>${p.t}</p>
          <div class="features-row">
            <span class="feature-pill">✨ Premium Grade</span>
            <span class="feature-pill">⚡ VIP Express</span>
          </div>
          <button class="order-btn">👑 Secure Order via WhatsApp</button>
        </div>
      `;
      setSrc(d.querySelector("img"), p);

      var triggerWhatsApp = function(){
        var msg = "Hi Nqobile's Luxury Hub, I would like to order: " + p.t + ". Please confirm availability and priority delivery!";
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
    var name = sec.querySelector("#meet-name").value || "Valued VIP Client";
    var phone = sec.querySelector("#meet-phone").value || "N/A";
    var type = sec.querySelector("#meet-type").value;
    var dt = sec.querySelector("#meet-datetime").value || "As soon as possible";
    var m = "📅 *VIP CONSULTATION REQUEST*\n👤 Name: " + name + "\n📞 Phone: " + phone + "\n🎯 Type: " + type + "\n🕒 Time: " + dt;
    window.open("https://wa.me/" + WA + "?text=" + encodeURIComponent(m), "_blank");
  });

  var floatBar = document.createElement("div"); floatBar.className = "cart-floating-bar";
  floatBar.innerHTML = `
    <span>👑 Need custom VIP wholesale?</span>
    <button id="float-wa-btn">VIP WhatsApp</button>
  `;
  document.body.appendChild(floatBar);
  floatBar.querySelector("#float-wa-btn").addEventListener("click", function(){
    window.open("https://wa.me/" + WA + "?text=" + encodeURIComponent("Hi Nqobile's Luxury Hub, I would like to inquire about a custom VIP wholesale order."), "_blank");
  });

  var lb=document.createElement("div"); lb.id="nqlb";
  lb.innerHTML=`<img alt=""><p></p><button id="lb-order-btn">👑 Secure Order via WhatsApp</button>`;
  lb.addEventListener("click",function(e){ if(e.target.tagName!=="BUTTON" && e.target.tagName!=="IMG") lb.classList.remove("open"); });
  lb.querySelector("#lb-order-btn").addEventListener("click", function(){
    var title = lb.querySelector("p").textContent;
    window.open("https://wa.me/" + WA + "?text=" + encodeURIComponent("Hi Nqobile's Luxury Hub, I want to order: " + title), "_blank");
    lb.classList.remove("open");
  });

  document.body.appendChild(sec);
}

if(document.readyState==="loading") document.addEventListener("DOMContentLoaded", init); else init();
})();
