(() => {
  'use strict';
  const WA = document.documentElement.dataset.wa;
  const $  = (s, r = document) => r.querySelector(s);
  const $$ = (s, r = document) => [...r.querySelectorAll(s)];
  const money = n => 'R' + Number(n).toFixed(2);
  const store = {
    get(k, d) { try { return JSON.parse(localStorage.getItem(k)) ?? d; } catch (e) { return d; } },
    set(k, v) { try { localStorage.setItem(k, JSON.stringify(v)); } catch (e) {} }
  };

  let products = [];
  let cart = store.get('nollies_cart', {});      // { productId: qty }  (remembered)
  let cat = 'all';

  /* ---------- accessible tabs (arrow keys, Home/End, ARIA) ---------- */
  function makeTabs(list, onSelect) {
    const tabs = $$('[role=tab]', list);
    const select = (tab, focus) => {
      tabs.forEach(t => {
        const on = t === tab;
        t.setAttribute('aria-selected', on);
        t.tabIndex = on ? 0 : -1;
        const panel = document.getElementById(t.getAttribute('aria-controls'));
        if (panel) panel.hidden = !on;
      });
      if (focus) tab.focus();
      onSelect && onSelect(tab);
    };
    tabs.forEach((t, i) => {
      t.addEventListener('click', () => select(t));
      t.addEventListener('keydown', e => {
        let n = null;
        if (e.key === 'ArrowRight') n = tabs[(i + 1) % tabs.length];
        if (e.key === 'ArrowLeft')  n = tabs[(i - 1 + tabs.length) % tabs.length];
        if (e.key === 'Home') n = tabs[0];
        if (e.key === 'End')  n = tabs[tabs.length - 1];
        if (n) { e.preventDefault(); select(n, true); }
      });
    });
    return { select, tabs };
  }

  const main = makeTabs($('.main-tabs'), t => {
    store.set('nollies_tab', t.dataset.tab);          // remember last tab
    history.replaceState(null, '', '#' + t.dataset.tab);
  });
  const goTab = name => { const t = main.tabs.find(x => x.dataset.tab === name); if (t) main.select(t); };
  $$('[data-goto]').forEach(a => a.addEventListener('click', e => { e.preventDefault(); goTab(a.dataset.goto); $('#main').scrollIntoView(); }));
  goTab(location.hash.slice(1) || store.get('nollies_tab', 'shop'));

  makeTabs($('.cat-tabs'), t => { cat = t.dataset.cat; renderGrid(); });

  /* ---------- products ---------- */
  async function load() {
    try {
      const r = await fetch('/api/products', { cache: 'no-cache' }).then(x => { if (!x.ok) throw 0; return x; }).catch(() => fetch('products.json', { cache: 'no-cache' }));
      products = await r.json();
    } catch (e) {
      $('#grid').innerHTML = '<p class="glass pad">Could not load products. Please refresh or WhatsApp us.</p>';
      return;
    }
    renderGrid(); renderCart();
  }

  function renderGrid() {
    const list = products.filter(p => cat === 'all' || p.category === cat);
    $('#grid').innerHTML = list.length ? list.map(p => `
      <article class="glass card">
        <div class="ico" aria-hidden="true">${p.icon}</div>
        <h3>${p.name}</h3>
        <p>${p.desc}</p>
        <div class="price">${money(p.price)}</div>
        <button class="btn" data-add="${p.id}">Add to cart</button>
      </article>`).join('') : '<p class="glass pad">Nothing here yet. Check back soon.</p>';
  }

  $('#grid').addEventListener('click', e => {
    const id = e.target.dataset.add;
    if (!id) return;
    cart[id] = (cart[id] || 0) + 1;
    saveCart(); toast('Added to cart');
  });

  /* ---------- cart (remembered between visits) ---------- */
  function saveCart() { store.set('nollies_cart', cart); renderCart(); }

  function renderCart() {
    const ids = Object.keys(cart).filter(id => products.some(p => p.id === id));
    let total = 0, count = 0;
    $('#cartItems').innerHTML = ids.length ? ids.map(id => {
      const p = products.find(x => x.id === id), q = cart[id];
      total += p.price * q; count += q;
      return `<div class="line"><span>${p.icon} ${p.name}<br><small class="muted">${money(p.price)}</small></span>
        <span class="qty"><button data-dec="${id}" aria-label="Less">-</button><span>${q}</span><button data-inc="${id}" aria-label="More">+</button></span></div>`;
    }).join('') : '<p class="muted">Your cart is empty.</p>';
    $('#cartTotal').textContent = money(total);
    $('#cartCount').textContent = count;
  }

  $('#cartItems').addEventListener('click', e => {
    const inc = e.target.dataset.inc, dec = e.target.dataset.dec;
    if (inc) cart[inc]++;
    if (dec) { cart[dec]--; if (cart[dec] <= 0) delete cart[dec]; }
    if (inc || dec) saveCart();
  });
  $('#clearCart').addEventListener('click', () => { cart = {}; saveCart(); });

  const drawer = $('#drawer'), scrim = $('#scrim');
  function openCart(on) {
    drawer.classList.toggle('open', on);
    drawer.setAttribute('aria-hidden', !on);
    scrim.hidden = !on;
    if (on) $('#closeCart').focus(); else $('#openCart').focus();
  }
  $('#openCart').addEventListener('click', () => openCart(true));
  $('#closeCart').addEventListener('click', () => openCart(false));
  scrim.addEventListener('click', () => openCart(false));
  document.addEventListener('keydown', e => { if (e.key === 'Escape') openCart(false); });

  // remember customer details too
  const f = { name: $('#cName'), area: $('#cArea'), note: $('#cNote') };
  const saved = store.get('nollies_cust', {});
  Object.keys(f).forEach(k => { f[k].value = saved[k] || ''; f[k].addEventListener('input', () => store.set('nollies_cust', { name: f.name.value, area: f.area.value, note: f.note.value })); });

  /* ---------- WhatsApp order ---------- */
  $('#sendOrder').addEventListener('click', () => {
    const ids = Object.keys(cart).filter(id => products.some(p => p.id === id));
    if (!ids.length) return toast('Add something to your cart first');
    if (!f.name.value.trim() || !f.area.value.trim()) return toast('Please enter your name and area');
    let total = 0;
    const lines = ids.map(id => {
      const p = products.find(x => x.id === id), q = cart[id];
      total += p.price * q;
      return `- ${q} x ${p.name} (${money(p.price * q)})`;
    });
    const msg = `Hi Nollie's, I would like to order:\n${lines.join('\n')}\n\nTotal: ${money(total)}\nName: ${f.name.value.trim()}\nArea: ${f.area.value.trim()}` +
      (f.note.value.trim() ? `\nNotes: ${f.note.value.trim()}` : '');
    window.open(`https://wa.me/${WA}?text=${encodeURIComponent(msg)}`, '_blank', 'noopener');
  });
  $('#waDirect').href = `https://wa.me/${WA}?text=${encodeURIComponent("Hi Nollie's, I have a question.")}`;

  /* ---------- misc ---------- */
  function toast(m) {
    const t = $('#toast'); t.textContent = m; t.classList.add('show');
    clearTimeout(toast.t); toast.t = setTimeout(() => t.classList.remove('show'), 1800);
  }
  $('#yr').textContent = new Date().getFullYear();
  if ('serviceWorker' in navigator) navigator.serviceWorker.register('sw.js').catch(() => {});
  load();
})();
