(function(){
if(window.__nqCat)return;window.__nqCat=1;
var OWNER="banele477",REPO="nollies-site",BRANCH="main",WA="27625873479";
var P=window.NQ_PHOTOS||[];
P = P.filter(function(x){ return x && x.n && x.t; });
if(!P.length)return;

var base=location.pathname.replace(/[^\/]*$/,"");
var CDN="https://cdn.jsdelivr.net/gh/"+OWNER+"/"+REPO+"@"+BRANCH+"/public/images/";
var FALL="data:image/svg+xml;utf8,"+encodeURIComponent("<svg xmlns='http://www.w3.org/2000/svg' width='600' height='600'><rect width='100%' height='100%' fill='#1e1b4b'/><text x='50%' y='50%' fill='#94a3b8' font-size='20' text-anchor='middle'>Nqobile's Hub Item</text></svg>");

var CATS={
  all:"✨ All Items",
  bundle:"📦 Combos & Hampers",
  pantry:"🥣 Pantry & Drinks",
  flyer:"🎯 Flyers & Specials"
};

var css=`
#nqc { max-width: 1200px; margin: 30px auto 100px; padding: 0 16px; color: #f8fafc; font-family: system-ui, -apple-system, sans-serif; }
#nqc .nq-header { text-align: center; margin-bottom: 20px; }
#nqc h2 { font-size: 28px; font-weight: 800; background: linear-gradient(135deg, #f8fafc 0%, #38bdf8 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; margin: 0 0 6px 0; }
#nqc .s { color: #94a3b8; font-size: 14px; font-weight: 500; }

.search-box { max-width: 500px; margin: 0 auto 20px; position: relative; }
.search-box input { width: 100%; padding: 12px 18px; border-radius: 999px; border: 1px solid rgba(255, 255, 255, 0.15); background: rgba(15, 23, 42, 0.85); backdrop-filter: blur(12px); color: #fff; font-size: 14px; outline: none; box-sizing: border-box; }

#nqc .ch { display: flex; gap: 10px; overflow-x: auto; padding: 4px 4px 16px; scrollbar-width: none; justify-content: center; }
#nqc .ch button { flex: none; padding: 10px 18px; border-radius: 999px; border: 1px solid rgba(255, 255, 255, 0.12); background: rgba(30, 41, 59, 0.7); color: #cbd5e1; font-weight: 600; font-size: 13px; cursor: pointer; }
#nqc .ch button.on { background: linear-gradient(135deg, #38bdf8 100%, #2563eb 0%); color: #0f172a; border-color: transparent; font-weight: 700; }

#nqc .g { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 20px; }
#nqc .c { background: rgba(15, 23, 42, 0.75); border: 1px solid rgba(255, 255, 255, 0.08); border-radius: 20px; overflow: hidden; display: flex; flex-direction: column; }

.img-wrap { position: relative; width: 100%; aspect-ratio: 1; background: #090d16; overflow: hidden; }
#nqc .c img { width: 100%; height: 100%; object-fit: cover; display: block; cursor: zoom-in; }

.content-box { padding: 16px; display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between; }
#nqc .c p { margin: 0 0 10px 0; font-size: 13px; line-height: 1.45; color: #cbd5e1; }

#nqc .c button.pay-btn { width: 100%; padding: 11px; border-radius: 12px; background: linear-gradient(135deg, #38bdf8 0%, #2563eb 100%); color: #fff; font-weight: 700; font-size: 13px; border: none; cursor: pointer; }
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
      <h2>🛍️ Nqobile's Hub Catalog</h2>
      <div class="s">Fast Local Durban CBD & DUT Campus Delivery</div>
    </div>
    <div class="search-box">
      <input type="text" id="nq-search" placeholder="Search catalog items...">
    </div>
    <div class="ch"></div>
    <div class="g"></div>
  `;
  var ch=sec.querySelector(".ch"), g=sec.querySelector(".g");

  Object.keys(CATS).forEach(function(k){
    var b=document.createElement("button"); b.textContent=CATS[k]; b.dataset.k=k; if(k==="all") b.className="on";
    ch.appendChild(b);
  });

  function renderGrid(filterCat, searchQuery) {
    g.innerHTML = "";
    P.forEach(function(p){
      var catMapped = (p.c === 'hamper' || p.c === 'bulk') ? 'bundle' : (p.c === 'cereal' || p.c === 'juice') ? 'pantry' : p.c;
      var matchCat = (filterCat==="all" || catMapped===filterCat);
      var matchSearch = (!searchQuery || p.t.toLowerCase().includes(searchQuery.toLowerCase()));
      if(!matchCat || !matchSearch) return;
      
      var d=document.createElement("div"); d.className="c";
      d.innerHTML=`
        <div class="img-wrap"><img alt="${p.t}" loading="lazy"></div>
        <div class="content-box">
          <p>${p.t}</p>
          <button class="pay-btn">💬 Order via WhatsApp</button>
        </div>
      `;
      setSrc(d.querySelector("img"), p.n);
      d.querySelector(".pay-btn").addEventListener("click", function(){
        window.open("https://wa.me/" + WA + "?text=" + encodeURIComponent("Hi Nqobile's Hub, I want to order: " + p.t), "_blank");
      });
      g.appendChild(d);
    });
  }

  renderGrid("all", "");

  ch.addEventListener("click",function(e){
    var b=e.target.closest("button"); if(!b) return;
    ch.querySelectorAll("button").forEach(function(x){ x.classList.toggle("on", x===b); });
    renderGrid(b.dataset.k, sec.querySelector("#nq-search").value);
  });

  sec.querySelector("#nq-search").addEventListener("input", function(e){
    var activeBtn = ch.querySelector("button.on");
    renderGrid(activeBtn ? activeBtn.dataset.k : "all", e.target.value);
  });

  document.body.appendChild(sec);
}

if(document.readyState==="loading") document.addEventListener("DOMContentLoaded", init); else init();
})();
