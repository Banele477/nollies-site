(function(){
if(window.__nqCat)return;window.__nqCat=1;
var OWNER="banele477",REPO="nollies-site",BRANCH="main",WA="27625873479";
var P=window.NQ_PHOTOS||[];if(!P.length)return;
var base=location.pathname.replace(/[^\/]*$/,"");
var CDN="https://cdn.jsdelivr.net/gh/"+OWNER+"/"+REPO+"@"+BRANCH+"/public/images/";
var FALL="data:image/svg+xml;utf8,"+encodeURIComponent("<svg xmlns='http://www.w3.org/2000/svg' width='600' height='600'><defs><linearGradient id='g' x1='0%' y1='0%' x2='100%' y2='100%'><stop offset='0%' stop-color='#1e1b4b'/><stop offset='100%' stop-color='#0f172a'/></linearGradient></defs><rect width='100%' height='100%' fill='url(#g)'/><text x='50%' y='50%' fill='#94a3b8' font-family='sans-serif' font-size='20' font-weight='600' text-anchor='middle'>Nqobile's Hub</text></svg>");

var CATS={all:"✨ All Items",hamper:"🧺 Hampers",cereal:"🥣 Cereals",juice:"🧃 Juices",bulk:"📦 Bulk Boxes",flyer:"📄 Flyers & Posters"};

var css=`
#nqc {
  max-width: 1200px;
  margin: 30px auto 120px;
  padding: 0 16px;
  color: #f8fafc;
  font-family: system-ui, -apple-system, sans-serif;
}
#nqc .nq-header {
  text-align: center;
  margin-bottom: 24px;
}
#nqc h2 {
  font-size: 26px;
  font-weight: 800;
  background: linear-gradient(135deg, #f8fafc 0%, #94a3b8 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  margin: 0 0 6px 0;
  letter-spacing: -0.5px;
}
#nqc .s {
  color: #94a3b8;
  font-size: 14px;
  font-weight: 500;
}
#nqc .ch {
  display: flex;
  gap: 10px;
  overflow-x: auto;
  padding: 8px 4px 16px;
  scrollbar-width: none;
  -webkit-overflow-scrolling: touch;
}
#nqc .ch::-webkit-scrollbar { display: none; }
#nqc .ch button {
  flex: none;
  padding: 10px 18px;
  border-radius: 999px;
  border: 1px solid rgba(255, 255, 255, 0.12);
  background: rgba(30, 41, 59, 0.7);
  backdrop-filter: blur(8px);
  color: #cbd5e1;
  font-weight: 600;
  font-size: 13px;
  cursor: pointer;
  transition: all 0.2s ease;
}
#nqc .ch button:hover {
  border-color: rgba(255, 255, 255, 0.3);
  color: #fff;
}
#nqc .ch button.on {
  background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
  color: #fff;
  border-color: transparent;
  box-shadow: 0 4px 14px rgba(59, 130, 246, 0.4);
}
#nqc .g {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
  gap: 18px;
}
#nqc .c {
  background: rgba(15, 23, 42, 0.75);
  backdrop-filter: blur(12px);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 20px;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.3);
  transition: transform 0.2s ease, border-color 0.2s ease;
}
#nqc .c:hover {
  transform: translateY(-3px);
  border-color: rgba(59, 130, 246, 0.4);
}
#nqc .img-wrap {
  position: relative;
  width: 100%;
  aspect-ratio: 1;
  background: #090d16;
  overflow: hidden;
}
#nqc .c img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
  cursor: zoom-in;
  transition: transform 0.3s ease;
}
#nqc .c img:hover {
  transform: scale(1.03);
}
#nqc .badge {
  position: absolute;
  top: 12px;
  left: 12px;
  background: rgba(15, 23, 42, 0.85);
  backdrop-filter: blur(8px);
  border: 1px solid rgba(255, 255, 255, 0.15);
  color: #38bdf8;
  font-size: 11px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  padding: 5px 10px;
  border-radius: 999px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.2);
}
#nqc .content-box {
  padding: 14px;
  display: flex;
  flex-direction: column;
  flex-grow: 1;
  justify-content: space-between;
}
#nqc .c p {
  margin: 0 0 14px 0;
  font-size: 13px;
  line-height: 1.45;
  color: #cbd5e1;
  font-weight: 400;
}
#nqc .c a {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  padding: 11px;
  border-radius: 12px;
  background: linear-gradient(135deg, #22c55e 0%, #16a34a 100%);
  color: #fff;
  text-align: center;
  font-weight: 700;
  font-size: 13px;
  text-decoration: none;
  box-shadow: 0 4px 12px rgba(34, 197, 94, 0.3);
  transition: opacity 0.2s ease, transform 0.1s ease;
}
#nqc .c a:active {
  transform: scale(0.98);
}
#nqc .c a:hover {
  opacity: 0.92;
}
#nqlb {
  position: fixed;
  inset: 0;
  background: rgba(2, 6, 23, 0.95);
  backdrop-filter: blur(16px);
  z-index: 999999;
  display: none;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 20px;
  gap: 16px;
}
#nqlb.open { display: flex; }
#nqlb img {
  max-width: 90%;
  max-height: 70vh;
  border-radius: 16px;
  box-shadow: 0 20px 40px rgba(0,0,0,0.6);
  border: 1px solid rgba(255,255,255,0.1);
}
#nqlb p {
  color: #f8fafc;
  font: 14px system-ui, sans-serif;
  text-align: center;
  margin: 0;
  max-width: 500px;
  line-height: 1.4;
}
#nqlb a {
  padding: 12px 24px;
  border-radius: 999px;
  background: #22c55e;
  color: #fff;
  font: 700 14px system-ui, sans-serif;
  text-decoration: none;
  box-shadow: 0 4px 16px rgba(34, 197, 94, 0.4);
}
`;

function wa(t){ return "https://wa.me/"+WA+"?text="+encodeURIComponent("Hi Nqobile's Hub, I'm interested in: "+t); }
function setSrc(img,n){ var l=[base+"images/"+n,base+"public/images/"+n,CDN+n],i=0;function nx(){img.src=i<l.length?l[i++]:FALL}img.onerror=nx;nx(); }

function init(){
  var st=document.createElement("style"); st.textContent=css; document.head.appendChild(st);
  var sec=document.createElement("section"); sec.id="nqc";
  sec.innerHTML=`
    <div class="nq-header">
      <h2>🛍️ Strategic Product Showcases & Flyers</h2>
      <div class="s">Tap any item to enlarge · Connect instantly via WhatsApp</div>
    </div>
    <div class="ch"></div>
    <div class="g"></div>
  `;
  var ch=sec.querySelector(".ch"), g=sec.querySelector(".g");
  var have={all:1}; P.forEach(function(p){ have[p.c]=1; });
  
  Object.keys(CATS).forEach(function(k){
    if(k!=="all" && !have[k]) return;
    var b=document.createElement("button");
    b.textContent=CATS[k]; b.dataset.k=k;
    if(k==="all") b.className="on";
    ch.appendChild(b);
  });

  P.forEach(function(p){
    var badgeText = CATS[p.c] ? CATS[p.c].replace(/^[^\w\s]+\s*/, '') : "Stock";
    var d=document.createElement("div"); d.className="c"; d.dataset.c=p.c;
    d.innerHTML=`
      <div class="img-wrap">
        <div class="badge">${badgeText}</div>
        <img alt="${p.t}" loading="lazy">
      </div>
      <div class="content-box">
        <p>${p.t}</p>
        <a href="${wa(p.t)}" target="_blank" rel="noopener">💬 Ask on WhatsApp</a>
      </div>
    `;
    setSrc(d.querySelector("img"), p.n);
    g.appendChild(d);
  });

  ch.addEventListener("click",function(e){
    var b=e.target.closest("button"); if(!b) return;
    ch.querySelectorAll("button").forEach(function(x){ x.classList.toggle("on", x===b); });
    g.querySelectorAll(".c").forEach(function(c){
      c.style.display=(b.dataset.k==="all" || c.dataset.c===b.dataset.k) ? "" : "none";
    });
  });

  var lb=document.createElement("div"); lb.id="nqlb";
  lb.innerHTML=`<img alt=""><p></p><a target="_blank" rel="noopener">💬 Ask about this on WhatsApp</a>`;
  lb.addEventListener("click",function(e){ if(e.target.tagName!=="A") lb.classList.remove("open"); });
  
  g.addEventListener("click",function(e){
    var t=e.target; if(t.tagName!=="IMG") return;
    lb.querySelector("img").src=t.src;
    lb.querySelector("p").textContent=t.alt;
    lb.querySelector("a").href=wa(t.alt);
    lb.classList.add("open");
  });

  document.addEventListener("keydown",function(e){ if(e.key==="Escape") lb.classList.remove("open"); });
  document.body.appendChild(sec); document.body.appendChild(lb);
}

if(document.readyState==="loading") document.addEventListener("DOMContentLoaded", init); else init();
})();
