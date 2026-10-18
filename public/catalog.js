(function(){
if(window.__nqCat)return;window.__nqCat=1;
var WA="27625873479";
var P=window.NQ_PHOTOS||[];

function init(){
  var sec=document.createElement("section");
  sec.id="nqc";
  sec.style.cssText="max-width:1200px;margin:30px auto 120px;padding:0 16px;color:#f8fafc;font-family:system-ui,sans-serif;";
  
  sec.innerHTML=`
    <div style="background:rgba(15,23,42,0.9);border:1px solid rgba(56,189,248,0.3);border-radius:24px;padding:24px;margin-bottom:24px;display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:20px;">
      <div>
        <h1 style="font-size:26px;font-weight:900;color:#fff;margin:0 0 6px 0;">Sawubona! Welcome to Nollie's Quantum Hub.</h1>
        <p style="color:#94a3b8;font-size:13.5px;margin:0;">Company Founder & Lead Director: <b>Nolly</b> | Lead Developer & Architect: <b>Banele Gumbi</b></p>
      </div>
      <div style="background:rgba(30,41,59,0.8);padding:14px 20px;border-radius:16px;font-size:13px;color:#cbd5e1;">
        <div>Coverage: <b>eNqanda & Surrounds</b></div>
        <div>Flat Fee: <b>R30.00</b></div>
        <div style="margin-top:6px;"><a href="https://wa.me/${WA}" target="_blank" style="color:#4ade80;font-weight:700;text-decoration:none;">WhatsApp Dispatch ↗</a></div>
      </div>
    </div>
    <div style="background:rgba(15,23,42,0.85);border:1px solid rgba(255,255,255,0.1);border-radius:24px;padding:28px;text-align:center;">
      <h2 style="color:#38bdf8;margin-top:0;">Quantum Storefront Active</h2>
      <p style="color:#94a3b8;">All files are clean, stable, and running smoothly.</p>
      <a href="https://wa.me/${WA}?text=Hi%20Nollie's%20Hub,%20I%20want%20to%20place%20an%20order!" target="_blank" style="display:inline-block;margin-top:16px;padding:12px 24px;background:#38bdf8;color:#0f172a;font-weight:800;border-radius:12px;text-decoration:none;">💬 Order via WhatsApp</a>
    </div>
  `;
  document.body.appendChild(sec);
}

if(document.readyState==="loading") document.addEventListener("DOMContentLoaded", init); else init();
})();
