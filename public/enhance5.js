(function(){
if(window.__nq5)return;window.__nq5=1;
var C=window.NQ_CFG||{};
var WA=C.wa||"27625873479",FEE=(C.fee===""||isNaN(Number(C.fee)))?30:Number(C.fee);
var ITEMS=[
{id:"c",n:"Cereal Hamper",p:250,e:"🥣",img:"images/hamper-tropika-cereals.jpg"},
{id:"b",n:"Family Bulk Grocery Box",p:380,e:"📦",img:"images/bulk-box-full.jpg"},
{id:"j",n:"Juices Africa & Tropika Pack",p:160,e:"🧃",img:"images/juices-africa-flavours.jpg"},
{id:"p",n:"M-Scents Perfume 40ml",p:120,e:"💎",img:""},
{id:"d",n:"M-Scents Duo Gift Set (2x 40ml)",p:192,e:"🎁",img:""}];
function $(s,r){return(r||document).querySelector(s)}
function esc(s){return String(s==null?"":s).replace(/[&<>"']/g,function(c){return{"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#39;"}[c]})}
function R(n){return"R"+Number(n).toFixed(2)}
function ld(k,d){try{var v=JSON.parse(localStorage.getItem(k));return v==null?d:v}catch(e){return d}}
function sv(k,v){try{localStorage.setItem(k,JSON.stringify(v))}catch(e){}}
function wa(t){return"https://wa.me/"+WA+"?text="+(window.nqEnc||encodeURIComponent)(t)}
var cart=ld("nq5_cart",{q:{}}),me=ld("nq5_me",{mode:"delivery",pay:"cod"}),orders=ld("nq5_orders",[]);
if(!cart.q)cart.q={};
var sh,ov;
function toast(m){var t=$("#nq5-t");t.textContent=m;t.style.display="block";setTimeout(function(){t.style.display="none"},2200)}
function methods(){
 var M=[{k:"cod",l:"💵 Cash on delivery / collection",d:"Pay when you receive your order"}];
 if(C.bankAcc)M.push({k:"eft",l:"🏦 EFT / bank transfer",d:"Pay now, then send proof on WhatsApp"});
 if(C.shapId)M.push({k:"shap",l:"⚡ PayShap (instant, any SA bank)",d:"Capitec, FNB, Absa, Standard Bank, Nedbank, TymeBank and more"});
 if(C.pfId&&C.pfKey)M.push({k:"card",l:"💳 Card, instant EFT or Capitec Pay",d:"Pay on PayFast's secure page"});
 if(C.linkUrl)M.push({k:"link",l:C.linkLabel||"🔗 Pay online",d:"Opens a secure payment page"});
 return M}
function payLabel(k){return{cod:"Cash on delivery / collection",eft:"EFT / bank transfer",shap:"PayShap (instant bank payment)",card:"Card, instant EFT or Capitec Pay (PayFast)",link:"Online payment link"}[k]||k}
function lines(){return ITEMS.filter(function(i){return cart.q[i.id]>0}).map(function(i){return{id:i.id,n:i.n,p:i.p,q:cart.q[i.id]}})}
function sub(){return lines().reduce(function(s,l){return s+l.p*l.q},0)}
function fee(){return(me.mode==="delivery"&&sub()>0)?FEE:0}
function openS(){ov.classList.add("open");sh.classList.add("open");document.body.style.overflow="hidden"}
function closeS(){ov.classList.remove("open");sh.classList.remove("open");document.body.style.overflow=""}
function frame(h,keep){var y=keep?sh.scrollTop:0;sh.innerHTML="<button class='nq5-x' data-g='close' aria-label='Close'>✕</button>"+h;sh.scrollTop=y}

function sCart(keep){
 var h="<h2>🛒 Your order</h2><div class='nq5-sub'>Pick your items, then check out. <button class='nq5-lnk' data-g='hist'>📋 My orders"+(orders.length?" ("+orders.length+")":"")+"</button></div>";
 ITEMS.forEach(function(i){var q=cart.q[i.id]||0;
  h+="<div class='nq5-row'>"+(i.img?"<img src='"+i.img+"' alt='' onerror=\"this.outerHTML='<div class=nq5-em>"+i.e+"</div>'\">":"<div class='nq5-em'>"+i.e+"</div>")+"<div class='nq5-t'>"+esc(i.n)+"<small>"+R(i.p)+"</small></div><div class='nq5-q'><button data-m='"+i.id+"' aria-label='Less'>−</button><span>"+q+"</span><button data-a='"+i.id+"' aria-label='More'>+</button></div></div>"});
 var s=sub();
 h+="<div class='nq5-sum'><div class='tot'><span>Items</span><span>"+R(s)+"</span></div></div><button class='nq5-go' data-g='details'"+(s?"":" disabled")+">Continue to checkout →</button>";
 frame(h,keep)}

function sDetail(){
 var M=methods();if(!M.some(function(m){return m.k===me.pay}))me.pay="cod";
 var h="<button class='nq5-back' data-g='cart'>← Edit items</button><h2>📝 Your details</h2>"+
 "<input id='nq5-n' type='text' placeholder='Your name' autocomplete='name' value=\""+esc(me.name||"")+"\">"+
 "<input id='nq5-p' type='tel' inputmode='tel' placeholder='Phone / WhatsApp number' autocomplete='tel' value=\""+esc(me.phone||"")+"\">"+
 "<div class='nq5-tog'><button data-mode='delivery'>🚚 Delivery (R"+FEE+")</button><button data-mode='collect'>🏪 Collect (free)</button></div>"+
 "<textarea id='nq5-a' rows='2' placeholder='Delivery address (street, suburb, Durban)'>"+esc(me.addr||"")+"</textarea>"+
 "<textarea id='nq5-nt' rows='2' placeholder='Notes (optional)'>"+esc(me.notes||"")+"</textarea><div class='nq5-h'>Payment</div><div class='nq5-sub' style='margin:-2px 0 10px'>Pay from any South African bank, including Capitec, FNB, Absa, Standard Bank, Nedbank and TymeBank.</div>";
 M.forEach(function(m){h+="<label class='nq5-opt' data-k='"+m.k+"'><input type='radio' name='nq5pay' value='"+m.k+"'><span><b>"+m.l+"</b><small>"+m.d+"</small></span></label>"});
 h+="<div class='nq5-sum' id='nq5-sum'></div><div class='nq5-err' id='nq5-e'></div><button class='nq5-go' id='nq5-place'></button>";
 frame(h);upd()}
function upd(){
 sh.querySelectorAll("[data-mode]").forEach(function(b){b.classList.toggle("on",b.dataset.mode===me.mode)});
 var a=$("#nq5-a");if(a)a.style.display=me.mode==="delivery"?"block":"none";
 sh.querySelectorAll(".nq5-opt").forEach(function(l){var on=l.dataset.k===me.pay;l.classList.toggle("on",on);l.querySelector("input").checked=on});
 var s=sub(),f=fee(),el=$("#nq5-sum");
 if(el)el.innerHTML="<div><span>Items</span><span>"+R(s)+"</span></div><div><span>Delivery</span><span>"+R(f)+"</span></div><div class='tot'><span>Total</span><span>"+R(s+f)+"</span></div>";
 var b=$("#nq5-place");if(b)b.textContent=me.pay==="card"?"💳 Pay "+R(s+f)+" securely":me.pay==="link"?"🔗 Place order & pay":"✅ Place order"}

function mkNo(){var d=new Date(),p=function(n){return("0"+n).slice(-2)};return"NQ"+String(d.getFullYear()).slice(2)+p(d.getMonth()+1)+p(d.getDate())+"-"+Math.random().toString(36).slice(2,6).toUpperCase()}
function itemsTxt(o){return o.lines.map(function(l){return l.q+"x "+l.n}).join("; ")}
function msg(o){
 var L=["Hi Nqobile's Hub! 🛒 New order *"+o.no+"*",""];
 o.lines.forEach(function(l){L.push("• "+l.q+" x "+l.n+" = "+R(l.q*l.p))});
 L.push("","Items: "+R(o.sub),o.mode==="delivery"?"Delivery: "+R(o.fee):"Collection: free","TOTAL: "+R(o.total),"Payment: "+payLabel(o.pay),"","Name: "+o.name,"Phone: "+o.phone);
 L.push(o.mode==="delivery"?"Address: "+o.addr:"Collecting in person");
 if(o.notes)L.push("Notes: "+o.notes);
 return L.join("\n")}
function logO(o){
 if(!C.endpoint)return;
 try{fetch(C.endpoint,{method:"POST",mode:"no-cors",headers:{"Content-Type":"text/plain"},body:JSON.stringify({no:o.no,time:new Date(o.t).toISOString(),name:o.name,phone:o.phone,mode:o.mode,addr:o.addr,items:itemsTxt(o),sub:o.sub,fee:o.fee,total:o.total,pay:payLabel(o.pay),status:o.status,notes:o.notes})}).catch(function(){})}catch(e){}}
function saveO(){sv("nq5_orders",orders.slice(0,20))}

function place(){
 var er=$("#nq5-e"),s=sub(),f=fee(),tot=s+f;er.textContent="";
 var name=(me.name||"").trim(),phone=(me.phone||"").trim(),digits=phone.replace(/\D/g,"");
 if(!s){er.textContent="Your cart is empty.";return}
 if(!name){er.textContent="Please enter your name.";$("#nq5-n").focus();return}
 if(digits.length<9){er.textContent="Please enter a valid phone number.";$("#nq5-p").focus();return}
 if(me.mode==="delivery"&&!(me.addr||"").trim()){er.textContent="Please enter your delivery address.";$("#nq5-a").focus();return}
 if(me.pay==="card"&&tot<5){er.textContent="Card payments start at R5.00. Choose another method.";return}
 var o={no:mkNo(),t:Date.now(),lines:lines(),sub:s,fee:f,total:tot,name:name,phone:phone,mode:me.mode,addr:(me.addr||"").trim(),notes:(me.notes||"").trim(),pay:me.pay,
  status:me.pay==="card"?"Sent to PayFast (check dashboard)":me.pay==="cod"?"Pay on delivery/collection":"Awaiting payment"};
 orders.unshift(o);saveO();logO(o);cart.q={};sv("nq5_cart",cart);
 $("#nq5-place").disabled=true;
 if(o.pay==="card"){goPay(o);return}
 window.open(wa(msg(o)),"_blank");
 sDone(o)}

function goPay(o){
 frame("<div class='nq5-ok'>💳</div><h2 style='text-align:center'>Taking you to PayFast...</h2><div class='nq5-sub' style='text-align:center'>Order "+o.no+" · "+R(o.total)+"<br>Please don't close this page.</div>");
 var f=document.createElement("form");f.method="post";
 f.action=(C.pfSandbox==="true"?"https://sandbox.payfast.co.za":"https://www.payfast.co.za")+"/eng/process";
 var base=location.origin+location.pathname;
 var ph=o.phone.replace(/\D/g,"");if(/^27\d{9}$/.test(ph))ph="0"+ph.slice(2);
 var desc=(itemsTxt(o)+" | "+o.name+" "+o.phone+" | "+(o.mode==="delivery"?o.addr:"Collect")).slice(0,255);
 var F={merchant_id:C.pfId,merchant_key:C.pfKey,return_url:base+"?nqo="+o.no+"&nqs=paid",cancel_url:base+"?nqo="+o.no+"&nqs=cancel",name_first:o.name.split(" ")[0].slice(0,100),m_payment_id:o.no,amount:o.total.toFixed(2),item_name:("Order "+o.no).slice(0,100),item_description:desc};
 if(/^0\d{9}$/.test(ph))F.cell_number=ph;
 Object.keys(F).forEach(function(k){var i=document.createElement("input");i.type="hidden";i.name=k;i.value=F[k];f.appendChild(i)});
 document.body.appendChild(f);setTimeout(function(){f.submit()},600)}

function bankRows(o){
 var r=[["Bank",C.bankName],["Account holder",C.bankHolder],["Account number",C.bankAcc,1],["Account type",C.bankType],["Reference",o.no,1],["Amount",R(o.total)]],h="";
 r.forEach(function(x){if(!x[1])return;h+="<div class='nq5-br'><span>"+x[0]+"<br><b>"+esc(x[1])+"</b></span>"+(x[2]?"<button data-copy='"+esc(x[1])+"'>Copy</button>":"")+"</div>"});
 return h}
function shapRows(o){
 var r=[["ShapID (cellphone number)",C.shapId,1],["Account name",C.shapName],["Reference",o.no,1],["Amount",R(o.total)]],h="";
 r.forEach(function(x){if(!x[1])return;h+="<div class='nq5-br'><span>"+x[0]+"<br><b>"+esc(x[1])+"</b></span>"+(x[2]?"<button data-copy='"+esc(x[1])+"'>Copy</button>":"")+"</div>"});
 return h}
function sDone(o){
 var h="<div class='nq5-ok'>✅</div><h2 style='text-align:center'>Order placed!</h2><div class='nq5-no'>"+o.no+"</div><div class='nq5-sub' style='text-align:center'>Total "+R(o.total)+" · "+esc(payLabel(o.pay))+"</div>";
 if(o.pay==="cod")h+="<div class='nq5-box'>We'll confirm on WhatsApp. Pay "+(o.mode==="delivery"?"in cash when your order arrives.":"when you collect.")+"</div>";
 if(o.pay==="eft")h+="<div class='nq5-box'><b>Pay by EFT</b>"+bankRows(o)+"<div class='nq5-sub' style='margin:8px 0 0'>Use <b>"+o.no+"</b> as the payment reference.</div></div><a class='nq5-go' target='_blank' rel='noopener' href='"+wa("Hi Nqobile's Hub! I've paid order "+o.no+" ("+R(o.total)+") by EFT. Proof of payment attached.")+"'>📎 I've paid: send proof</a>";
 if(o.pay==="shap")h+="<div class='nq5-box'><b>Pay with PayShap</b>"+shapRows(o)+"<div class='nq5-sub' style='margin:8px 0 0'>In your banking app choose PayShap, pay the ShapID above and use <b>"+o.no+"</b> as the reference. PayShap payments cannot be reversed, so double-check the details first.</div></div><a class='nq5-go' target='_blank' rel='noopener' href='"+wa("Hi Nqobile's Hub! I've paid order "+o.no+" ("+R(o.total)+") by PayShap.")+"'>📎 I've paid: send proof</a>";
 if(o.pay==="link"&&C.linkUrl)h+="<a class='nq5-go' target='_blank' rel='noopener' href='"+esc(C.linkUrl)+"'>"+esc(C.linkLabel||"🔗 Pay online")+" ("+R(o.total)+")</a><div class='nq5-sub' style='margin-top:8px'>Enter "+R(o.total)+" and use "+o.no+" as the reference.</div>";
 h+="<a class='nq5-go nq5-wa' target='_blank' rel='noopener' href='"+wa(msg(o))+"'>💬 Send order on WhatsApp</a><button class='nq5-sec' data-g='hist'>📋 My orders</button><button class='nq5-sec' data-g='close'>Keep shopping</button>";
 frame(h)}
function sHist(){
 var h="<button class='nq5-back' data-g='cart'>← Back</button><h2>📋 My orders</h2><div class='nq5-sub'>Saved on this phone.</div>";
 if(!orders.length)h+="<div class='nq5-box'>No orders yet.</div>";
 orders.forEach(function(o){h+="<div class='nq5-ord'><b>"+o.no+"</b> · "+new Date(o.t).toLocaleDateString()+"<br>"+esc(itemsTxt(o))+"<br>"+R(o.total)+" · "+esc(o.status)+"<div class='b'><button data-re='"+o.no+"'>🔁 Reorder</button><a target='_blank' rel='noopener' href='"+wa(msg(o))+"'>💬 WhatsApp</a></div></div>"});
 frame(h)}
function reorder(no){var o=orders.filter(function(x){return x.no===no})[0];if(!o)return;cart.q={};o.lines.forEach(function(l){cart.q[l.id]=l.q});sv("nq5_cart",cart);sCart();toast("Items added to your cart")}

function handleReturn(){
 var p=new URLSearchParams(location.search),no=p.get("nqo"),st=p.get("nqs");
 if(!no||!st)return;
 try{history.replaceState(null,"",location.pathname)}catch(e){}
 var o=orders.filter(function(x){return x.no===no})[0];if(!o)return;
 openS();
 if(st==="paid"){
  o.status="Payment submitted via PayFast (verify in dashboard)";saveO();
  frame("<div class='nq5-ok'>🎉</div><h2 style='text-align:center'>Payment submitted!</h2><div class='nq5-no'>"+o.no+"</div><div class='nq5-sub' style='text-align:center'>Please confirm on WhatsApp so we can prepare your order.</div><a class='nq5-go nq5-wa' target='_blank' rel='noopener' href='"+wa(msg(o)+"\n\n✅ I paid "+R(o.total)+" by card/instant EFT via PayFast.")+"'>💬 Confirm on WhatsApp</a><button class='nq5-sec' data-g='close'>Close</button>");
 }else{
  o.status="Payment cancelled";saveO();
  frame("<div class='nq5-ok'>😕</div><h2 style='text-align:center'>Payment not completed</h2><div class='nq5-sub' style='text-align:center'>No money was taken. Your items are still saved.</div><button class='nq5-go' data-re='"+o.no+"'>🔁 Try again</button><button class='nq5-sec' data-g='close'>Close</button>");
 }}

function go(g){({close:closeS,cart:sCart,details:sDetail,hist:sHist})[g]()}
function init(){
 var t=document.createElement("div");t.id="nq5-t";document.body.appendChild(t);
 ov=document.createElement("div");ov.id="nq5-ov";document.body.appendChild(ov);
 sh=document.createElement("div");sh.id="nq5-sh";sh.setAttribute("role","dialog");sh.setAttribute("aria-modal","true");document.body.appendChild(sh);
 ov.onclick=closeS;document.addEventListener("keydown",function(e){if(e.key==="Escape")closeS()});
 function show(){sCart();openS()}
 sh.addEventListener("click",function(e){
  var b=e.target.closest("button,a");if(!b)return;var d=b.dataset;
  if(d.a){cart.q[d.a]=(cart.q[d.a]||0)+1;sv("nq5_cart",cart);if(navigator.vibrate)navigator.vibrate(12);sCart(true);return}
  if(d.m){cart.q[d.m]=Math.max(0,(cart.q[d.m]||0)-1);sv("nq5_cart",cart);sCart(true);return}
  if(d.g){go(d.g);return}
  if(d.mode){me.mode=d.mode;sv("nq5_me",me);upd();return}
  if(d.re){reorder(d.re);return}
  if(d.copy){if(navigator.clipboard)navigator.clipboard.writeText(d.copy).then(function(){toast("Copied!")});return}
  if(b.id==="nq5-place")place()});
 sh.addEventListener("change",function(e){if(e.target.name==="nq5pay"){me.pay=e.target.value;sv("nq5_me",me);upd()}});
 sh.addEventListener("input",function(e){var m={"nq5-n":"name","nq5-p":"phone","nq5-a":"addr","nq5-nt":"notes"}[e.target.id];if(m){me[m]=e.target.value;sv("nq5_me",me)}});
 var tries=0,iv=setInterval(function(){
  var f=$("#nq-fab");
  if(f){f.onclick=function(ev){if(ev)ev.preventDefault();show()};clearInterval(iv)}
  else if(++tries>20){clearInterval(iv);var b=document.createElement("button");b.id="nq-fab";b.className="nq5-fab";b.textContent="🛒 Order";b.onclick=show;document.body.appendChild(b)}
 },400);
 handleReturn();
}
if(document.readyState==="loading")document.addEventListener("DOMContentLoaded",init);else init();
})();
