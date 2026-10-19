(function(){
"use strict";
if(window.__nq8)return;window.__nq8=1;
const C=window.NQ_CFG||{};
const $=(s,r)=>(r||document).querySelector(s);
const $$=(s,r)=>[].slice.call((r||document).querySelectorAll(s));
const esc=s=>String(s==null?"":s).replace(/[&<>"']/g,c=>({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#39;"}[c]));
const R=n=>"R"+Number(n).toFixed(2);
const R0=n=>"R"+Math.round(n);
const enc=s=>encodeURIComponent(s).replace(/'/g,"%27");
const WA=String(C.wa||"27625873479").replace(/\D/g,"");
const PH=WA.length===11?"0"+WA.slice(2,4)+" "+WA.slice(4,7)+" "+WA.slice(7):WA;
const MAIL="nqobilegila518@gmail.com";
const FEE=(C.fee===undefined||C.fee===""||isNaN(+C.fee))?30:+C.fee;
const OWNER="Banele477",REPO="nollies-site",BRANCH="main";
const CDN="https://cdn.jsdelivr.net/gh/"+OWNER+"/"+REPO+"@"+BRANCH+"/public/images/";
const BASE=location.pathname.replace(/[^\/]*$/,"");
const FALL="data:image/svg+xml;utf8,"+encodeURIComponent("<svg xmlns='http://www.w3.org/2000/svg' width='400' height='400'><rect width='100%' height='100%' fill='#0f172a'/><text x='50%' y='50%' fill='white' font-family='sans-serif' font-size='20' text-anchor='middle'>Nqobile's Hub</text></svg>");
const wa=t=>"https://wa.me/"+WA+"?text="+enc(t);
const ld=(k,d)=>{try{const v=JSON.parse(localStorage.getItem(k));return v==null?d:v}catch(e){return d}};
const sv=(k,v)=>{try{localStorage.setItem(k,JSON.stringify(v))}catch(e){}};

/* ---------- products ---------- */
const SC=["Silver Sense","Red Dezire","White OUD","Blue Dezire","Stallion for Him","Sky OUD","Gorgeous Girl","Wild Intense"];
const FL=["Guava","Mixed Berry","Cocktail","Tropical Punch"];
const KEY={"Silver Sense":["silver","selver"],"Red Dezire":["red dezire","dezire red"],"White OUD":["white oud"],"Blue Dezire":["blue dezire","dezire blue"],"Stallion for Him":["stallion"],"Sky OUD":["sky"],"Gorgeous Girl":["gorgeous"],"Wild Intense":["wild","intense"],"Guava":["guava"],"Mixed Berry":["berry"],"Cocktail":["cocktail"],"Tropical Punch":["tropical","punch"]};
const P=[
{id:"hamper",cat:"hamper",n:"Cereal Hamper",d:"Breakfast hamper, 4 cereal packages",p:250,img:"hamper-tropika-cereals.jpg",tag:"Best seller"},
{id:"combo",cat:"hamper",n:"Cereal Combo",d:"Combo of 3 cereal items",p:170,img:"rice-puffs-cereals.jpg",tag:"Combo"},
{id:"bulk",cat:"hamper",n:"Family Bulk Grocery Box",d:"Packed bulk box, ready for delivery",p:380,img:"bulk-box-full.jpg"},
{id:"juice",cat:"juice",n:"Juices Africa 4L",d:"Concentrate, makes 20 litres",p:160,img:"juices-africa-flavours.jpg",opts:FL},
{id:"juice2",cat:"juice",n:"2 Juices Deal",d:"2 x 4L Juices Africa. Put your flavours in the order notes",p:224,old:320,img:"juices-africa-flavours.jpg",tag:"Save R96"},
{id:"perf",cat:"perfume",n:"M-Scents Perfume 40ml",d:"Luxury fragrance",p:120,art:1,opts:SC},
{id:"perf2",cat:"perfume",n:"2 Perfumes Deal",d:"2 x 40ml. Put your scents in the order notes",p:192,old:240,art:1,tag:"Save R48"}];
const prod=id=>P.find(p=>p.id===id);
const PL={cod:"Cash on delivery / collection",eft:"EFT / bank transfer",shap:"PayShap (instant bank payment)",ps:"Paystack (card, instant EFT, QR)",card:"PayFast (card, instant EFT, Capitec Pay)",link:"Online payment link"};
const ST={cod:"Pay on delivery/collection",eft:"Awaiting EFT payment",shap:"Awaiting PayShap payment",ps:"Paystack popup opened",card:"Sent to PayFast (check dashboard)",link:"Awaiting online payment"};
const ART='<svg viewBox="0 0 120 120" aria-hidden="true"><rect x="40" y="8" width="40" height="14" rx="4" fill="#e2e8f0"/><rect x="52" y="22" width="16" height="10" fill="#94a3b8"/><rect x="26" y="32" width="68" height="78" rx="16" fill="#7c3aed"/><rect x="34" y="42" width="8" height="58" rx="4" fill="rgba(255,255,255,.35)"/><rect x="46" y="64" width="40" height="22" rx="4" fill="rgba(255,255,255,.85)"/></svg>';

/* ---------- state ---------- */
let cart=(ld("nq8_cart",[])||[]).filter(x=>x&&prod(x.id)&&x.q>0);
let me=ld("nq8_me",null)||{mode:"delivery",pay:"cod"};
let orders=ld("nq8_orders",[])||[];
let sCat="all",sQ="";
let ov,sh,ai,ts,tabs;
const saveCart=()=>{sv("nq8_cart",cart);badge()};
const saveO=()=>sv("nq8_orders",orders.slice(0,20));
const saveMe=()=>sv("nq8_me",me);
const count=()=>cart.reduce((a,x)=>a+x.q,0);
const lines=()=>cart.map(x=>{const p=prod(x.id);return{id:x.id,opt:x.opt||"",n:p.n+(x.opt?" ("+x.opt+")":""),p:p.p,q:x.q}});
const sum=()=>lines().reduce((s,l)=>s+l.p*l.q,0);
const fee=()=>(me.mode==="delivery"&&sum()>0)?FEE:0;
const itemsTxt=o=>o.lines.map(l=>l.q+"x "+l.n).join("; ");
function addCart(id,opt,q){opt=opt||"";const l=cart.find(x=>x.id===id&&(x.opt||"")===opt);if(l)l.q+=q;else cart.push({id:id,opt:opt,q:q});saveCart()}
function chg(i,d){const l=cart[i];if(!l)return;l.q+=d;if(l.q<=0)cart.splice(i,1);saveCart();vCart(true)}
function badge(){const b=$("#nq8-bc");if(!b)return;const n=count();b.textContent=n;b.style.display=n?"block":"none"}
let tt;function toast(m){if(!ts)return;ts.textContent=m;ts.classList.add("on");clearTimeout(tt);tt=setTimeout(()=>ts.classList.remove("on"),2400)}
function mk(tag,id){const e=document.createElement(tag);e.id=id;document.body.appendChild(e);return e}

/* ---------- image fallback (site, then GitHub CDN) ---------- */
document.addEventListener("error",e=>{const t=e.target;if(!t||t.tagName!=="IMG"||!t.dataset.n)return;const l=[BASE+"images/"+t.dataset.n,BASE+"public/images/"+t.dataset.n,CDN+t.dataset.n],i=(+t.dataset.i||0)+1;if(i<l.length){t.dataset.i=i;t.src=l[i]}else{t.removeAttribute("data-n");t.src=FALL}},true);
const thumb=p=>p.img?'<img data-n="'+p.img+'" src="'+BASE+'images/'+p.img+'" alt="'+esc(p.n)+'" loading="lazy">':'<div class="art">'+ART+'</div>';

/* ---------- sheet plumbing ---------- */
function frame(h,keep){const y=keep?sh.scrollTop:0;sh.innerHTML='<button class="x" data-close aria-label="Close">✕</button>'+h;sh.scrollTop=y}
function setTab(n){$$("#nq8-tabs button").forEach(b=>b.classList.toggle("on",b.dataset.t===n))}
function openSheet(fn){fn();ov.classList.add("on");sh.classList.add("on");ai.classList.remove("on");document.body.style.overflow="hidden"}
function closeAll(){ov.classList.remove("on");sh.classList.remove("on");ai.classList.remove("on");document.body.style.overflow="";setTab("home")}
function view(v){
 if(v==="co"&&!cart.length){toast("Add items to your cart first");v="shop"}
 const f={shop:vShop,cart:vCart,co:vCo,hist:vHist}[v];if(!f)return;
 openSheet(f);setTab(v==="co"?"order":v==="hist"?"cart":v)}
function tab(t){
 if(t==="home"){closeAll();window.scrollTo({top:0,behavior:"smooth"})}
 else if(t==="order")view("co");
 else if(t==="ai")openAI();
 else view(t)}

/* ---------- shop ---------- */
function card(p){
 return '<article class="c" data-cat="'+p.cat+'" data-q="'+esc((p.n+" "+p.d+" "+(p.opts||[]).join(" ")).toLowerCase())+'">'+
 '<div class="im">'+thumb(p)+(p.tag?'<span class="tg">'+esc(p.tag)+'</span>':'')+'</div><div class="bd"><h3>'+esc(p.n)+'</h3><p>'+esc(p.d)+'</p>'+
 (p.opts?'<select aria-label="Choose option">'+p.opts.map(o=>'<option>'+esc(o)+'</option>').join("")+'</select>':'')+
 '<div class="pr"><b>'+R0(p.p)+'</b>'+(p.old?'<s>R'+p.old+'</s>':'')+'</div><button class="add" data-add="'+p.id+'">🛒 Add to cart</button></div></article>'}
function vShop(){
 const ch=[["all","All"],["hamper","🥣 Hampers"],["juice","🧃 Juices"],["perfume","💎 Perfumes"]];
 frame('<h2>🛍️ Shop</h2><div class="s">Real stock · R'+FEE+' flat delivery in Durban</div><input id="nq8-sq" type="search" placeholder="🔍 Search hampers, juices, perfumes..." value="'+esc(sQ)+'"><div class="chs">'+ch.map(c=>'<button data-f="'+c[0]+'" class="'+(sCat===c[0]?"on":"")+'">'+c[1]+'</button>').join("")+'</div><div class="g">'+P.map(card).join("")+'</div><div class="no2" id="nq8-no" hidden>No match. <a target="_blank" rel="noopener" href="'+wa("Hi Nqobile's Hub, do you have something else?")+'">Ask us on WhatsApp</a></div><div class="bar" id="nq8-bar"></div>');
 filt();bar()}
function filt(){const q=sQ.trim().toLowerCase();let n=0;$$(".c",sh).forEach(c=>{const ok=(sCat==="all"||c.dataset.cat===sCat)&&(!q||c.dataset.q.indexOf(q)>-1);c.hidden=!ok;if(ok)n++});const no=$("#nq8-no");if(no)no.hidden=n>0}
function bar(){const b=$("#nq8-bar");if(!b)return;const n=count();b.innerHTML=n?'<button class="go" data-v="cart">🛒 View cart · '+n+' item'+(n>1?"s":"")+' · '+R0(sum())+'</button>':""}
function addFromCard(b){const c=b.closest(".c"),sel=c&&c.querySelector("select");addCart(b.dataset.add,sel?sel.value:"",1);b.textContent="✓ Added";setTimeout(()=>{b.textContent="🛒 Add to cart"},900);if(navigator.vibrate)navigator.vibrate(12);bar();toast("Added to cart")}

/* ---------- cart ---------- */
function vCart(keep){
 const L=lines();let h='<h2>🛒 Your cart</h2>';
 if(!L.length)h+='<div class="box">Your cart is empty.</div><button class="go" data-v="shop">🛍️ Browse the shop</button>';
 else{
  L.forEach((l,i)=>{h+='<div class="row"><div class="th">'+thumb(prod(l.id))+'</div><div class="t">'+esc(l.n)+'<small>'+R(l.p)+' each</small></div><div class="q"><button data-m="'+i+'" aria-label="Less">−</button><span>'+l.q+'</span><button data-p="'+i+'" aria-label="More">+</button></div></div>'});
  h+='<div class="sum"><div class="tot"><span>Items</span><span>'+R(sum())+'</span></div></div><div class="s">Delivery (R'+FEE+') is added at checkout.</div><button class="go" data-v="co">⚡ Checkout</button><button class="sec" data-v="shop">+ Add more items</button>'}
 h+='<button class="sec" data-v="hist">📋 My orders'+(orders.length?" ("+orders.length+")":"")+'</button>';
 frame(h,keep)}

/* ---------- checkout + payments ---------- */
function methods(){
 const M=[{k:"cod",l:"💵 Cash on delivery / collection",d:"Pay when you receive your order"}];
 if(C.bankAcc)M.push({k:"eft",l:"🏦 EFT / bank transfer",d:"Pay now, then send proof on WhatsApp"});
 if(C.shapId)M.push({k:"shap",l:"⚡ PayShap (instant, any SA bank)",d:"Capitec, FNB, Absa, Standard Bank, Nedbank, TymeBank and more"});
 if(C.psKey)M.push({k:"ps",l:"🚀 Paystack: card, instant EFT or QR",d:"Secure popup, pay without leaving the page"});
 if(C.pfId&&C.pfKey)M.push({k:"card",l:"💳 PayFast: card, instant EFT or Capitec Pay",d:"Pay on PayFast's secure page"});
 if(C.linkUrl)M.push({k:"link",l:C.linkLabel||"🔗 Pay online",d:"Opens a secure payment page"});
 return M}
function vCo(){
 if(!cart.length){vShop();return}
 const M=methods();if(!M.some(m=>m.k===me.pay))me.pay="cod";
 let h='<button class="back" data-v="cart">← Edit cart</button><h2>📝 Checkout</h2>'+
 '<input id="nq8-n" type="text" placeholder="Your name" autocomplete="name" value="'+esc(me.name||"")+'">'+
 '<input id="nq8-p" type="tel" inputmode="tel" placeholder="Phone / WhatsApp number" autocomplete="tel" value="'+esc(me.phone||"")+'">'+
 '<input id="nq8-e" type="email" placeholder="Email (needed for Paystack receipts)" autocomplete="email" value="'+esc(me.email||"")+'">'+
 '<div class="tog"><button data-mode="delivery">🚚 Delivery (R'+FEE+')</button><button data-mode="collect">🏪 Collect (free)</button></div>'+
 '<textarea id="nq8-a" rows="2" placeholder="Delivery address (street, suburb, Durban)">'+esc(me.addr||"")+'</textarea>'+
 '<textarea id="nq8-nt" rows="2" placeholder="Notes (e.g. juice flavours or perfume choices)">'+esc(me.notes||"")+'</textarea>'+
 '<div class="hh">Payment</div><div class="s">Pay from any South African bank, including Capitec, FNB, Absa, Standard Bank, Nedbank and TymeBank.</div>';
 M.forEach(m=>{h+='<label class="opt" data-k="'+m.k+'"><input type="radio" name="nq8pay" value="'+m.k+'"><span><b>'+m.l+'</b><small>'+m.d+'</small></span></label>'});
 h+='<div class="sum" id="nq8-sm"></div><div class="err" id="nq8-er"></div><button class="go" id="nq8-place"></button>';
 frame(h);upd()}
function upd(){
 $$("[data-mode]",sh).forEach(b=>b.classList.toggle("on",b.dataset.mode===me.mode));
 const a=$("#nq8-a");if(a)a.style.display=me.mode==="delivery"?"block":"none";
 $$(".opt",sh).forEach(l=>{const on=l.dataset.k===me.pay;l.classList.toggle("on",on);l.querySelector("input").checked=on});
 const s=sum(),f=fee(),el=$("#nq8-sm");
 if(el)el.innerHTML='<div><span>Items</span><span>'+R(s)+'</span></div><div><span>Delivery</span><span>'+R(f)+'</span></div><div class="tot"><span>Total</span><span>'+R(s+f)+'</span></div>';
 const b=$("#nq8-place");if(b)b.textContent=({ps:"🚀 Pay "+R(s+f)+" with Paystack",card:"💳 Pay "+R(s+f)+" with PayFast",link:"🔗 Place order and pay"})[me.pay]||"✅ Place order"}
function mkNo(){const d=new Date(),p=n=>("0"+n).slice(-2);return"NQ"+String(d.getFullYear()).slice(2)+p(d.getMonth()+1)+p(d.getDate())+"-"+Math.random().toString(36).slice(2,6).toUpperCase()}
function msg(o){
 const L=["Hi Nqobile's Hub! 🛒 New order *"+o.no+"*",""];
 o.lines.forEach(l=>L.push("• "+l.q+" x "+l.n+" = "+R(l.q*l.p)));
 L.push("","Items: "+R(o.sub),o.mode==="delivery"?"Delivery: "+R(o.fee):"Collection: free","TOTAL: "+R(o.total),"Payment: "+(PL[o.pay]||o.pay),"","Name: "+o.name,"Phone: "+o.phone);
 L.push(o.mode==="delivery"?"Address: "+o.addr:"Collecting in person");
 if(o.notes)L.push("Notes: "+o.notes);
 return L.join("\n")}
function logO(o){if(!C.endpoint)return;try{fetch(C.endpoint,{method:"POST",mode:"no-cors",headers:{"Content-Type":"text/plain"},body:JSON.stringify({no:o.no,time:new Date(o.t).toISOString(),name:o.name,phone:o.phone,mode:o.mode,addr:o.addr,items:itemsTxt(o),sub:o.sub,fee:o.fee,total:o.total,pay:PL[o.pay]||o.pay,status:o.status,notes:o.notes})}).catch(()=>{})}catch(e){}}
function place(){
 const er=$("#nq8-er"),L=lines(),s=sum(),f=fee(),tot=s+f;er.textContent="";
 const name=(me.name||"").trim(),phone=(me.phone||"").trim(),email=(me.email||"").trim();
 if(!L.length){er.textContent="Your cart is empty.";return}
 if(!name){er.textContent="Please enter your name.";$("#nq8-n").focus();return}
 if(phone.replace(/\D/g,"").length<9){er.textContent="Please enter a valid phone number.";$("#nq8-p").focus();return}
 if(me.mode==="delivery"&&!(me.addr||"").trim()){er.textContent="Please enter your delivery address.";$("#nq8-a").focus();return}
 if(me.pay==="ps"&&!/^\S+@\S+\.\S+$/.test(email)){er.textContent="Paystack needs your email address for the receipt.";$("#nq8-e").focus();return}
 if((me.pay==="card"||me.pay==="ps")&&tot<5){er.textContent="Card payments start at R5.00. Choose another method.";return}
 const o={no:mkNo(),t:Date.now(),lines:L,sub:s,fee:f,total:tot,name:name,phone:phone,email:email,mode:me.mode,addr:(me.addr||"").trim(),notes:(me.notes||"").trim(),pay:me.pay,status:ST[me.pay]||"New"};
 orders.unshift(o);saveO();logO(o);cart=[];saveCart();$("#nq8-place").disabled=true;
 if(o.pay==="ps"){goPaystack(o);return}
 if(o.pay==="card"){goPay(o);return}
 window.open(wa(msg(o)),"_blank");vDone(o)}

/* Paystack (public key only; popup keeps card data on Paystack) */
function loadPS(ok,fail){if(window.PaystackPop)return ok();const s=document.createElement("script");s.src="https://js.paystack.co/v1/inline.js";s.onload=ok;s.onerror=fail;document.head.appendChild(s)}
function goPaystack(o){
 frame('<div class="big">🚀</div><h2 class="ct">Opening Paystack...</h2><div class="s ct">Order '+o.no+' · '+R(o.total)+'</div>');
 loadPS(function(){
  try{
   const h=window.PaystackPop.setup({key:C.psKey,email:o.email,amount:Math.round(o.total*100),currency:"ZAR",ref:o.no,
    metadata:{custom_fields:[{display_name:"Name",variable_name:"name",value:o.name},{display_name:"Phone",variable_name:"phone",value:o.phone},{display_name:"Items",variable_name:"items",value:itemsTxt(o).slice(0,200)},{display_name:"Delivery",variable_name:"delivery",value:(o.mode==="delivery"?o.addr:"Collect").slice(0,200)}]},
    callback:function(r){o.status="Paid via Paystack (ref "+((r&&r.reference)||o.no)+"), verify in dashboard";saveO();vPaid(o,"Paystack")},
    onClose:function(){if(/Paid/.test(o.status))return;o.status="Paystack closed, not paid";saveO();vCancel(o)}});
   h.openIframe();
  }catch(e){o.status="Paystack error";saveO();vCancel(o,"Could not open Paystack. Try another payment method.")}
 },function(){o.status="Paystack failed to load";saveO();vCancel(o,"Could not load Paystack. Check your signal or choose another method.")})}

/* PayFast (redirect form, no secrets on the site) */
function goPay(o){
 frame('<div class="big">💳</div><h2 class="ct">Taking you to PayFast...</h2><div class="s ct">Order '+o.no+' · '+R(o.total)+'<br>Please do not close this page.</div>');
 const f=document.createElement("form");f.method="post";
 f.action=(C.pfSandbox==="true"?"https://sandbox.payfast.co.za":"https://www.payfast.co.za")+"/eng/process";
 const b=location.origin+location.pathname;let ph=o.phone.replace(/\D/g,"");if(/^27\d{9}$/.test(ph))ph="0"+ph.slice(2);
 const F={merchant_id:C.pfId,merchant_key:C.pfKey,return_url:b+"?nq8o="+o.no+"&nq8s=paid",cancel_url:b+"?nq8o="+o.no+"&nq8s=cancel",name_first:o.name.split(" ")[0].slice(0,100),m_payment_id:o.no,amount:o.total.toFixed(2),item_name:("Order "+o.no).slice(0,100),item_description:(itemsTxt(o)+" | "+o.name+" "+o.phone+" | "+(o.mode==="delivery"?o.addr:"Collect")).slice(0,255)};
 if(/^0\d{9}$/.test(ph))F.cell_number=ph;
 if(o.email)F.email_address=o.email;
 Object.keys(F).forEach(k=>{const i=document.createElement("input");i.type="hidden";i.name=k;i.value=F[k];f.appendChild(i)});
 document.body.appendChild(f);setTimeout(()=>f.submit(),600)}

/* ---------- result screens ---------- */
const rows=r=>r.filter(x=>x[1]).map(x=>'<div class="br"><span>'+x[0]+'<br><b>'+esc(x[1])+'</b></span>'+(x[2]?'<button data-copy="'+esc(x[1])+'">Copy</button>':'')+'</div>').join("");
function vDone(o){
 let h='<div class="big">✅</div><h2 class="ct">Order placed!</h2><div class="no">'+o.no+'</div><div class="s ct">Total '+R(o.total)+' · '+esc(PL[o.pay]||o.pay)+'</div>';
 if(o.pay==="cod")h+='<div class="box">We will confirm on WhatsApp. Pay '+(o.mode==="delivery"?"in cash when your order arrives":"when you collect")+'.</div>';
 if(o.pay==="eft")h+='<div class="box"><b>Pay by EFT</b>'+rows([["Bank",C.bankName],["Account holder",C.bankHolder],["Account number",C.bankAcc,1],["Account type",C.bankType],["Reference",o.no,1],["Amount",R(o.total)]])+'<div class="s" style="margin:8px 0 0">Use <b>'+o.no+'</b> as the payment reference.</div></div><a class="go" target="_blank" rel="noopener" href="'+wa("Hi Nqobile's Hub! I've paid order "+o.no+" ("+R(o.total)+") by EFT. Proof of payment attached.")+'">📎 I have paid: send proof</a>';
 if(o.pay==="shap")h+='<div class="box"><b>Pay with PayShap</b>'+rows([["ShapID (cellphone number)",C.shapId,1],["Account name",C.shapName],["Reference",o.no,1],["Amount",R(o.total)]])+'<div class="s" style="margin:8px 0 0">In your banking app choose PayShap, pay the ShapID above and use <b>'+o.no+'</b> as the reference. PayShap payments cannot be reversed, so double-check the details.</div></div><a class="go" target="_blank" rel="noopener" href="'+wa("Hi Nqobile's Hub! I've paid order "+o.no+" ("+R(o.total)+") by PayShap.")+'">📎 I have paid: send proof</a>';
 if(o.pay==="link"&&C.linkUrl)h+='<a class="go" target="_blank" rel="noopener" href="'+esc(C.linkUrl)+'">'+esc(C.linkLabel||"🔗 Pay online")+' ('+R(o.total)+')</a><div class="s" style="margin-top:8px">Enter '+R(o.total)+' and use '+o.no+' as the reference.</div>';
 h+='<a class="go wa" target="_blank" rel="noopener" href="'+wa(msg(o))+'">💬 Send order on WhatsApp</a><button class="sec" data-v="hist">📋 My orders</button><button class="sec" data-close>Keep shopping</button>';
 frame(h)}
function vPaid(o,via){frame('<div class="big">🎉</div><h2 class="ct">Payment submitted!</h2><div class="no">'+o.no+'</div><div class="s ct">Please confirm on WhatsApp so we can prepare your order.</div><a class="go wa" target="_blank" rel="noopener" href="'+wa(msg(o)+"\n\n✅ I paid "+R(o.total)+" via "+via+".")+'">💬 Confirm on WhatsApp</a><button class="sec" data-close>Close</button>')}
function vCancel(o,t){frame('<div class="big">😕</div><h2 class="ct">Payment not completed</h2><div class="s ct">'+esc(t||"No money was taken. Your items are saved so you can try again.")+'</div><button class="go" data-re="'+o.no+'">🔁 Try again</button><button class="sec" data-close>Close</button>')}
function vHist(){
 let h='<button class="back" data-v="cart">← Back</button><h2>📋 My orders</h2><div class="s">Saved on this phone.</div>';
 if(!orders.length)h+='<div class="box">No orders yet.</div>';
 orders.forEach(o=>{h+='<div class="ord"><b>'+o.no+'</b> · '+new Date(o.t).toLocaleDateString()+'<br>'+esc(itemsTxt(o))+'<br>'+R(o.total)+' · '+esc(o.status)+'<div class="bt"><button data-re="'+o.no+'">🔁 Reorder</button><a target="_blank" rel="noopener" href="'+wa(msg(o))+'">💬 WhatsApp</a></div></div>'});
 frame(h)}
function reorder(no){const o=orders.find(x=>x.no===no);if(!o)return;cart=o.lines.map(l=>({id:l.id,opt:l.opt,q:l.q})).filter(x=>prod(x.id));saveCart();view("cart");toast("Items added to your cart")}
function handleReturn(){
 const p=new URLSearchParams(location.search),no=p.get("nq8o"),st=p.get("nq8s");if(!no||!st)return;
 try{history.replaceState(null,"",location.pathname)}catch(e){}
 const o=orders.find(x=>x.no===no);if(!o)return;
 if(st==="paid"){o.status="PayFast payment submitted (verify in dashboard)";saveO();openSheet(()=>vPaid(o,"PayFast"))}
 else{o.status="PayFast payment cancelled";saveO();openSheet(()=>vCancel(o))}}

/* ---------- AI assistant (works offline, no API key) ---------- */
const ACT=[];
const act=(l,f)=>({l:l,f:f});
function say(who,text,acts){
 const m=$("#nq8-msgs"),d=document.createElement("div");d.className="mg "+who;
 let h=esc(text).replace(/\n/g,"<br>");
 if(acts&&acts.length)h+='<div class="ac">'+acts.map(a=>{if(a.href)return'<a'+(/^http/.test(a.href)?' target="_blank" rel="noopener"':'')+' href="'+esc(a.href)+'">'+esc(a.l)+'</a>';ACT.push(a.f);return'<button data-a="'+(ACT.length-1)+'">'+esc(a.l)+'</button>'}).join("")+'</div>';
 d.innerHTML=h;m.appendChild(d);m.scrollTop=m.scrollHeight}
const CHIPS=["🔥 Specials","🚚 Delivery","💳 How to pay","💎 Perfumes","🧃 Juices","🥣 Hampers","💰 Under R300","🛒 My cart"];
function chips(){$("#nq8-chips").innerHTML=CHIPS.map(c=>'<button data-ai="'+esc(c)+'">'+esc(c)+'</button>').join("")}
const W=()=>({t:"Sawubona! 👋 I am Nqobile AI. I can help with prices, specials, delivery and payments, build a hamper to your budget, and add things to your cart. What do you need?"});
function openAI(){ov.classList.add("on");ai.classList.add("on");sh.classList.remove("on");document.body.style.overflow="hidden";setTab("ai");if(!$("#nq8-msgs").children.length){say("b",W().t);chips()}}
function send(text){
 text=String(text||"").trim();if(!text)return;say("u",text);
 const m=$("#nq8-msgs"),ty=document.createElement("div");ty.className="mg b ty";ty.textContent="typing…";m.appendChild(ty);m.scrollTop=m.scrollHeight;
 const done=r=>{ty.remove();say("b",r.t,r.a)};
 if(C.aiEndpoint){
  let fin=false;const to=setTimeout(()=>{if(!fin){fin=true;done(ans(text))}},8000);
  fetch(C.aiEndpoint,{method:"POST",headers:{"Content-Type":"text/plain"},body:JSON.stringify({message:text,cart:lines(),fee:FEE})}).then(r=>r.json()).then(j=>{if(fin)return;fin=true;clearTimeout(to);done(j&&j.reply?{t:String(j.reply)}:ans(text))}).catch(()=>{if(fin)return;fin=true;clearTimeout(to);done(ans(text))});
 }else setTimeout(()=>done(ans(text)),420+Math.random()*320)}
function sendInput(){const i=$("#nq8-in");const v=i.value;i.value="";send(v)}
function optFrom(p,t){for(const o of p.opts){if((KEY[o]||[o.toLowerCase()]).some(k=>t.indexOf(k)>-1))return o}return p.opts[0]}
function parseProds(t){
 const out=[],used={},num={one:1,two:2,three:3,four:4,five:5,six:6};
 const q=w=>{const m=t.match(new RegExp("\\b(\\d{1,2}|one|two|three|four|five|six)\\s*(?:x\\s*)?(?:of\\s+)?(?:"+w+")"));if(!m)return 1;const n=num[m[1]]||+m[1];return Math.max(1,Math.min(20,n||1))};
 const add=(id,w)=>{if(used[id])return;used[id]=1;const p=prod(id);out.push({id:id,q:q(w),opt:p.opts?optFrom(p,t):""})};
 if(/\b(2|two)\s*(x\s*)?juices?\b/.test(t)||/2 juices deal/.test(t))add("juice2","juices?");
 else if(/juice|concentrate|guava|berry|cocktail|punch|\b4 ?l\b/.test(t))add("juice","juices?|juice|bottles?|concentrates?");
 if(/\b(2|two)\s*(x\s*)?perfumes?\b/.test(t)||/2 perfumes deal/.test(t))add("perf2","perfumes?");
 else if(/perfume|scent|fragrance|cologne|\boud\b|dezire|stallion|gorgeous|intense|silver sense/.test(t))add("perf","perfumes?|scents?|fragrances?|colognes?");
 if(/combo|3 cereal|three cereal/.test(t))add("combo","combos?");
 if(/\bbulk\b|family (grocery )?box|grocery box/.test(t))add("bulk","(?:bulk |family |grocery )?box(?:es)?");
 if(/hamper|cereal|breakfast|oats|weet|corn ?flakes|nutrific|futurelife/.test(t)&&!used.combo)add("hamper","hampers?");
 return out}
function budget(t){
 let m=t.match(/\b(?:under|below|within|budget(?: is| of)?|max(?:imum)?|around|about|up to|upto|less than)\s*r?\s*(\d{2,4})\b/);
 if(!m)m=t.match(/\br\s?(\d{3,4})\s*(?:budget|hamper|only)\b/);
 if(!m)m=t.match(/^r?\s?(\d{3,4})$/);
 if(!m)return 0;const n=+m[1];return(n>=50&&n<=5000)?n:0}
function rec(B){
 const max=B-FEE,pool=["hamper","combo","juice","juice2","perf","perf2","bulk"].map(prod);
 if(max<120)return{t:"For R"+B+" the cheapest option is one M-Scents perfume at R120 (collect it for free, or R"+(120+FEE)+" with delivery). A little more opens up hampers and juices!",a:[act("🛍️ Open shop",()=>view("shop"))]};
 let best=null;
 for(let m=1;m<(1<<pool.length);m++){
  let s=0;const cats=new Set(),pick=[];
  pool.forEach((p,i)=>{if(m&(1<<i)){s+=p.p;cats.add(p.cat);pick.push(p)}});
  const ids=pick.map(p=>p.id);
  if((ids.indexOf("juice")>-1&&ids.indexOf("juice2")>-1)||(ids.indexOf("perf")>-1&&ids.indexOf("perf2")>-1))continue;
  if(s<=max&&(!best||cats.size>best.c||(cats.size===best.c&&s>best.s)))best={s:s,c:cats.size,pick:pick}}
 if(!best)return{t:"Let me know your budget again and I will find the best mix.",a:[]};
 return{t:"With R"+B+" (including R"+FEE+" delivery) I would suggest:\n• "+best.pick.map(p=>p.n+" "+R0(p.p)).join("\n• ")+"\n\nTotal: "+R0(best.s)+" + R"+FEE+" delivery = "+R0(best.s+FEE)+" (or "+R0(best.s)+" if you collect).",a:[act("➕ Add these to my cart",()=>{best.pick.forEach(p=>addCart(p.id,p.opts?p.opts[0]:"",1));toast("Added to cart");view("cart")}),act("🛍️ Open shop",()=>view("shop"))]}}
function addBy(found){
 const names=[];let note=false;
 found.forEach(f=>{addCart(f.id,f.opt,f.q);const p=prod(f.id);names.push(f.q+" x "+p.n+(f.opt?" ("+f.opt+")":""));if(f.id==="juice2"||f.id==="perf2")note=true});
 return{t:"Done! ✅ Added to your cart:\n• "+names.join("\n• ")+"\n\nCart total: "+R0(sum())+" (+ R"+FEE+" if delivered)."+(note?"\nTip: put your flavours or scents in the notes at checkout.":""),a:[act("🛒 View cart",()=>view("cart")),act("⚡ Checkout",()=>view("co")),act("+ Add more",()=>view("shop"))]}}
function info(id){
 const p=prod(id);
 if(p.cat==="juice")return{t:"🧃 Juices Africa 4L concentrate is "+R0(prod("juice").p)+" a bottle and makes 20 litres (dilute 1 + 4). Flavours: "+FL.join(", ")+".\nDeal: 2 bottles for "+R0(prod("juice2").p)+" (normally R320).",a:[act("Add 1 Guava",()=>{addCart("juice","Guava",1);toast("Added to cart")}),act("Add 2 Juices Deal",()=>{addCart("juice2","",1);toast("Added to cart")}),act("🛒 View cart",()=>view("cart"))]};
 if(p.cat==="perfume")return{t:"💎 M-Scents perfumes (40ml) are "+R0(prod("perf").p)+" each. Scents: "+SC.join(", ")+".\nDeal: any 2 for "+R0(prod("perf2").p)+" (normally R240).",a:[act("Add 2 Perfumes Deal",()=>{addCart("perf2","",1);toast("Added to cart")}),act("🛍️ Open shop",()=>view("shop"))]};
 return{t:"🥣 Cereal Hamper "+R0(prod("hamper").p)+" (4 cereal packages), Cereal Combo "+R0(prod("combo").p)+" (3 items) and the Family Bulk Grocery Box "+R0(prod("bulk").p)+". Our photos show brands like Jungle Oats, Weet-Bix, Bokomo Corn Flakes, Nutrific and Futurelife. Message us to confirm today's mix.",a:[act("Add a Cereal Hamper",()=>{addCart("hamper","",1);toast("Added to cart")}),act("🛍️ Open shop",()=>view("shop"))]}}
function deals(){return{t:"🔥 Current specials:\n• 2 Juices Deal "+R0(224)+" (was R320)\n• 2 Perfumes Deal "+R0(192)+" (was R240)\n• Cereal Combo "+R0(170)+" (3 items)\n• Flat R"+FEE+" delivery",a:[act("Add 2 Juices Deal",()=>{addCart("juice2","",1);toast("Added to cart")}),act("Add 2 Perfumes Deal",()=>{addCart("perf2","",1);toast("Added to cart")}),act("Add Cereal Combo",()=>{addCart("combo","",1);toast("Added to cart")})]}}
function delivery(){return{t:"🚚 Delivery is a flat R"+FEE+" across Durban and eNanda. Choose Collect at checkout and it is free. We confirm your order on WhatsApp before dispatch.",a:[act("🛍️ Start shopping",()=>view("shop"))]}}
function payAns(){return{t:"💳 You can pay by:\n• "+methods().map(m=>m.l.replace(/^\S+\s+/,"")).join("\n• ")+"\n\nYou can pay from any South African bank, including Capitec, FNB, Absa, Standard Bank, Nedbank and TymeBank.",a:[act("⚡ Go to checkout",()=>view("co"))]}}
function bulkAns(){return{t:"📦 Yes, we do bulk and larger orders for churches, events and funerals. Send us the quantities and the date you need them on WhatsApp and we will quote you.",a:[{l:"💬 Ask for a bulk quote",href:wa("Hi Nqobile's Hub, I'd like a bulk quote for: ")}]}}
function contact(){return{t:"📞 You can reach us on "+PH+" (call or WhatsApp) or "+MAIL+".",a:[{l:"💬 WhatsApp",href:wa("Hi Nqobile's Hub, I have a question.")},{l:"📞 Call",href:"tel:+"+WA}]}}
function priceList(){return{t:"🛍️ Prices:\n• Cereal Hamper "+R0(250)+"\n• Cereal Combo "+R0(170)+"\n• Family Bulk Grocery Box "+R0(380)+"\n• Juices Africa 4L "+R0(160)+"\n• M-Scents Perfume 40ml "+R0(120)+"\n• 2 Juices "+R0(224)+" · 2 Perfumes "+R0(192),a:[act("🛍️ Open shop",()=>view("shop"))]}}
function cartSum(){
 const L=lines();if(!L.length)return{t:"Your cart is empty. Want me to suggest something for your budget?",a:[act("🛍️ Open shop",()=>view("shop"))]};
 return{t:"🛒 Your cart:\n• "+L.map(l=>l.q+" x "+l.n+" = "+R0(l.q*l.p)).join("\n• ")+"\n\nItems: "+R0(sum())+" (+ R"+FEE+" delivery)",a:[act("⚡ Checkout",()=>view("co")),act("View cart",()=>view("cart"))]}}
function histAns(){
 if(!orders.length)return{t:"You have no orders on this phone yet. Once you order, you can see it here and reorder in one tap.",a:[act("🛍️ Open shop",()=>view("shop"))]};
 return{t:"📋 Your latest orders:\n• "+orders.slice(0,3).map(o=>o.no+" · "+R0(o.total)+" · "+o.status).join("\n• "),a:[act("📋 See all orders",()=>view("hist"))]}}
function ans(raw){
 const t=raw.toLowerCase().replace(/[^\w\s+.,?!'-]/g," ").replace(/\s+/g," ").trim();
 if(/^(hi|hello|hey|sawubona|molo|howzit|hola|good (morning|afternoon|evening))\b/.test(t)&&t.length<30)return W();
 if(/\b(thanks?|thank you|siyabonga|ngiyabonga|cheers)\b/.test(t))return{t:"You are welcome! 😊 Anything else I can help with?"};
 const B=budget(t);if(B)return rec(B);
 const found=parseProds(t);
 if(found.length&&/\b(add|put|buy|order|want|need|get|take|give me)\b/.test(t)&&!/church|funeral|event|wedding|party|reseller|wholesale/.test(t))return addBy(found);
 if(/\b(human|agent|person|speak|call|contact|whatsapp|phone|number|email|talk)\b/.test(t))return contact();
 if(/\b(cart|basket|checkout|total)\b/.test(t))return cartSum();
 if(/\b(track|status|my orders?|order history|where is my)\b/.test(t))return histAns();
 if(/\b(deals?|specials?|promos?|offers?|discount|save|cheap|sale)\b/.test(t))return deals();
 if(/\b(deliver\w*|shipping|fee|collect\w*|pick ?up|areas?|enanda|durban)\b/.test(t))return delivery();
 if(/\b(pay|payment|payments|eft|capitec|card|payshap|snapscan|cash|bank|fnb|absa|nedbank|standard bank|tymebank|paystack|payfast)\b/.test(t))return payAns();
 if(/\b(bulk|church|funeral|event|wedding|party|reseller|re-seller|wholesale)\b/.test(t))return bulkAns();
 if(/\b(price|prices|cost|how much|menu|catalog|catalogue|what do you (sell|have))\b/.test(t)&&!found.length)return priceList();
 if(found.length)return info(found[0].id);
 return{t:"I am not sure about that one 🤔 I can help with prices, specials, delivery, payments, or build a hamper to your budget (try \"under R300\"). For anything else, message us on WhatsApp.",a:[{l:"💬 Ask on WhatsApp",href:wa("Hi Nqobile's Hub, "+raw)},act("🔥 See specials",()=>send("specials"))]}}

/* ---------- events ---------- */
document.addEventListener("click",e=>{
 const b=e.target.closest&&e.target.closest(".nq8-oldai");if(!b)return;
 e.preventDefault();e.stopPropagation();e.stopImmediatePropagation();openAI()},true);
document.addEventListener("click",e=>{
 const b=e.target.closest&&e.target.closest("button,a,label");
 if(!b||!b.closest("#nq8-sh,#nq8-ai,#nq8-tabs,#nq8-fab"))return;
 const d=b.dataset;
 if(d.t){tab(d.t);return}
 if(d.close!==undefined){closeAll();return}
 if(d.v){view(d.v);return}
 if(d.add){addFromCard(b);return}
 if(d.f){sCat=d.f;$$(".chs button",sh).forEach(x=>x.classList.toggle("on",x.dataset.f===sCat));filt();return}
 if(d.m!==undefined){chg(+d.m,-1);return}
 if(d.p!==undefined){chg(+d.p,1);return}
 if(d.mode){me.mode=d.mode;saveMe();upd();return}
 if(d.re){reorder(d.re);return}
 if(d.copy){if(navigator.clipboard)navigator.clipboard.writeText(d.copy).then(()=>toast("Copied!"));return}
 if(d.ai){send(d.ai);return}
 if(d.a!==undefined){const f=ACT[+d.a];if(f)f();return}
 if(b.id==="nq8-place"){place();return}
 if(b.id==="nq8-send"){sendInput();return}
});
document.addEventListener("change",e=>{if(e.target.name==="nq8pay"){me.pay=e.target.value;saveMe();upd()}});
document.addEventListener("input",e=>{
 const id=e.target.id,m={"nq8-n":"name","nq8-p":"phone","nq8-e":"email","nq8-a":"addr","nq8-nt":"notes"}[id];
 if(m){me[m]=e.target.value;saveMe()}
 if(id==="nq8-sq"){sQ=e.target.value;filt()}});
document.addEventListener("keydown",e=>{
 if(e.key==="Escape"&&ov&&ov.classList.contains("on"))closeAll();
 if(e.key==="Enter"&&e.target.id==="nq8-in"){e.preventDefault();sendInput()}});

/* ---------- find the old AI bubble and re-route it ---------- */
function oldAI(){
 if($(".nq8-oldai"))return true;
 const root=$("#root");if(!root)return false;
 const all=root.querySelectorAll("*");
 for(let i=0;i<all.length;i++){
  const e=all[i];if(getComputedStyle(e).position!=="fixed")continue;
  const r=e.getBoundingClientRect();
  if(r.width>=36&&r.width<=110&&r.height>=36&&r.height<=110&&r.right>innerWidth-130&&r.bottom>innerHeight*.5){e.classList.add("nq8-oldai");return true}}
 return false}

function init(){
 ov=mk("div","nq8-ov");sh=mk("div","nq8-sh");ai=mk("div","nq8-ai");ts=mk("div","nq8-ts");tabs=mk("nav","nq8-tabs");
 sh.setAttribute("role","dialog");sh.setAttribute("aria-modal","true");ai.setAttribute("role","dialog");ai.setAttribute("aria-modal","true");
 tabs.innerHTML='<button data-t="home"><b>🏠</b>Home</button><button data-t="shop"><b>🛍️</b>Shop</button><button data-t="cart"><b>🛒</b>Cart<i id="nq8-bc"></i></button><button data-t="order"><b>⚡</b>Order</button><button data-t="ai"><b>🤖</b>AI</button>';
 ai.innerHTML='<div class="ah"><span>🤖 <b>Nqobile AI</b><small>Prices · deals · delivery · cart</small></span><button class="x" data-close aria-label="Close">✕</button></div><div class="ms" id="nq8-msgs"></div><div class="cp" id="nq8-chips"></div><div class="ir"><input id="nq8-in" type="text" placeholder="Ask me anything..." autocomplete="off" enterkeyhint="send"><button id="nq8-send" aria-label="Send">➤</button></div>';
 ov.onclick=closeAll;
 setTab("home");badge();handleReturn();
 let tries=0;const iv=setInterval(()=>{
  if(oldAI()){clearInterval(iv);return}
  if(++tries>14){clearInterval(iv);if(!$("#nq8-fab")){const f=mk("button","nq8-fab");f.textContent="🤖";f.dataset.t="ai";f.setAttribute("aria-label","Ask Nqobile AI")}}
 },500)}
if(document.readyState==="loading")document.addEventListener("DOMContentLoaded",init);else init();
})();
