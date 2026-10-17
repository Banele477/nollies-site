// API Connector for Nollie's Flask Backend
const API = {
    async submitOrder(orderData) {
        try {
            const res = await fetch('/api/order', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(orderData)
            });
            return await res.json();
        } catch (err) {
            console.warn("Backend unavailable, using client-side fallback:", err);
            return { success: false, fallback: true };
        }
    },

    async fetchActivity() {
        try {
            const res = await fetch('/api/public-activity');
            if (!res.ok) return null;
            return await res.json();
        } catch (err) {
            return null;
        }
    }
};
