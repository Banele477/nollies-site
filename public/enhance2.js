(function(){
var WA="27625873479",DELIVERY=30,KEY="nq_quick_v1";
var ITEMS=[
{id:"c",n:"Cereal Hamper",p:250,img:"images/1000040076.jpg"},
{id:"b",n:"Family Bulk Grocery Box",p:380,img:"images/1000040067.jpg"},
{id:"j",n:"Juices Africa & Tropika Pack",p:160,img:"images/1000040042.jpg"},
{id:"p",n:"M-Scents Perfume 40ml",p:120,img:"images/1000040057.jpg"},
{id:"d",n:"M-Scents Duo Gift Set (2x 40ml)",p:192,img:"images/1000040057.jpg"}];
var st={};try{st=JSON.parse(localStorage.getItem(KEY))||{}}catch(e){}
st.q=st.q||{};if(!st.mode)st.mode="delivery";
function save(){try{localStorage.setItem(KEY,JSON.stringify(st))}catch(e){}}
function R(n){return "R"+n.toFixed(2)}
function tot(){var s=0,c=0;ITEMS.forEach(function(i){var q=st.q[i.id]||0;s+=q*i.p;c+=q});return{s:s,c:c}}
function $(id){return document.getElementById(id)}
function build(){
  var fab=document.createElement("button");fab.id="nq-fab";fab.setAttribute("aria-label","Open quick order");document.body.appendChild(fab);
  var ov=document.createElement("div");ov.id="nq-ov";document.body.appendChild(ov);
  var sh=document.createElement("div");sh.id="nq-sheet";sh.setAttribute("role","dialog");sh.setAttribute("aria-modal","true");
  var rows=ITEMS.map(function(i){return '<div class="nq-row"><img src="'+i.img+'" alt="" onerror="this.style.visibility=\'hidden\'"><div class="t">'+i.n+'<small>'+R(i.p)+'</small></div><div class="nq-qty"><button data-m="'+i.id+'" aria-label="Less">−</button><span id="nq-q-'+i.id+'">0</span><button data-a="'+i.id+'" aria-label="More">+</button></div></div>'}).join("");
  sh.innerHTML='<button id="nq-x" aria-label="Close">✕</button><h2>⚡ Quick Order</h2><div class="sub">Pick items, then send your order straight to WhatsApp.</div>'+rows+
  '<input id="nq-name" placeholder="Your name" autocomplete="name">'+
  '<div class="nq-tog"><button data-mode="delivery">🚚 Delivery (R'+DELIVERY+')</button><button data-mode="collect">🏪 Collect</button></div>'+
  '<textarea id="nq-addr" rows="2" placeholder="Delivery address (street, suburb, Durban)"></textarea>'+
  '<div class="nq-sum"><div><span>Items</span><span id="nq-s1">R0.00</span></div><div><span>Delivery</span><span id="nq-s2">R0.00</span></div><div class="tot"><span>Total</span><span id="nq-s3">R0.00</span></div></div>'+
  '<div id="nq-err"></div><button id="nq-send">💬 Send order on WhatsApp</button><button id="nq-clear">Clear order</button>';
  document.body.appendChild(sh);
  $("nq-name").value=st.name||"";$("nq-addr").value=st.addr||"";
  function open(){ov.classList.add("open");sh.classList.add("open");document.body.classList.add("nq-lock")}
  function close(){ov.classList.remove("open");sh.classList.remove("open");document.body.classList.remove("nq-lock")}
  function render(){
    var t=tot(),d=(st.mode==="delivery"&&t.c>0)?DELIVERY:0;
    ITEMS.forEach(function(i){$("nq-q-"+i.id).textContent=st.q[i.id]||0});
    $("nq-s1").textContent=R(t.s);$("nq-s2").textContent=R(d);$("nq-s3").textContent=R(t.s+d);
    $("nq-addr").style.display=st.mode==="delivery"?"block":"none";
    sh.querySelectorAll("[data-mode]").forEach(function(b){b.classList.toggle("on",b.dataset.mode===st.mode)});
    fab.innerHTML='⚡ Quick Order'+(t.c?' <b>'+t.c+' · '+R(t.s+d)+'</b>':'');
    $("nq-send").disabled=t.c===0;
    save();
  }
  fab.onclick=open;ov.onclick=close;$("nq-x").onclick=close;
  document.addEventListener("keydown",function(e){if(e.key==="Escape")close()});
  sh.addEventListener("click",function(e){
    var b=e.target.closest("button");if(!b)return;
    if(b.dataset.a){st.q[b.dataset.a]=(st.q[b.dataset.a]||0)+1;if(navigator.vibrate)navigator.vibrate(15)}
    if(b.dataset.m){st.q[b.dataset.m]=Math.max(0,(st.q[b.dataset.m]||0)-1)}
    if(b.dataset.mode){st.mode=b.dataset.mode}
    render();
  });
  $("nq-name").oninput=function(){st.name=this.value;save()};
  $("nq-addr").oninput=function(){st.addr=this.value;save()};
  $("nq-clear").onclick=function(){st.q={};render()};
  $("nq-send").onclick=function(){
    var t=tot(),d=st.mode==="delivery"?DELIVERY:0,err=$("nq-err");err.textContent="";
    if(!(st.name||"").trim()){err.textContent="Please enter your name.";$("nq-name").focus();return}
    if(st.mode==="delivery"&&!(st.addr||"").trim()){err.textContent="Please enter your delivery address.";$("nq-addr").focus();return}
    var L=["Hi Nqobile's Hub! 🛒 New order:",""];
    ITEMS.forEach(function(i){var q=st.q[i.id]||0;if(q)L.push("• "+q+" x "+i.n+" = "+R(q*i.p))});
    L.push("","Items: "+R(t.s),(st.mode==="delivery"?"Delivery: "+R(d):"Collection: free"),"TOTAL: "+R(t.s+d),"","Name: "+st.name.trim());
    if(st.mode==="delivery")L.push("Address: "+st.addr.trim());
    window.open("https://wa.me/"+WA+"?text="+encodeURIComponent(L.join("\n")),"_blank");
  };
  render();
}
if(document.readyState!=="loading")build();else document.addEventListener("DOMContentLoaded",build);
})();
