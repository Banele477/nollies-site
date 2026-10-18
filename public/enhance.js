(function(){
var WA="27XXXXXXXXX";
var FALL="data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='600' height='400'><rect width='100%25' height='100%25' fill='%230f172a'/><text x='50%25' y='50%25' fill='white' font-family='sans-serif' font-size='22' text-anchor='middle'></text></svg>";
function fix(img){
  if(img.dataset.ux)return; img.dataset.ux=1;
  if(!img.hasAttribute('loading'))img.loading='lazy';
  img.decoding='async';
  img.addEventListener('error',function(){ if(img.src!==FALL){img.classList.add('ux-broken');img.src=FALL;} });
}
function scan(){ document.querySelectorAll('img').forEach(fix); }
new MutationObserver(scan).observe(document.documentElement,{childList:true,subtree:true});
document.addEventListener('DOMContentLoaded',function(){
  scan();
  var bar=document.createElement('div');bar.id='ux-progress';document.body.appendChild(bar);
  var top=document.createElement('button');top.id='ux-top';top.textContent='↑';top.setAttribute('aria-label','Back to top');
  top.onclick=function(){window.scrollTo({top:0,behavior:'smooth'})};document.body.appendChild(top);
  if(/^[0-9]{9,15}$/.test(WA)){
    var a=document.createElement('a');a.id='ux-wa';a.target='_blank';a.rel='noopener';
    a.href='https://wa.me/'+WA+'?text='+encodeURIComponent("Hi Nqobile's Hub, I'd like to order...");
    a.innerHTML='💬 Order on WhatsApp';document.body.appendChild(a);
  }
  var t=document.createElement('div');t.id='ux-toast';document.body.appendChild(t);
  function toast(m){t.textContent=m;t.style.display='block';setTimeout(function(){t.style.display='none'},3000)}
  window.addEventListener('offline',function(){toast('📡 You are offline')});
  window.addEventListener('online',function(){toast('✅ Back online')});
  window.addEventListener('scroll',function(){
    var h=document.documentElement.scrollHeight-innerHeight;
    bar.style.width=(h>0?scrollY/h*100:0)+'%';
    top.classList.toggle('show',scrollY>600);
  },{passive:true});
});
})();
