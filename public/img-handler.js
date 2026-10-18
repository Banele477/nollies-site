(function(){
if(window.__nqImg)return;window.__nqImg=1;
var OWNER="Banele477";
var REPO="nollies-site";
var BRANCH="main";
var NAMES=["1000040039.jpg","1000040041.jpg","1000040042.jpg","1000040046.jpg","1000040047.jpg","1000040048.jpg","1000040049.jpg","1000040050.jpg","1000040051.jpg","1000040052.jpg","1000040056.jpg","1000040057.jpg","1000040058.jpg","1000040059.jpg","1000040060.jpg","1000040064.jpg","1000040067.jpg","1000040071.jpg","1000040076.jpg","1000040092.jpg","bulk-box-cereals.jpg","bulk-box-full.jpg","hamper-floor-landscape.jpg","hamper-floor-portrait.jpg","hamper-tropika-cereals.jpg","juices-africa-flavours.jpg","nollie.jpg","noodles-cereal-stack.jpg","rice-puffs-cereals.jpg"];
var SHOW_GALLERY=true;
var HIDE=[];
var base=location.pathname.replace(/[^\/]*$/,"");
var CDN="https://cdn.jsdelivr.net/gh/"+OWNER+"/"+REPO+"@"+BRANCH;
var RAW="https://raw.githubusercontent.com/"+OWNER+"/"+REPO+"/"+BRANCH;
var FALL="data:image/svg+xml;utf8,"+encodeURIComponent("<svg xmlns='http://www.w3.org/2000/svg' width='600' height='400'><rect width='100%' height='100%' fill='#0f172a'/><text x='50%' y='50%' fill='white' font-family='sans-serif' font-size='22' text-anchor='middle'>Nqobile Hub Stock</text></svg>");
var css="#nq-gallery{max-width:1100px;margin:40px auto 120px;padding:0 16px;color:#fff;font-family:sans-serif;text-align:center}#nq-gallery h2{font-size:24px;margin:0}#nq-gallery p{color:#94a3b8;font-size:13px;margin:4px 0 16px}.nq-g{display:grid;grid-template-columns:repeat(auto-fill,minmax(150px,1fr));gap:10px}.nq-g figure{margin:0;border-radius:14px;overflow:hidden;border:1px solid rgba(255,255,255,.2);background:#0f172a;aspect-ratio:1}.nq-g img{width:100%;height:100%;object-fit:cover;display:block;cursor:zoom-in}img.nq-wait{opacity:.35;filter:blur(3px)}img.nq-ok{transition:opacity .4s,filter .4s}#nq-lb{position:fixed;inset:0;background:rgba(0,0,0,.92);z-index:999999;display:none;align-items:center;justify-content:center;padding:16px}#nq-lb.open{display:flex}#nq-lb img{max-width:100%;max-height:100%;border-radius:12px}";
var stl=document.createElement("style");stl.textContent=css;document.head.appendChild(stl);

function nameOf(u){try{var p=u.split("#")[0].split("?")[0];return decodeURIComponent(p.substring(p.lastIndexOf("/")+1))}catch(e){return""}}
function cands(name,orig){
  var a=[base+"images/"+name,base+"public/images/"+name,CDN+"/public/images/"+name,CDN+"/images/"+name,RAW+"/public/images/"+name,RAW+"/images/"+name,orig];
  return a.filter(function(x,i){return a.indexOf(x)===i});
}
function load(img,list,i){
  if(i>=list.length){img._nq=FALL;img.src=FALL;img.classList.remove("nq-wait");img.dispatchEvent(new Event("nqfail"));return}
  var p=new Image();
  p.onload=function(){img._nq=list[i];img.src=list[i];img.classList.remove("nq-wait");img.classList.add("nq-ok")};
  p.onerror=function(){load(img,list,i+1)};
  p.src=list[i];
}
function handle(img){
  var s=img.getAttribute("src")||"";
  if(!s||s.indexOf("data:")===0||img._nq===s)return;
  var name=nameOf(s);
  if(!/\.(jpe?g|png|webp|gif)$/i.test(name))return;
  var external=/^https?:\/\//i.test(s)&&s.indexOf(location.host)<0&&NAMES.indexOf(name)<0;
  if(external){
    if(!img._nqe){img._nqe=1;img.addEventListener("error",function(){if(img.src!==FALL){img._nq=FALL;img.src=FALL}})}
    return;
  }
  img._nq=s;img.classList.add("nq-wait");
  load(img,cands(name,s),0);
}
function scan(r){var l=r.querySelectorAll?r.querySelectorAll("img"):[];for(var i=0;i<l.length;i++)handle(l[i])}
new MutationObserver(function(ms){ms.forEach(function(m){
  if(m.type==="attributes"){handle(m.target)}
  else m.addedNodes.forEach(function(n){if(n.nodeType===1){if(n.tagName==="IMG")handle(n);else scan(n)}})
})}).observe(document.documentElement,{childList:true,subtree:true,attributes:true,attributeFilter:["src"]});

function gallery(){
  if(!NAMES.length||document.getElementById("nq-gallery"))return;
  var sec=document.createElement("section");sec.id="nq-gallery";
  sec.innerHTML="<h2>📸 Our Stock Photos</h2><p>Tap any photo to enlarge</p><div class='nq-g'></div>";
  var g=sec.querySelector(".nq-g");
  NAMES.forEach(function(n){
    if(HIDE.indexOf(n)>-1)return;
    var f=document.createElement("figure"),im=document.createElement("img");
    im.alt="Nqobile's Hub stock photo";im.setAttribute("src","images/"+n);
    im.addEventListener("nqfail",function(){f.remove()});
    f.appendChild(im);g.appendChild(f);
  });
  var lb=document.createElement("div");lb.id="nq-lb";lb.innerHTML="<img alt=''>";
  lb.onclick=function(){lb.classList.remove("open")};
  sec.addEventListener("click",function(e){var t=e.target;if(t.tagName==="IMG"&&t._nq&&t._nq!==FALL){lb.firstChild.src=t._nq;lb.classList.add("open")}});
  document.body.appendChild(sec);document.body.appendChild(lb);
}
function init(){scan(document);if(SHOW_GALLERY)gallery()}
if(document.readyState==="loading")document.addEventListener("DOMContentLoaded",init);else init();
window.addEventListener("load",function(){scan(document)});
})();
