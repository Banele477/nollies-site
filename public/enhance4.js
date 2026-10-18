(function(){
if(window.__nq4)return;window.__nq4=1;
var WA="27625873479";
/* ===== EDIT ME: spin prizes (l = label on wheel, t = what the customer won, w = true if it is a real prize) ===== */
var PR=[
 {l:"Free delivery",t:"FREE delivery on my order",w:true},
 {l:"5% OFF",t:"5% off my order",w:true},
 {l:"Try again",t:"",w:false},
 {l:"R10 OFF",t:"R10 off my order",w:true},
 {l:"Free Tropika",t:"a FREE Tropika 200ml",w:true},
 {l:"Try again",t:"",w:false}];
var COL=["#ef4444","#0ea5e9","#475569","#a855f7","#10b981","#475569"];
/* ===== hamper builder items ===== */
var BASES=[["Cereal Hamper","from R250"],["Family Bulk Grocery Box","from R380"],["Juice & Tropika Pack","from R160"]];
var GROUPS=[
 ["🥣 Cereals",["Jungle Oats 1kg","Weet-Bix 450g","Bokomo Corn Flakes 1kg","Nutrific 450g","Futurelife Smart Food 500g","Happy Valley Rice Puffs","Kellogg's Beef Noodles 5-pack"]],
 ["🧃 Drinks",["Tropika Orange 200ml (3-pack)","Juices Africa 4L Guava","Juices Africa 4L Mixed Berry","Juices Africa 4L Cocktail","Juices Africa 4L Tropical Punch"]]];

function $(s,r){return(r||document).querySelector(s)}
function wa(t){return"https://wa.me/"+WA+"?text="+encodeURIComponent(t)}
function today(){return new Date().toLocaleDateString("en-CA")}
function ld(k){try{return JSON.parse(localStorage.getItem(k))}catch(e){return null}}
function sv(k,v){try{localStorage.setItem(k,JSON.stringify(v))}catch(e){}}
var sh,ov,deferred=null;
window.addEventListener("beforeinstallprompt",function(e){e.preventDefault();deferred=e});

function open(){ov.classList.add("open");sh.classList.add("open");document.body.style.overflow="hidden"}
function close(){ov.classList.remove("open");sh.classList.remove("open");document.body.style.overflow=""}
function frame(h){sh.innerHTML="<button id='nq4-x' aria-label='Close'>✕</button>"+h}

function menu(){
 frame("<h2>🎁 Perks & Tools</h2><div class='sub'>Fun ways to shop with Nqobile's Hub</div>"+
 "<button class='nq4-card' data-v='build'><span>🧺</span><div><b>Build my own hamper</b><small>Pick your items, we confirm the price</small></div></button>"+
 "<button class='nq4-card' data-v='spin'><span>🎡</span><div><b>Spin &amp; Win</b><small>One free spin every day</small></div></button>"+
 "<button class='nq4-card' data-v='install'><span>📲</span><div><b>Add shop to my phone</b><small>Opens like an app, even on weak signal</small></div></button>");
}

function build(){
 var h="<button class='nq4-back' data-v='menu'>← Back</button><h2>🧺 Build my hamper</h2><div class='sub'>Choose a base, tick what you want. We confirm the final price on WhatsApp.</div><div class='nq4-h'>1. Base</div>";
 BASES.forEach(function(b,i){h+="<label class='nq4-opt"+(i===0?" on":"")+"'><input type='radio' name='nq4b' value='"+b[0]+" ("+b[1]+")'"+(i===0?" checked":"")+"><span><b>"+b[0]+"</b> · "+b[1]+"</span></label>"});
 GROUPS.forEach(function(g){h+="<div class='nq4-h'>"+g[0]+"</div>";g[1].forEach(function(n){h+="<label class='nq4-opt'><input type='checkbox' value=\""+n+"\"><span>"+n+"</span></label>"})});
 h+="<div class='nq4-h'>Your details</div><input type='text' id='nq4-n' placeholder='Your name' autocomplete='name'><textarea id='nq4-nt' rows='2' placeholder='Notes (delivery area, budget, date needed)'></textarea><div class='nq4-err' id='nq4-e'></div><button class='nq4-go' id='nq4-s'>💬 Send my hamper on WhatsApp</button>";
 frame(h);
 var nm=ld("nq4_name");if(nm)$("#nq4-n").value=nm;
}

function spin(){
 var done=ld("nq4_spin"),has=done&&done.d===today();
 frame("<button class='nq4-back' data-v='menu'>← Back</button><h2>🎡 Spin &amp; Win</h2><div class='sub'>One spin per day. Show your code when you order.</div>"+
 "<div class='nq4-wheel'><div class='nq4-ptr'>▼</div><canvas id='nq4-cv' width='600' height='600'></canvas></div>"+
 "<div class='nq4-res' id='nq4-r'></div><div class='nq4-code' id='nq4-c'></div><div id='nq4-b'></div>"+
 "<button class='nq4-go' id='nq4-sp'"+(has?" disabled":"")+">🎡 "+(has?"Come back tomorrow":"SPIN!")+"</button>");
 var cv=$("#nq4-cv"),c=cv.getContext("2d"),n=PR.length,s=2*Math.PI/n,R=300;
 for(var i=0;i<n;i++){var a=i*s-Math.PI/2;c.beginPath();c.moveTo(R,R);c.arc(R,R,R-6,a,a+s);c.closePath();c.fillStyle=COL[i%COL.length];c.fill();c.strokeStyle="#fff";c.lineWidth=4;c.stroke();
  c.save();c.translate(R,R);c.rotate(a+s/2);c.textAlign="right";c.fillStyle="#fff";c.font="bold 32px sans-serif";c.fillText(PR[i].l,R-34,11);c.restore()}
 if(has)showRes(done,false);
}
function showRes(r,anim){
 var p=PR[r.i];
 $("#nq4-r").textContent=p.w?"🎉 You won "+p.t+"!":"😅 So close! Try again tomorrow.";
 if(p.w){$("#nq4-c").textContent="Your code: "+r.code+" (valid today)";
  $("#nq4-b").innerHTML="<a class='nq4-go' target='_blank' rel='noopener' href='"+wa("Hi Nqobile's Hub! I won "+p.t+" on the Spin & Win. My code is "+r.code+". I'd like to order...")+"'>💬 Claim on WhatsApp</a>"}
}
function doSpin(){
 var b=$("#nq4-sp");b.disabled=true;b.textContent="Spinning...";
 var n=PR.length,w=Math.floor(Math.random()*n),seg=360/n,jit=(Math.random()-.5)*seg*.7;
 var deg=360*6+((360-((w+.5)*seg+jit))%360+360)%360;
 $("#nq4-cv").style.transform="rotate("+deg+"deg)";
 var code="NQ-"+Math.random().toString(36).slice(2,6).toUpperCase();
 var r={d:today(),i:w,code:code};sv("nq4_spin",r);
 setTimeout(function(){showRes(r,true);b.textContent="Come back tomorrow";if(navigator.vibrate)navigator.vibrate([60,40,60])},4400);
}

function install(){
 frame("<button class='nq4-back' data-v='menu'>← Back</button><h2>📲 Add shop to my phone</h2><div class='sub'>Opens full screen like an app. Product photos stay available on weak signal.</div>"+
 (deferred?"<button class='nq4-go' id='nq4-i'>📲 Install now</button>":"")+
 "<div class='nq4-ins'><b>Android (Chrome):</b> tap the ⋮ menu, then <b>Add to Home screen</b>.<br><b>iPhone (Safari):</b> tap Share, then <b>Add to Home Screen</b>.</div>");
}

function init(){
 var f=document.createElement("button");f.id="nq4-fab";f.setAttribute("aria-label","Perks and tools");f.textContent="🎁";document.body.appendChild(f);
 ov=document.createElement("div");ov.id="nq4-ov";document.body.appendChild(ov);
 sh=document.createElement("div");sh.id="nq4-sh";sh.setAttribute("role","dialog");sh.setAttribute("aria-modal","true");document.body.appendChild(sh);
 f.onclick=function(){menu();open()};ov.onclick=close;
 document.addEventListener("keydown",function(e){if(e.key==="Escape")close()});
 sh.addEventListener("click",function(e){
  var t=e.target;
  if(t.id==="nq4-x"){close();return}
  var v=t.closest("[data-v]");
  if(v){var k=v.dataset.v;({menu:menu,build:build,spin:spin,install:install})[k]();sh.scrollTop=0;return}
  if(t.id==="nq4-sp"){doSpin();return}
  if(t.id==="nq4-i"&&deferred){deferred.prompt();return}
  if(t.id==="nq4-s"){
   var it=[].map.call(sh.querySelectorAll("input[type=checkbox]:checked"),function(x){return x.value});
   var base=($("input[name=nq4b]:checked")||{}).value||"";
   var nm=($("#nq4-n").value||"").trim(),nt=($("#nq4-nt").value||"").trim(),er=$("#nq4-e");er.textContent="";
   if(!it.length){er.textContent="Please tick at least one item.";return}
   if(!nm){er.textContent="Please enter your name.";$("#nq4-n").focus();return}
   sv("nq4_name",nm);
   var L=["Hi Nqobile's Hub! 🧺 Custom hamper request:","","Base: "+base,"Items:"];
   it.forEach(function(x){L.push("• "+x)});
   if(nt)L.push("","Notes: "+nt);
   L.push("","Name: "+nm,"Please confirm the price. Thanks!");
   window.open(wa(L.join("\n")),"_blank");
  }
 });
 sh.addEventListener("change",function(e){
  if(e.target.name==="nq4b")sh.querySelectorAll("input[name=nq4b]").forEach(function(r){r.parentNode.classList.toggle("on",r.checked)});
  else if(e.target.type==="checkbox")e.target.parentNode.classList.toggle("on",e.target.checked);
 });
 if("serviceWorker" in navigator&&location.protocol==="https:")navigator.serviceWorker.register("sw.js").catch(function(){});
}
if(document.readyState==="loading")document.addEventListener("DOMContentLoaded",init);else init();
})();
