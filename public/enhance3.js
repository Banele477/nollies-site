(function(){
if(window.__nq3)return;window.__nq3=1;
var WA="27625873479";
function $(s,r){return(r||document).querySelector(s)}
function ready(f){document.readyState!=="loading"?f():document.addEventListener("DOMContentLoaded",f)}
function toast(m){var t=$("#nq3-toast");t.textContent=m;t.style.display="block";setTimeout(function(){t.style.display="none"},2500)}
ready(function(){
  var tb=document.createElement("div");tb.id="nq3-trust";
  tb.innerHTML="<span>🚚 R30 delivery in Durban</span><span>💵 Pay on delivery</span><span>💬 Order on WhatsApp</span><span>✅ Real stock photos</span>";
  document.body.insertBefore(tb,document.body.firstChild);
  var tt=document.createElement("div");tt.id="nq3-toast";document.body.appendChild(tt);

  var nav=document.createElement("nav");nav.id="nq3-nav";
  nav.innerHTML="<button data-g='top'><span>🏠</span>Home</button><button data-g='shop'><span>🛍️</span>Shop</button><button data-g='order'><span>⚡</span>Order</button><a class='go' target='_blank' rel='noopener' href='https://wa.me/"+WA+"?text="+encodeURIComponent("Hi Nqobile's Hub, I have a question.")+"'><span>💬</span>Chat</a>";
  nav.addEventListener("click",function(e){var b=e.target.closest("button");if(!b)return;
    if(b.dataset.g==="top")scrollTo({top:0,behavior:"smooth"});
    if(b.dataset.g==="shop"){var s=$("#nqc");s?s.scrollIntoView({behavior:"smooth"}):toast("Shop is loading...")}
    if(b.dataset.g==="order"){var f=$("#nq-fab");f?f.click():toast("Order is loading...")}
  });
  document.body.appendChild(nav);

  var tries=0,iv=setInterval(function(){
    var c=$("#nqc");
    if(c){clearInterval(iv);enhance(c)}else if(++tries>40)clearInterval(iv);
  },300);
});
function enhance(c){
  var ch=$(".ch",c),g=$(".g",c);
  var q=document.createElement("input");q.id="nq3-search";q.type="search";q.placeholder="🔍 Search hampers, juices, cereals...";q.setAttribute("aria-label","Search products");
  c.insertBefore(q,ch);
  var none=document.createElement("div");none.id="nq3-none";g.parentNode.insertBefore(none,g.nextSibling);
  function apply(){
    var k=(ch.querySelector("button.on")||{dataset:{k:"all"}}).dataset.k,s=q.value.trim().toLowerCase(),n=0;
    g.querySelectorAll(".c").forEach(function(d){
      var ok=(k==="all"||d.dataset.c===k)&&(!s||d.textContent.toLowerCase().indexOf(s)>-1);
      d.style.display=ok?"":"none";if(ok)n++;
    });
    if(!n){none.innerHTML="No match. <a target='_blank' rel='noopener' href='https://wa.me/"+WA+"?text="+encodeURIComponent("Hi Nqobile's Hub, do you have: "+q.value)+"'>Ask us on WhatsApp</a>";none.style.display="block"}else none.style.display="none";
  }
  q.addEventListener("input",apply);
  ch.addEventListener("click",function(){setTimeout(apply,0)});

  var faq=document.createElement("section");faq.id="nq3-faq";
  faq.innerHTML="<h2>❓ Good to know</h2>"+
  "<details><summary>How does delivery work?</summary><p>We deliver across Durban and eNanda for a flat R30. Send your order on WhatsApp and we confirm it with you.</p></details>"+
  "<details><summary>How do I pay?</summary><p>Cash on delivery is available. Ask us on WhatsApp about other options.</p></details>"+
  "<details><summary>Can I collect my order?</summary><p>Yes. Choose Collect in the Order sheet and delivery is free.</p></details>"+
  "<details><summary>Do you do bulk orders?</summary><p>Yes. Hampers, bulk boxes and juice concentrates are available in bulk. Message us for a quote.</p></details>";
  c.parentNode.insertBefore(faq,c.nextSibling);

  var foot=document.createElement("div");foot.id="nq3-foot";
  foot.innerHTML="<div>📞 062 587 3479</div><a target='_blank' rel='noopener' href='https://wa.me/"+WA+"'>💬 WhatsApp us</a><button id='nq3-share'>📤 Share this shop</button>";
  faq.parentNode.insertBefore(foot,faq.nextSibling);
  $("#nq3-share").onclick=function(){
    var d={title:"Nqobile's Durban Hub",text:"Cereal hampers, Juices Africa and more. Order on WhatsApp.",url:location.href.split("#")[0]};
    if(navigator.share)navigator.share(d).catch(function(){});
    else if(navigator.clipboard)navigator.clipboard.writeText(d.url).then(function(){toast("Link copied!")});
  };
}
})();
