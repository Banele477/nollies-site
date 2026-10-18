(function(){
if(window.__nq6)return;window.__nq6=1;
var C=window.NQ_CFG||{},WA=C.wa||"27625873479";
var OWNER="Banele477",REPO="nollies-site",BRANCH="main";
var DIG="",PRETTY="";
var base=location.pathname.replace(/[^\/]*$/,"");
var CDN="https://cdn.jsdelivr.net/gh/"+OWNER+"/"+REPO+"@"+BRANCH+"/public/images/";
var RM=window.matchMedia&&matchMedia("(prefers-reduced-motion:reduce)").matches;
function $(s,r){return(r||document).querySelector(s)}
function enc(s){return(window.nqEnc||encodeURIComponent)(s)}
function setSrc(img,n){var l=[base+"images/"+n,base+"public/images/"+n,CDN+n],i=0;function nx(){if(i<l.length)img.src=l[i++];else img.style.display="none"}img.onerror=nx;nx()}

var DEALS=[
{t:"Breakfast Hamper",s:"Cereal hamper, 4 packages",p:250,tag:"🥣 Hamper",img:"hamper-tropika-cereals.jpg"},
{t:"Juices Africa 4L",s:"Makes 20 litres per bottle",p:160,tag:"🧃 Juice",img:"juices-africa-flavours.jpg"},
{t:"2 Juices Deal",s:"2 x 4L Juices Africa",p:224,old:320,tag:"💥 Save R96",img:"juices-africa-flavours.jpg"},
{t:"2 Perfumes Deal",s:"2 x M-Scents 40ml",p:192,old:240,tag:"💎 Save R48",svg:1},
{t:"Cereal Combo",s:"Combo of 3 cereal items",p:170,tag:"🥣 Combo",img:"rice-puffs-cereals.jpg"}];

var BOT='<svg viewBox="0 0 220 130" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">'+
 [["#ef4444",20,22,70],["#38bdf8",82,8,84],["#22c55e",144,22,70]].map(function(b){
  var x=b[1],y=b[2],h=b[3];
  return '<g transform="translate('+x+','+y+')"><rect x="22" y="0" width="16" height="12" rx="3" fill="#e2e8f0"/><rect x="26" y="12" width="8" height="8" fill="#94a3b8"/><rect x="0" y="20" width="60" height="'+(h+16)+'" rx="12" fill="'+b[0]+'"/><rect x="8" y="30" width="7" height="'+(h-6)+'" rx="3.5" fill="rgba(255,255,255,.35)"/><rect x="18" y="'+(20+(h+16)/2-8)+'" width="34" height="16" rx="3" fill="rgba(255,255,255,.85)"/></g>';
 }).join("")+'</svg>';

function buildDeals(){
 var sec=document.createElement("section");sec.id="nq6-deals";
 sec.innerHTML="<h2>🔥 Hot Deals <small>swipe →</small></h2><div class='nq6-track'></div><div class='nq6-dots'></div>";
 var tr=$(".nq6-track",sec),dots=$(".nq6-dots",sec);
 DEALS.forEach(function(d,i){
  var c=document.createElement("div");c.className="nq6-card";
  c.innerHTML=(d.svg?"<div class='nq6-art'>"+BOT+"</div>":"<img alt='' loading='lazy'>")+"<div class='nq6-sh'></div><span class='nq6-tag'></span><div class='nq6-in2'><b></b><small></small><div class='nq6-pr'><span class='nq6-p'></span><s class='nq6-o'></s></div></div><a class='nq6-btn' target='_blank' rel='noopener'>💬 Order</a>";
  $(".nq6-tag",c).textContent=d.tag;$("b",c).textContent=d.t;$("small",c).textContent=d.s;
  $(".nq6-p",c).textContent="R"+d.p;if(d.old)$(".nq6-o",c).textContent="R"+d.old;
  $(".nq6-btn",c).href="https://wa.me/"+WA+"?text="+enc("Hi Nqobile's Hub, I'd like the "+d.t+" (R"+d.p+"). Please confirm availability.");
  if(d.img)setSrc($("img",c),d.img);
  tr.appendChild(c);
  var dt=document.createElement("i");if(!i)dt.className="on";dots.appendChild(dt);
 });
 var idx=0,paused=0,cards=tr.children;
 function go(i){idx=(i+cards.length)%cards.length;tr.scrollTo({left:cards[idx].offsetLeft-16,behavior:RM?"auto":"smooth"})}
 tr.addEventListener("scroll",function(){
  var w=cards[0].offsetWidth+12,i=Math.round(tr.scrollLeft/w);
  if(i<0)i=0;if(i>=cards.length)i=cards.length-1;idx=i;
  [].forEach.call(dots.children,function(d,k){d.className=k===i?"on":""})},{passive:true});
 ["pointerdown","touchstart","wheel"].forEach(function(e){tr.addEventListener(e,function(){paused=Date.now()+8000},{passive:true})});
 if(!RM)setInterval(function(){
  if(Date.now()<paused||document.hidden)return;
  var r=sec.getBoundingClientRect();if(r.bottom<0||r.top>innerHeight)return;
  go(idx+1)},3800);
 return sec}

var t0=Date.now();
function place(){
 var d=$("#nq6-deals");if(d&&d.isConnected)return;
 if(!d)d=buildDeals();
 var cta=[].filter.call(document.querySelectorAll("#root button,#root a"),function(e){return/Explore Real Stock/i.test(e.textContent)})[0];
 if(cta){var h=cta.closest("section")||cta.parentElement;h.parentNode.insertBefore(d,h.nextSibling);return}
 if(Date.now()-t0>10000){var c=$("#nqc");if(c)c.parentNode.insertBefore(d,c);else document.body.appendChild(d)}
}

function fixLayout(){
 var root=$("#root");if(!root)return;
 if(!$(".nq6-menu")){
  var best=null,len=1e9,all=root.querySelectorAll("*");
  for(var i=0;i<all.length;i++){var t=all[i].textContent;
   if(t.length<80&&/MENU:/i.test(t)&&/Durban Home/i.test(t)&&t.length<len){best=all[i];len=t.length}}
  if(best){var p=best.closest(".raindrop-pill,button,[role=button]")||best;p.classList.add("nq6-menu");p.setAttribute("aria-label","Menu")}
 }
 if(!$(".nq6-lift")){
  var a2=root.querySelectorAll("*");
  for(var j=0;j<a2.length;j++){var el=a2[j];
   if(el.closest(".nq6-menu"))continue;
   if(getComputedStyle(el).position!=="fixed")continue;
   var r=el.getBoundingClientRect();
   if(r.width>=36&&r.width<=100&&r.height>=36&&r.height<=100&&r.right>innerWidth-120&&r.bottom>innerHeight-120){el.classList.add("nq6-lift");break}}
 }
}

function fixNumber(){
 if(!DIG)return;
 var root=$("#root")||document.body,test=/(\+?27|\b0)[\s-]?63[\s-]?701[\s-]?9808/,glob=/(\+?27|\b0)[\s-]?63[\s-]?701[\s-]?9808/g;
 var w=document.createTreeWalker(root,NodeFilter.SHOW_TEXT,null),n,list=[];
 while((n=w.nextNode()))if(test.test(n.nodeValue))list.push(n);
 list.forEach(function(x){x.nodeValue=x.nodeValue.replace(glob,PRETTY)});
 document.querySelectorAll("a[href]").forEach(function(a){
  var h=a.getAttribute("href");
  if(h.indexOf("27637019808")>-1||h.indexOf("0637019808")>-1)a.setAttribute("href",h.replace("27637019808",DIG).replace("0637019808","0"+DIG.slice(2)));
 });
}

var io=null;
if("IntersectionObserver" in window&&!RM)io=new IntersectionObserver(function(es){es.forEach(function(e){if(e.isIntersecting){e.target.classList.add("nq6-in");io.unobserve(e.target)}})},{threshold:.08});
function reveal(){
 if(!io)return;
 document.querySelectorAll("#nqc .c:not(.nq6-r),#nq3-faq details:not(.nq6-r),#nq3-foot:not(.nq6-r)").forEach(function(e){e.classList.add("nq6-r");io.observe(e)});
}

function badge(){
 var b=$("#nq3-nav button[data-g='order']");if(!b)return;
 var em=$("#nq6-badge");if(!em){em=document.createElement("em");em.id="nq6-badge";b.appendChild(em)}
 var n=0;try{var q=(JSON.parse(localStorage.getItem("nq5_cart"))||{}).q||{};Object.keys(q).forEach(function(k){n+=q[k]||0})}catch(e){}
 em.textContent=n;em.style.display=n?"block":"none";
}

function confetti(){
 if(RM)return;
 var E=["🎉","✨","🥣","🧃","💎","🎊"],w=document.createElement("div");w.className="nq6-conf";
 for(var i=0;i<26;i++){var p=document.createElement("span");p.textContent=E[i%E.length];p.style.left=Math.random()*100+"%";p.style.animationDelay=Math.random()*.6+"s";p.style.animationDuration=(1.8+Math.random()*1.4)+"s";p.style.fontSize=(16+Math.random()*16)+"px";w.appendChild(p)}
 document.body.appendChild(w);setTimeout(function(){w.remove()},3800);
}
function watch(sh){
 var last="";
 new MutationObserver(function(){
  var ok=$(".nq5-ok",sh),no=$(".nq5-no",sh);
  if(ok&&no&&(/✅|🎉/.test(ok.textContent))&&no.textContent!==last){last=no.textContent;confetti()}
 }).observe(sh,{childList:true});
}
function spark(e){
 var t=e.target;if(!t.closest||!t.closest("button,.nq6-btn,.nq5-go"))return;
 var cols=["#f43f5e","#fbbf24","#34d399","#38bdf8","#a855f7","#ffffff"];
 for(var i=0;i<8;i++){
  var d=document.createElement("i");d.className="nq6-sp";var a=Math.PI*2*i/8,r=26+Math.random()*18;
  d.style.left=e.clientX+"px";d.style.top=e.clientY+"px";d.style.background=cols[i%cols.length];
  d.style.setProperty("--dx",Math.cos(a)*r+"px");d.style.setProperty("--dy",Math.sin(a)*r+"px");
  document.body.appendChild(d);(function(x){setTimeout(function(){x.remove()},550)})(d);
 }
}

function tick(){try{fixLayout();fixNumber();place();reveal();badge()}catch(e){}}
var tm;function sched(){clearTimeout(tm);tm=setTimeout(tick,350)}
function init(){
 new MutationObserver(sched).observe(document.body,{childList:true,subtree:true});
 tick();setInterval(tick,2500);
 var iv=setInterval(function(){var sh=$("#nq5-sh");if(sh){clearInterval(iv);watch(sh)}},600);
 if(!RM)document.addEventListener("pointerdown",spark,{passive:true});
}
if(document.readyState==="loading")document.addEventListener("DOMContentLoaded",init);else init();
})();
