(function () {
  'use strict';
  var C = window.CONFIG, PRODUCTS = window.PRODUCTS, CATS = window.CATEGORIES;
  var KEY = 'nollies_cart_v1';

  function $(s, el) { return (el || document).querySelector(s); }
  function $$(s, el) { return Array.prototype.slice.call((el || document).querySelectorAll(s)); }
  function money(n) { return C.currency + Number(n).toLocaleString('en-ZA', { maximumFractionDigits: 2 }); }
  function esc(s) { return String(s).replace(/[&<>"']/g, function (c) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]; }); }
  function byId(id) { return PRODUCTS.filter(function (p) { return p.id === id; })[0]; }

  /* ---------- cart state ---------- */
  var cart = {};
  try { cart = JSON.parse(localStorage.getItem(KEY)) || {}; } catch (e) { cart = {}; }
  Object.keys(cart).forEach(function (id) { if (!byId(id) || !(cart[id] > 0)) delete cart[id]; });
  function save() { try { localStorage.setItem(KEY, JSON.stringify(cart)); } catch (e) {} }
  function count() { return Object.keys(cart).reduce(function (n, id) { return n + cart[id]; }, 0); }
  function subtotal() { return Object.keys(cart).reduce(function (s, id) { return s + byId(id).price * cart[id]; }, 0); }

  function add(id, q) {
    cart[id] = Math.min(99, (cart[id] || 0) + (q || 1));
    save(); renderCart();
    toast('Added: ' + byId(id).name);
  }
  function setQty(id, q) {
    if (q <= 0) delete cart[id]; else cart[id] = Math.min(99, q);
    save(); renderCart();
  }

  /* ---------- toast ---------- */
  var toastTimer;
  function toast(msg) {
    var t = $('#toast'); t.textContent = msg; t.classList.add('show');
    clearTimeout(toastTimer); toastTimer = setTimeout(function () { t.classList.remove('show'); }, 1800);
  }

  /* ---------- config fill ---------- */
  function fillConfig() {
    var map = {
      deliveryArea: C.deliveryArea,
      deliveryFeeText: money(C.deliveryFee),
      freeOverText: money(C.freeDeliveryOver),
      rushFeeText: '(+' + money(C.rushFee) + ')',
      paymentPolicy: C.paymentPolicy
    };
    $$('[data-cfg]').forEach(function (el) {
      var k = el.getAttribute('data-cfg'), v = map[k];
      if (k === 'rushFeeText' && el.tagName === 'STRONG') v = money(C.rushFee);
      if (v != null) el.textContent = v;
    });
    var wa = 'https://wa.me/' + C.whatsapp + '?text=' + encodeURIComponent('Hi ' + C.name + ', I have a question.');
    $$('[data-wa-link]').forEach(function (a) { a.href = wa; });
    $$('[data-social]').forEach(function (a) { a.href = C[a.getAttribute('data-social')] || '#'; });
    var fb = C.feedbackForm && /^https?:\/\//.test(C.feedbackForm) ? C.feedbackForm : '';
    $$('[data-feedback]').forEach(function (el) { el.hidden = !fb; });
    $$('[data-feedback-link]').forEach(function (a) { a.href = fb || '#'; });
    $('#year').textContent = new Date().getFullYear();
  }

  /* ---------- shop ---------- */
  var activeCat = 'all', query = '';
  function renderChips() {
    var items = [{ id: 'all', label: 'All' }].concat(CATS);
    $('#chips').innerHTML = items.map(function (c) {
      return '<button type="button" class="chip" data-cat="' + c.id + '" aria-pressed="' + (c.id === activeCat) + '">' + esc(c.label) + '</button>';
    }).join('');
  }
  function tileHtml(p) {
    var inner = p.image ? '<img src="' + esc(p.image) + '" alt="' + esc(p.name) + '" loading="lazy">' : '<span aria-hidden="true">' + p.emoji + '</span>';
    return '<div class="tile ' + p.cat + '">' + inner + (p.tag ? '<span class="badge">' + esc(p.tag) + '</span>' : '') + '</div>';
  }
  function renderGrid() {
    var q = query.trim().toLowerCase();
    var list = PRODUCTS.filter(function (p) {
      return (activeCat === 'all' || p.cat === activeCat) &&
        (!q || (p.name + ' ' + p.desc + ' ' + p.cat).toLowerCase().indexOf(q) > -1);
    });
    $('#grid').innerHTML = list.map(function (p) {
      return '<article class="card">' + tileHtml(p) +
        '<div class="card-body"><h3>' + esc(p.name) + '</h3><p>' + esc(p.desc) + '</p>' +
        '<div class="price-row"><span class="price">' + money(p.price) + '</span>' +
        '<button type="button" class="add-sm" data-add="' + p.id + '">Add to cart</button></div></div></article>';
    }).join('');
    $('#empty').hidden = list.length > 0;
  }
  function renderQuick() {
    $('#quickList').innerHTML = PRODUCTS.filter(function (p) { return p.feat; }).slice(0, 3).map(function (p) {
      return '<li><span class="q-emoji" aria-hidden="true">' + p.emoji + '</span>' +
        '<div class="q-info"><strong>' + esc(p.name) + '</strong><span>' + money(p.price) + '</span></div>' +
        '<button type="button" class="add-sm" data-add="' + p.id + '">Add</button></li>';
    }).join('');
  }

  /* ---------- cart UI ---------- */
  var form = $('#checkoutForm');
  function isDelivery() { return form.elements.method.value === 'delivery'; }
  function totals() {
    var sub = subtotal();
    var del = (isDelivery() && sub > 0 && sub < C.freeDeliveryOver) ? C.deliveryFee : 0;
    var rush = (isDelivery() && form.elements.rush.checked && sub > 0) ? C.rushFee : 0;
    return { sub: sub, del: del, rush: rush, total: sub + del + rush };
  }
  function renderCart() {
    var ids = Object.keys(cart);
    $('#cartCount').textContent = count();
    $('#cartEmpty').hidden = ids.length > 0;
    $('#cartList').innerHTML = ids.map(function (id) {
      var p = byId(id), q = cart[id];
      return '<li class="cart-item"><div class="ci-info"><strong>' + esc(p.name) + '</strong><span>' + money(p.price) + ' each</span></div>' +
        '<div class="stepper"><button type="button" data-dec="' + id + '" aria-label="Remove one ' + esc(p.name) + '">−</button>' +
        '<output>' + q + '</output><button type="button" data-inc="' + id + '" aria-label="Add one ' + esc(p.name) + '">+</button></div></li>';
    }).join('');
    var delivery = isDelivery();
    $('#addrRow').hidden = !delivery;
    $('#rushRow').hidden = !delivery;
    var t = totals();
    $('#tSub').textContent = money(t.sub);
    $('#tDel').textContent = delivery ? (t.del ? money(t.del) : (t.sub ? 'Free' : money(0))) : 'Collection';
    $('#tRushRow').hidden = !t.rush;
    $('#tRush').textContent = money(t.rush);
    $('#tTotal').textContent = money(t.total);
  }

  var lastFocus;
  function openCart() {
    lastFocus = document.activeElement;
    $('#drawer').classList.add('open'); $('#drawer').setAttribute('aria-hidden', 'false');
    $('#overlay').hidden = false; document.body.style.overflow = 'hidden';
    $('#closeCart').focus();
  }
  function closeCart() {
    $('#drawer').classList.remove('open'); $('#drawer').setAttribute('aria-hidden', 'true');
    $('#overlay').hidden = true; document.body.style.overflow = '';
    if (lastFocus) lastFocus.focus();
  }

  /* ---------- sending orders ---------- */
  function orderId() { return 'N' + Date.now().toString(36).toUpperCase().slice(-6); }
  function validPhone(v) { return String(v).replace(/\D/g, '').length >= 9; }
  function showError(el, msg) { el.textContent = msg; el.hidden = !msg; }

  function post(payload) {
    try {
      fetch('api/order', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(payload), keepalive: true }).catch(function () {});
    } catch (e) {}
  }
  function openWhatsApp(text) {
    var url = 'https://wa.me/' + C.whatsapp + '?text=' + encodeURIComponent(text);
    var w = window.open(url, '_blank', 'noopener');
    if (!w) window.location.href = url;
  }

  form.addEventListener('submit', function (e) {
    e.preventDefault();
    var err = $('#checkoutError');
    if (!count()) return showError(err, 'Your cart is empty. Add at least one item.');
    var fe = form.elements, name = fe.name.value.trim(), phone = fe.phone.value.trim(), addr = fe.address.value.trim();
    if (!name) return showError(err, 'Enter your name.');
    if (!validPhone(phone)) return showError(err, 'Enter a valid WhatsApp number.');
    if (isDelivery() && !addr) return showError(err, 'Enter your delivery address, or choose collection.');
    showError(err, '');

    var t = totals(), id = orderId();
    var items = Object.keys(cart).map(function (pid) {
      var p = byId(pid);
      return { id: pid, name: p.name, qty: cart[pid], price: p.price };
    });
    var lines = ['*New order ' + id + ' - ' + C.name + '*', '',
      'Name: ' + name, 'Phone: ' + phone,
      isDelivery() ? 'Delivery to: ' + addr : 'Collection', '', 'Items:'];
    items.forEach(function (i) { lines.push('- ' + i.qty + ' x ' + i.name + ' = ' + money(i.qty * i.price)); });
    lines.push('', 'Subtotal: ' + money(t.sub));
    if (isDelivery()) lines.push('Delivery: ' + (t.del ? money(t.del) : 'Free'));
    if (t.rush) lines.push('Rush fee: ' + money(t.rush));
    lines.push('*Total: ' + money(t.total) + '*');
    if (fe.notes.value.trim()) lines.push('', 'Notes: ' + fe.notes.value.trim());
    lines.push('', 'I understand payment is by EFT or cash, no credit.');

    post({ type: 'order', id: id, name: name, phone: phone, method: form.elements.method.value, address: addr,
      rush: !!t.rush, notes: fe.notes.value.trim(), items: items, subtotal: t.sub, delivery: t.del, rushFee: t.rush, total: t.total });
    openWhatsApp(lines.join('\n'));
    cart = {}; save(); renderCart(); closeCart(); form.reset(); renderCart();
    toast('Order ' + id + ' ready in WhatsApp. Tap send there.');
  });

  var bulk = $('#bulkForm');
  bulk.addEventListener('submit', function (e) {
    e.preventDefault();
    var err = $('#bulkError'), f = bulk.elements;
    if (!f.name.value.trim()) return showError(err, 'Enter your name.');
    if (!validPhone(f.phone.value)) return showError(err, 'Enter a valid WhatsApp number.');
    if (!f.namedItem('item').value) return showError(err, 'Choose what you need.');
    if (!(Number(f.qty.value) > 0)) return showError(err, 'Enter a quantity.');
    showError(err, '');
    var id = orderId();
    var lines = ['*Bulk quote request ' + id + ' - ' + C.name + '*', '',
      'Name: ' + f.name.value.trim(), 'Phone: ' + f.phone.value.trim(),
      'Needs: ' + f.namedItem('item').value, 'Quantity: ' + f.qty.value];
    if (f.date.value) lines.push('Date needed: ' + f.date.value);
    if (f.notes.value.trim()) lines.push('Notes: ' + f.notes.value.trim());
    post({ type: 'bulk', id: id, name: f.name.value.trim(), phone: f.phone.value.trim(), item: f.namedItem('item').value,
      qty: Number(f.qty.value), date: f.date.value, notes: f.notes.value.trim() });
    openWhatsApp(lines.join('\n'));
    bulk.reset(); toast('Quote request ' + id + ' ready in WhatsApp.');
  });

  /* ---------- events ---------- */
  document.addEventListener('click', function (e) {
    var t = e.target.closest('[data-add],[data-inc],[data-dec],[data-cat]');
    if (!t) return;
    if (t.dataset.add) add(t.dataset.add);
    else if (t.dataset.inc) setQty(t.dataset.inc, cart[t.dataset.inc] + 1);
    else if (t.dataset.dec) setQty(t.dataset.dec, cart[t.dataset.dec] - 1);
    else if (t.dataset.cat) { activeCat = t.dataset.cat; renderChips(); renderGrid(); }
  });
  $('#search').addEventListener('input', function (e) { query = e.target.value; renderGrid(); });
  $('#openCart').addEventListener('click', openCart);
  $('#quickCart').addEventListener('click', openCart);
  $('#closeCart').addEventListener('click', closeCart);
  $('#overlay').addEventListener('click', closeCart);
  $('#clearCart').addEventListener('click', function () { cart = {}; save(); renderCart(); });
  document.addEventListener('keydown', function (e) { if (e.key === 'Escape' && $('#drawer').classList.contains('open')) closeCart(); });
  form.addEventListener('change', renderCart);

  fillConfig(); renderChips(); renderGrid(); renderQuick(); renderCart();
})();
