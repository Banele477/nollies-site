const BackendBridge = {
    async syncOrder(cartItems, grandTotal) {
        try {
            const res = await fetch('/api/order', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ name: 'eNanda Customer', phone: 'WhatsApp', total: grandTotal, items: cartItems })
            });
            return await res.json();
        } catch (e) {
            return { success: false };
        }
    },
    async fetchLiveActivity() {
        try {
            const res = await fetch('/api/public-activity');
            return res.ok ? await res.json() : null;
        } catch (e) { return null; }
    }
};
