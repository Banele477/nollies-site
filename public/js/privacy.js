(() => {
  'use strict';
  const dlg = document.getElementById('privacyDlg');
  if (!dlg || typeof dlg.showModal !== 'function') return;
  document.getElementById('privDate').textContent =
    new Date().toLocaleDateString('en-ZA', { year: 'numeric', month: 'long', day: 'numeric' });
  document.addEventListener('click', e => {
    if (e.target.closest('.plink')) { e.preventDefault(); dlg.showModal(); }
  });
  document.getElementById('closePrivacy').addEventListener('click', () => dlg.close());
  dlg.addEventListener('click', e => { if (e.target === dlg) dlg.close(); });   // click outside closes
})();
