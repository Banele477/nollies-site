// ======================================================
// NOLLIES CLIENT LOCATION TRACER & TELEMETRY ENGINE
// ======================================================

class ClientLocationTracer {
    constructor() {
        this.clientData = {
            ip: "Detecting...",
            city: "Unknown",
            region: "Unknown",
            country: "Unknown",
            latitude: null,
            longitude: null,
            isp: "Unknown",
            timezone: Intl.DateTimeFormat().resolvedOptions().timeZone,
            userAgent: navigator.userAgent
        };
    }

    // 1. Instant IP-based Geolocation Lookup
    async traceIpLocation() {
        try {
            const response = await fetch('https://ipapi.co/json/');
            if (response.ok) {
                const data = await response.json();
                this.clientData.ip = data.ip;
                this.clientData.city = data.city;
                this.clientData.region = data.region;
                this.clientData.country = data.country_name;
                this.clientData.isp = data.org;
                this.clientData.latitude = data.latitude;
                this.clientData.longitude = data.longitude;
            }
        } catch (err) {
            console.warn("[Tracer] IP lookup restricted or offline:", err);
        }
        return this.clientData;
    }

    // 2. High-Precision GPS Geolocation (Triggers Browser Permission Prompt)
    requestGpsLocation() {
        return new Promise((resolve) => {
            if (!navigator.geolocation) {
                console.warn("[Tracer] Geolocation API not supported by browser.");
                resolve(this.clientData);
                return;
            }

            navigator.geolocation.getCurrentPosition(
                (position) => {
                    this.clientData.latitude = position.coords.latitude;
                    this.clientData.longitude = position.coords.longitude;
                    console.log(`[Tracer] Precise GPS Acquired: ${this.clientData.latitude}, ${this.clientData.longitude}`);
                    resolve(this.clientData);
                },
                (error) => {
                    console.warn(`[Tracer] Precise GPS permission declined or unavailable: ${error.message}`);
                    resolve(this.clientData);
                },
                { enableHighAccuracy: true, timeout: 8000, maximumAge: 0 }
            );
        });
    }

    // 3. Render Location Badge on UI
    renderTracerBadge() {
        let badge = document.getElementById('location-tracer-badge');
        if (!badge) {
            badge = document.createElement('div');
            badge.id = 'location-tracer-badge';
            badge.style.cssText = "position: fixed; bottom: 70px; left: 25px; background: rgba(15, 23, 42, 0.85); backdrop-filter: blur(12px); border: 1px solid rgba(99, 102, 241, 0.3); padding: 8px 14px; border-radius: 10px; font-size: 0.78rem; color: #a5b4fc; z-index: 998; box-shadow: 0 4px 15px rgba(0,0,0,0.3); display: flex; align-items: center; gap: 8px;";
            document.body.appendChild(badge);
        }

        const locString = this.clientData.city !== "Unknown" 
            ? `${this.clientData.city}, ${this.clientData.country}` 
            : "Location Detected";

        badge.innerHTML = `
            <span style="height: 8px; width: 8px; background-color: #10b981; border-radius: 50%; display: inline-block; box-shadow: 0 0 8px #10b981;"></span>
            <span>📍 <strong>Location:</strong> ${locString} (${this.clientData.ip})</span>
        `;
    }
}

// Global Tracer Instance
const nolliesTracer = new ClientLocationTracer();

document.addEventListener("DOMContentLoaded", async () => {
    await nolliesTracer.traceIpLocation();
    nolliesTracer.renderTracerBadge();
});
