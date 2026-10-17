(() => {
  'use strict';
  const $ = s => document.querySelector(s);
  const LS = {
    get(k, d) { try { return JSON.parse(localStorage.getItem(k)) ?? d; } catch (e) { return d; } },
    set(k, v) { try { localStorage.setItem(k, JSON.stringify(v)); } catch (e) {} }
  };
  const money = n => 'R' + Number(n).toFixed(2);
  const LABEL = { new: 'Received', confirmed: 'Confirmed', out_for_delivery: 'Out for delivery', delivered: 'Delivered', cancelled: 'Cancelled' };
  const say = m => {
    const t = $('#toast'); if (!t) return;
    t.textContent = m; t.classList.add('show');
    clearTimeout(say.t); say.t = setTimeout(() => t.classList.remove('show'), 2600);
  };
  const el = (tag, text, cls) => { const e = document.createElement(tag); if (text !== undefined) e.textContent = text; if (cls) e.className = cls; return e; };

  const old = $('#sendOrder');
  if (!old) return;
  const btn = old.cloneNode(true);          // clone removes the old WhatsApp click handler
  old.replaceWith(btn);
  btn.textContent = 'Place order';

  const phone = $('#cPhone');
  phone.value = LS.get('nollies_phone', '');
  phone.addEventListener('input', () => LS.set('nollies_phone', phone.value));

  btn.addEventListener('click', async () => {
    const cart = LS.get('nollies_cart', {});
    const items = Object.entries(cart).map(([id, qty]) => ({ id, qty }));
    const name = $('#cName').value.trim(), area = $('#cArea').value.trim();
    const note = $('#cNote').value.trim(), ph = phone.value.trim();
    if (!items.length) return say('Add something to your cart first');
    if (!$('#cConsent').checked) return say('Please tick the box to agree to the privacy notice');
    if (!name || !area) return say('Please enter your name and area');
    if (ph.replace(/\D/g, '').length < 9) return say('Please enter a valid phone number');

    btn.disabled = true; btn.textContent = 'Placing order...';
    try {
      const r = await fetch('/api/orders', {
        method: 'POST', headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name, phone: ph, area, note, items })
      });
      const j = await r.json().catch(() => ({}));
      if (!r.ok) throw new Error(j.error || 'Could not place order. Please try again.');

      const mine = LS.get('nollies_orders', []);
      mine.unshift({ ref: j.ref, phone: ph, total: j.total, at: Date.now() });
      LS.set('nollies_orders', mine.slice(0, 10));

      $('#cNote').value = ''; $('#cNote').dispatchEvent(new Event('input'));
      $('#clearCart').click(); $('#closeCart').click();
      $('#t-track').click();
      $('#trkRef').value = j.ref; $('#trkPhone').value = ph;
      renderMine(); await check(j.ref, ph);
      say('Order placed: ' + j.ref);
      $('#main').scrollIntoView();
    } catch (e) {
      say(e.name === 'TypeError' ? 'Cannot reach the order server. Check your connection.' : e.message);
    } finally {
      btn.disabled = false; btn.textContent = 'Place order';
    }
  });

  async function check(ref, ph) {
    const out = $('#trkOut'); out.textContent = 'Checking...';
    try {
      const r = await fetch('/api/orders/' + encodeURIComponent(ref) + '?phone=' + encodeURIComponent(ph));
      if (r.status === 404) { out.textContent = 'No order found with that number and phone.'; return; }
      if (!r.ok) throw new Error('bad');
      const o = await r.json();
      out.replaceChildren();
      const box = el('div', undefined, 'glass pad');
      const h = el('h3', 'Order ' + o.ref + ': ');
      h.appendChild(el('span', LABEL[o.status] || o.status, 'chip s-' + o.status));
      const ul = el('ul');
      o.items.forEach(i => ul.appendChild(el('li', i.qty + ' x ' + i.name)));
      box.append(h, ul, el('p', 'Total: ' + money(o.total)));
      out.appendChild(box);
    } catch (e) { out.textContent = 'Could not check right now. Please try again.'; }
  }

  function renderMine() {
    const box = $('#myOrders'); box.replaceChildren();
    const mine = LS.get('nollies_orders', []);
    if (!mine.length) return;
    box.appendChild(el('h3', 'Your recent orders'));
    mine.forEach(o => {
      const b = el('button', o.ref + '  (' + money(o.total) + ')', 'link');
      b.addEventListener('click', () => { $('#trkRef').value = o.ref; $('#trkPhone').value = o.phone; check(o.ref, o.phone); });
      box.appendChild(b); box.appendChild(document.createElement('br'));
    });
  }

  $('#trkGo').addEventListener('click', () => {
    const ref = $('#trkRef').value.trim().toUpperCase(), ph = $('#trkPhone').value.trim();
    if (!ref || !ph) return say('Enter your order number and phone');
    check(ref, ph);
  });
  renderMine();
})();
