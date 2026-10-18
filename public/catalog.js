(function(){
if(window.__nqCat)return;window.__nqCat=1;
var OWNER="Banele477",REPO="nollies-site",BRANCH="main",WA="27625873479";
var P=window.NQ_PHOTOS||[];if(!P.length)return;
var base=location.pathname.replace(/[^\/]*$/,"");
var CDN="https://cdn.jsdelivr.net/gh/"+OWNER+"/"+REPO+"@"+BRANCH+"/public/images/";
var FALL="data:image/svg+xml;utf8,"+encodeURIComponent("<svg xmlns='http://www.w3.org/2000/svg' width='600' height='600'><rect width='100%' height='100%' fill='#0f172a'/><text x='50%' y='50%' fill='white' font-family='sans-serif' font-size='22' text-anchor='middle'>Nqobile Hub Stock</text></svg>");
var CATS={all:"All",hamper:"🧺 Hampers",cereal:"🥣 Cereals",juice:"🧃 Juices",bulk:"📦 Bulk boxes"};
var css="#nqc{max-width:1100px;margin:40px auto 130px;padding:0 14px;color:#fff;font-family:sans-serif}#nqc h2{text-align:center;font-size:24px;margin:0}#nqc .s{text-align:center;color:#94a3b8;font-size:13px;margin:4px 0 14px}#nqc .ch{display:flex;gap:8px;overflow:auto;padding:4px 2px 12px;scrollbar-width:none}#nqc .ch::-webkit-scrollbar{display:none}#nqc .ch button{flex:none;padding:10px 16px;border-radius:999px;border:1px solid #475569;background:#1e293b;color:#fff;font-weight:700;font-size:14px}#nqc .ch button.on{background:#fff;color:#030712;border-color:#fff}#nqc .g{display:grid;grid-template-columns:repeat(auto-fill,minmax(160px,1fr));gap:12px}#nqc .c{background:rgba(15,23,42,.85);border:1px solid rgba(255,255,255,.18);border-radius:16px;overflow:hidden}#nqc .c img{width:100%;aspect-ratio:1;object-fit:cover;display:block;cursor:zoom-in;background:#0f172a}#nqc .c p{margin:0;padding:10px 10px 4px;font-size:12px;line-height:1.35;color:#e2e8f0;min-height:50px}#nqc .c a{display:block;margin:6px 10px 10px;padding:10px;border-radius:999px;background:#25d366;color:#04210f;text-align:center;font-weight:800;font-size:13px;text-decoration:none}#nqlb{position:fixed;inset:0;background:rgba(0,0,0,.93);z-index:999999;display:none;flex-direction:column;align-items:center;justify-content:center;padding:14px;gap:12px}#nqlb.open{display:flex}#nqlb img{max-width:100%;max-height:72vh;border-radius:12px}#nqlb p{color:#fff;font:14px sans-serif;text-align:center;margin:0;max-width:520px}#nqlb a{padding:12px 22px;border-radius:999px;background:#25d366;color:#04210f;font:800 15px sans-serif;text-decoration:none}";
function wa(t){return "https://wa.me/"+WA+"?text="+encodeURIComponent("Hi Nqobile's Hub, I'm interested in: "+t)}
function setSrc(img,n){var l=[base+"images/"+n,base+"public/images/"+n,CDN+n],i=0;function nx(){img.src=i<l.length?l[i++]:FALL}img.onerror=nx;nx()}
function init(){
  var st=document.createElement("style");st.textContent=css;document.head.appendChild(st);
  var sec=document.createElement("section");sec.id="nqc";
  sec.innerHTML="<h2>🛍️ Our Real Stock</h2><div class='s'>Tap a photo to enlarge · Ask about any item on WhatsApp</div><div class='ch'></div><div class='g'></div>";
  var ch=sec.querySelector(".ch"),g=sec.querySelector(".g");
  var have={all:1};P.forEach(function(p){have[p.c]=1});
  Object.keys(CATS).forEach(function(k){if(!have[k])return;var b=document.createElement("button");b.textContent=CATS[k];b.dataset.k=k;if(k==="all")b.className="on";ch.appendChild(b)});
  P.forEach(function(p){
    var d=document.createElement("div");d.className="c";d.dataset.c=p.c;
    var im=document.createElement("img");im.alt=p.t;im.loading="lazy";setSrc(im,p.n);
    var tx=document.createElement("p");tx.textContent=p.t;
    var a=document.createElement("a");a.href=wa(p.t);a.target="_blank";a.rel="noopener";a.textContent="💬 Ask about this";
    d.appendChild(im);d.appendChild(tx);d.appendChild(a);g.appendChild(d);
  });
  ch.addEventListener("click",function(e){var b=e.target.closest("button");if(!b)return;
    ch.querySelectorAll("button").forEach(function(x){x.classList.toggle("on",x===b)});
    g.querySelectorAll(".c").forEach(function(c){c.style.display=(b.dataset.k==="all"||c.dataset.c===b.dataset.k)?"":"none"})});
  var lb=document.createElement("div");lb.id="nqlb";lb.innerHTML="<img alt=''><p></p><a target='_blank' rel='noopener'>💬 Ask about this on WhatsApp</a>";
  lb.addEventListener("click",function(e){if(e.target.tagName!=="A")lb.classList.remove("open")});
  g.addEventListener("click",function(e){var t=e.target;if(t.tagName!=="IMG")return;
    lb.querySelector("img").src=t.src;lb.querySelector("p").textContent=t.alt;lb.querySelector("a").href=wa(t.alt);lb.classList.add("open")});
  document.addEventListener("keydown",function(e){if(e.key==="Escape")lb.classList.remove("open")});
  document.body.appendChild(sec);document.body.appendChild(lb);
}
if(document.readyState==="loading")document.addEventListener("DOMContentLoaded",init);else init();
})();
