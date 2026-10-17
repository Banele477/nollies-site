#!/data/data/com.termux/files/usr/bin/bash
set -e

cd ~/nollies
echo "🛠️ Adding Owner Admin Dashboard..."

mkdir -p public

cat << 'HTML' > public/admin.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nollie's | Owner Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>body { font-family: 'Inter', sans-serif; }</style>
</head>
<body class="bg-slate-100 text-slate-900 min-h-screen p-4 sm:p-8">

    <div class="max-w-4xl mx-auto">
        <!-- Header -->
        <div class="flex justify-between items-center bg-white p-5 rounded-2xl shadow-sm border border-slate-200 mb-6">
            <div>
                <h1 class="text-xl font-black text-purple-700">Nollie's Owner Dashboard</h1>
                <p class="text-xs text-slate-500">eNanda, Durban • Live Order Management</p>
            </div>
            <button onclick="logout()" class="bg-red-50 text-red-600 text-xs font-bold px-3 py-2 rounded-xl border border-red-200">Logout</button>
        </div>

        <!-- Login Card (Shown if not logged in) -->
        <div id="login-card" class="bg-white p-6 rounded-2xl shadow-sm border border-slate-200 max-w-md mx-auto">
            <h2 class="text-base font-bold mb-2">Owner Authentication Required</h2>
            <p class="text-xs text-slate-500 mb-4">Enter your secure admin key (e.g., `mysecret`) to view incoming orders.</p>
            <input type="password" id="admin-key-input" placeholder="Enter Admin Key..." class="w-full px-3 py-2 text-xs rounded-xl border border-slate-300 mb-3 outline-none focus:ring-2 focus:ring-purple-500">
            <button onclick="login()" class="w-full bg-purple-600 text-white font-bold py-2.5 rounded-xl text-xs">Access Dashboard</button>
            <p id="login-error" class="text-red-500 text-xs mt-2 hidden">Invalid admin key!</p>
        </div>

        <!-- Dashboard Content (Hidden until logged in) -->
        <div id="dashboard-content" class="hidden space-y-6">
            
            <!-- Quick Metrics Grid -->
            <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                <div class="bg-white p-4 rounded-2xl border border-slate-200 shadow-sm">
                    <span class="text-xs text-slate-500 block">Total Orders</span>
                    <span id="stat-count" class="text-2xl font-black text-purple-700">0</span>
                </div>
                <div class="bg-white p-4 rounded-2xl border border-slate-200 shadow-sm">
                    <span class="text-xs text-slate-500 block">Total Revenue Logged</span>
                    <span id="stat-revenue" class="text-2xl font-black text-emerald-600">R 0.00</span>
                </div>
                <div class="bg-white p-4 rounded-2xl border border-slate-200 shadow-sm">
                    <span class="text-xs text-slate-500 block">Delivery Zone</span>
                    <span class="text-lg font-black text-slate-700">eNanda (R30)</span>
                </div>
            </div>

            <!-- Orders Table Container -->
            <div class="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
                <div class="p-4 border-b border-slate-200 flex justify-between items-center">
                    <h3 class="font-bold text-sm">Incoming Customer Orders</h3>
                    <button onclick="fetchOrders()" class="bg-purple-50 text-purple-700 text-xs font-bold px-3 py-1.5 rounded-lg">🔄 Refresh</button>
                </div>
                <div id="orders-container" class="p-4 overflow-x-auto">
                    <p class="text-xs text-slate-500 text-center py-6">Loading orders...</p>
                </div>
            </div>

        </div>
    </div>

    <script>
        let adminKey = localStorage.getItem('nollie_admin_key') || '';

        if (adminKey) {
            document.getElementById('admin-key-input').value = adminKey;
            fetchOrders();
        }

        function login() {
            const key = document.getElementById('admin-key-input').value.trim();
            if (!key) return;
            adminKey = key;
            localStorage.setItem('nollie_admin_key', adminKey);
            fetchOrders();
        }

        function logout() {
            localStorage.removeItem('nollie_admin_key');
            adminKey = '';
            document.getElementById('dashboard-content').classList.add('hidden');
            document.getElementById('login-card').classList.remove('hidden');
        }

        async function fetchOrders() {
            try {
                const res = await fetch('/api/orders', {
                    headers: { 'X-Admin-Key': adminKey }
                });

                if (res.status === 401) {
                    document.getElementById('login-error').classList.remove('hidden');
                    document.getElementById('login-card').classList.remove('hidden');
                    document.getElementById('dashboard-content').classList.add('hidden');
                    return;
                }

                const orders = await res.json();
                document.getElementById('login-error').classList.add('hidden');
                document.getElementById('login-card').classList.add('hidden');
                document.getElementById('dashboard-content').classList.remove('hidden');

                renderOrders(orders);
            } catch (err) {
                console.error(err);
                alert('Failed to connect to server.');
            }
        }

        function renderOrders(orders) {
            document.getElementById('stat-count').innerText = orders.length;
            let totalRev = 0;
            orders.forEach(o => totalRev += (o.total || 0));
            document.getElementById('stat-revenue').innerText = `R ${totalRev.toFixed(2)}`;

            const container = document.getElementById('orders-container');
            if (orders.length === 0) {
                container.innerHTML = '<p class="text-xs text-slate-500 text-center py-6">No orders recorded yet.</p>';
                return;
            }

            let html = `
                <table class="w-full text-left text-xs">
                    <thead>
                        <tr class="border-b border-slate-200 text-slate-500">
                            <th class="pb-3">Time</th>
                            <th class="pb-3">Customer</th>
                            <th class="pb-3">Items</th>
                            <th class="pb-3">Total</th>
                            <th class="pb-3">Status</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100">
            `;

            orders.forEach(o => {
                let itemsList = '';
                if (o.items && Array.isArray(o.items)) {
                    itemsList = o.items.map(i => `${i.title || i.name}`).join(', ');
                }
                html += `
                    <tr class="hover:bg-slate-50">
                        <td class="py-3 text-slate-500">${o.received || 'N/A'}</td>
                        <td class="py-3 font-bold">${o.name || 'Web Customer'}<br><span class="font-normal text-slate-400">${o.phone || ''}</span></td>
                        <td class="py-3 text-slate-600">${itemsList || 'Direct Checkout'}</td>
                        <td class="py-3 font-extrabold text-emerald-600">R ${(o.total || 0).toFixed(2)}</td>
                        <td class="py-3"><span class="bg-amber-100 text-amber-800 px-2 py-0.5 rounded font-bold text-[10px]">${o.status || 'new'}</span></td>
                    </tr>
                `;
            });

            html += `</tbody></table>`;
            container.innerHTML = html;
        }
    </script>
</body>
</html>
HTML

cp public/admin.html admin.html 2>/dev/null || true
echo "✅ Admin Dashboard added successfully!"
