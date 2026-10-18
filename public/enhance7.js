(function(){
if(window.__nq7)return;window.__nq7=1;
var C=window.NQ_CFG||{},WA=String(C.wa||"27625873479"),MAIL="nqobilegila518@gmail.com";
var VAL={c:250,b:380,j:160,p:120,d:192},PR={250:"c",380:"b",160:"j",120:"p",192:"d"};
var RM=window.matchMedia&&matchMedia("(prefers-reduced-motion:reduce)").matches;
function $(s,r){return(r||document).querySelector(s)}
function ld(k,d){try{var v=JSON.parse(localStorage.getItem(k));return v==null?d:v}catch(e){return d}}
function sv(k,v){try{localStorage.setItem(k,JSON.stringify(v))}catch(e){}}
function enc(s){return(window.nqEnc||encodeURIComponent)(s)}
function today(){return new Date().toLocaleDateString("en-CA")}
function pretty(){var d=WA.replace(/\D/g,"");return d.length===11?"0"+d.slice(2,4)+" "+d.slice(4,7)+" "+d.slice(7):WA}
var tt;function toast(m){var t=$("#nq7-t");if(!t)return;t.textContent=m;t.style.display="block";clearTimeout(tt);tt=setTimeout(function(){t.style.display="none"},2600)}

/* ---- bring items from the old site cart into the new order sheet ---- */
function legacy(){var a=ld("nollies_cart",[]),m={},un=0;if(Array.isArray(a))a.forEach(function(x){var id=PR[Number(x&&x.price)];if(id)m[id]=(m[id]||0)+1;else un++});return{m:m,un:un}}
function pend(){var L=legacy().m,S=ld("nq7_seen",{}),n=0,v=0;Object.keys(L).forEach(function(k){var d=L[k]-(S[k]||0);if(d>0){n+=d;v+=d*VAL[k]}});return{n:n,v:v}}
function cartInfo(){var q=(ld("nq5_cart",{q:{}})||{}).q||{},n=0,s=0;Object.keys(q).forEach(function(k){var c=q[k]||0;n+=c;s+=c*(VAL[k]||0)});var p=pend();return{n:n+p.n,s:s+p.v}}
function bridge(){
 var L=legacy(),S=ld("nq7_seen",{}),sh=$("#nq5-sh"),moved=0;
 if(sh)Object.keys(L.m).forEach(function(k){var d=L.m[k]-(S[k]||0);
  for(var i=0;i<d;i++){var b=sh.querySelector("[data-a='"+k+"']");if(b){b.click();moved++}}});
 Object.keys(L.m).forEach(function(k){S[k]=L.m[k]});
 Object.keys(S).forEach(function(k){if(!(k in L.m))S[k]=0});
 sv("nq7_seen",S);
 if(moved)toast("Moved "+moved+" item"+(moved>1?"s":"")+" into your order");
 else if(L.un)toast("Some custom items could not be moved. Please add them again.");
}

/* ---- actions ---- */
function openOrder(after){var f=$("#nq-fab");if(!f){window.open("https://wa.me/"+WA,"_blank");return}f.click();if(after)setTimeout(after,90)}
function perks(v){var f=$("#nq4-fab");if(!f){toast("Still loading, try again in a moment");return}f.click();setTimeout(function(){var b=$("#nq4-sh [data-v='"+v+"']");if(b)b.click()},90)}
function go(sel,msg){var e=$(sel);if(e)e.scrollIntoView({behavior:RM?"auto":"smooth",block:"start"});else toast(msg||"Loading...")}
function share(){var d={title:"Nqobile's Durban Hub",text:"Cereal hampers, Juices Africa and perfumes in Durban. Order on WhatsApp.",url:location.href.split("#")[0]};
 if(navigator.share)navigator.share(d).catch(function(){});else if(navigator.clipboard)navigator.clipboard.writeText(d.url).then(function(){toast("Link copied!")})}
function legacyMenu(){var b=$(".nq6-menu");if(!b){toast("More pages are not available right now");return}window.__nq7by=1;b.click();setTimeout(function(){window.__nq7by=0},60)}

var TILES=[
{k:"cart",i:"🛒",t:"Cart",a:"#4ade80",b:"#15803d",g:"rgba(34,197,94,.55)",act:function(){openOrder(bridge)},live:function(){var c=cartInfo();return{sub:c.n?"R"+c.s+" total":"Empty",badge:c.n,hot:c.n>0}}},
{k:"shop",i:"🛍️",t:"Catalog",a:"#38bdf8",b:"#2563eb",g:"rgba(56,189,248,.5)",sub:"Real photos",act:function(){go("#nqc","Catalog is loading...")}},
{k:"deals",i:"🔥",t:"Hot Deals",a:"#fb923c",b:"#dc2626",g:"rgba(251,146,60,.55)",sub:"Save up to R96",act:function(){go("#nq6-deals","Deals are loading...")}},
{k:"spin",i:"🎡",t:"Spin &amp; Win",a:"#f472b6",b:"#9333ea",g:"rgba(217,70,239,.55)",act:function(){perks("spin")},live:function(){var s=ld("nq4_spin",null),done=s&&s.d===today();return{sub:done?"Back tomorrow":"Free spin!",badge:done?"":"FREE",hot:!done}}},
{k:"build",i:"🧺",t:"Build Hamper",a:"#fbbf24",b:"#ea580c",g:"rgba(251,191,36,.5)",sub:"Your own mix",act:function(){perks("build")}},
{k:"orders",i:"📋",t:"My Orders",a:"#a78bfa",b:"#6d28d9",g:"rgba(167,139,250,.5)",act:function(){openOrder(function(){var b=$("#nq5-sh [data-g='hist']");if(b)b.click()})},live:function(){var n=(ld("nq5_orders",[])||[]).length;return{sub:n?n+" saved":"None yet"}}},
{k:"app",i:"📲",t:"Install App",a:"#2dd4bf",b:"#0e7490",g:"rgba(45,212,191,.5)",sub:"Works offline",act:function(){perks("install")}},
{k:"ai",i:"🤖",t:"Ask AI",a:"#818cf8",b:"#4338ca",g:"rgba(129,140,248,.5)",sub:"24/7 help",act:function(){var a=$(".nq6-lift");if(a)a.click();else toast("AI assistant is loading...")}},
{k:"chat",i:"💬",t:"WhatsApp",a:"#4ade80",b:"#15803d",g:"rgba(34,197,94,.5)",sub:"We reply fast",act:function(){window.open("https://wa.me/"+WA+"?text="+enc("Hi Nqobile's Hub, I have a question."),"_blank")}},
{k:"faq",i:"❓",t:"FAQ",a:"#fcd34d",b:"#b45309",g:"rgba(252,211,77,.45)",sub:"Delivery and pay",act:function(){go("#nq3-faq","FAQ is loading...")}},
{k:"share",i:"📤",t:"Share",a:"#f9a8d4",b:"#be185d",g:"rgba(249,168,212,.45)",sub:"Tell a friend",act:share}];
var MORE={k:"more",i:"🧭",t:"More Pages",a:"#e2e8f0",b:"#64748b",g:"rgba(226,232,240,.35)",sub:"Original menu",act:legacyMenu};
var BY={};TILES.concat([MORE]).forEach(function(t){BY[t.k]=t});

function tile(t,i){return"<button class='nq7-t' data-k='"+t.k+"' style='--a:"+t.a+";--b:"+t.b+";--g:"+t.g+";--d:-"+(i*.35)+"s'><span class='nq7-n'></span><span class='nq7-i'>"+t.i+"</span><b>"+t.t+"</b><small></small></button>"}
function refresh(){
 TILES.concat([MORE]).forEach(function(t){
  var l=t.live?t.live():{sub:t.sub};
  document.querySelectorAll(".nq7-t[data-k='"+t.k+"']").forEach(function(b){
   b.querySelector("small").textContent=l.sub||"";
   var n=b.querySelector(".nq7-n");n.style.display=l.badge?"block":"none";n.textContent=l.badge||"";
   b.classList.toggle("nq7-hot",!!l.hot)})})}

/* ---- dock + menu ---- */
function buildDock(){
 var d=document.createElement("section");d.id="nq7-dock";
 d.innerHTML="<div class='lb'><span>✨ Quick Features</span><small>swipe →</small></div><div class='nq7-tr'>"+TILES.map(tile).join("")+"</div>";
 return d}
var ov,mn;
function openMenu(){ov.classList.add("open");mn.classList.add("open");document.body.style.overflow="hidden";refresh()}
function closeMenu(){ov.classList.remove("open");mn.classList.remove("open");document.body.style.overflow=""}
function buildMenu(){
 ov=document.createElement("div");ov.id="nq7-ov";ov.onclick=closeMenu;document.body.appendChild(ov);
 mn=document.createElement("div");mn.id="nq7-m";mn.setAttribute("role","dialog");mn.setAttribute("aria-modal","true");
 mn.innerHTML="<button class='nq7-cl' aria-label='Close'>✕</button><h2>☰ Menu</h2><div class='s'>Nqobile's Durban Hub · R30 flat delivery</div><div class='nq7-g'>"+TILES.concat([MORE]).map(tile).join("")+"</div><div class='nq7-c'><a href='tel:+"+WA.replace(/\D/g,"")+"'>📞 "+pretty()+"</a><a class='w' target='_blank' rel='noopener' href='https://wa.me/"+WA+"'>💬 WhatsApp</a><a href='mailto:"+MAIL+"'>📧 Email</a></div>";
 $(".nq7-cl",mn).onclick=closeMenu;document.body.appendChild(mn)}

/* ---- find the header and clear out the clipped old tabs ---- */
function findHeader(){
 var h=$("#root header");if(h)return{el:h,sure:true};
 var root=$("#root");if(!root)return null;
 var all=root.querySelectorAll("*"),best=null;
 for(var i=0;i<all.length;i++){var t=all[i].textContent;
  if(t.length<300&&/NQOBILE/i.test(t)&&/GMAIL/i.test(t)&&(!best||t.length<best.textContent.length))best=all[i]}
 if(!best)return null;
 var g=best.closest(".rainbow-glass");
 return g?{el:g,sure:true}:{el:best.parentElement,sure:false}}
function hideOld(h){
 h.querySelectorAll("button,a,[role=button],.raindrop-pill").forEach(function(b){
  if(b.classList.contains("nq6-menu")||b.closest(".nq6-menu")||b.closest("#nq7-dock"))return;
  var t=(b.textContent||"").trim();
  if(b.querySelector("img")||t.indexOf("@")>-1||/^durban\s*hub$/i.test(t))return;
  if(b.tagName==="A"&&/^mailto:/i.test(b.getAttribute("href")||""))return;
  b.classList.add("nq7-x")})}
var nudged=0;
function place(H){
 var d=$("#nq7-dock");if(!d)d=buildDock();
 if(H&&d.previousElementSibling!==H.el)H.el.parentNode.insertBefore(d,H.el.nextSibling);
 else if(!H&&!d.isConnected){var r=$("#root");if(r)r.insertBefore(d,r.firstChild)}
 if(!nudged&&d.isConnected&&!RM){nudged=1;var tr=$(".nq7-tr",d);setTimeout(function(){tr.scrollTo({left:80,behavior:"smooth"});setTimeout(function(){tr.scrollTo({left:0,behavior:"smooth"})},700)},1200)}}
function tick(){try{var H=findHeader();if(H&&H.sure)hideOld(H.el);place(H);refresh()}catch(e){}}

function init(){
 var t=document.createElement("div");t.id="nq7-t";document.body.appendChild(t);
 buildMenu();
 document.addEventListener("click",function(e){
  var m=e.target.closest&&e.target.closest(".nq6-menu");
  if(m&&!window.__nq7by){e.preventDefault();e.stopPropagation();e.stopImmediatePropagation();openMenu();return}
  var b=e.target.closest&&e.target.closest(".nq7-t");
  if(b){var x=BY[b.dataset.k];if(x){closeMenu();x.act()}}
 },true);
 document.addEventListener("keydown",function(e){if(e.key==="Escape")closeMenu()});
 window.addEventListener("storage",refresh);
 document.addEventListener("visibilitychange",refresh);
 var tm;new MutationObserver(function(){clearTimeout(tm);tm=setTimeout(tick,350)}).observe(document.body,{childList:true,subtree:true});
 tick();setInterval(tick,2000)}
if(document.readyState==="loading")document.addEventListener("DOMContentLoaded",init);else init();
})();
