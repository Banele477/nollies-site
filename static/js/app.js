async function submitQuote(e) {
    e.preventDefault();
    const name = document.getElementById('q-name').value.trim();
    const phone = document.getElementById('q-whatsapp').value.trim();
    const requirements = document.getElementById('q-needs').value.trim();
    const feedback = document.getElementById('form-feedback');

    try {
        // Save to SQLite backend database
        const res = await fetch('/api/bulk-quote', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ customer_name: name, whatsapp_number: phone, requirements: requirements })
        });
        const data = await res.json();
        
        if (data.success) {
            feedback.innerHTML = `<p class="success-msg">Quote request saved! Redirecting to WhatsApp...</p>`;
            
            // Generate instant WhatsApp message
            const waMessage = `Hello Nollies! My name is ${encodeURIComponent(name)}.%0A%0ARequest Details:%0A${encodeURIComponent(requirements)}%0A%0AContact Number: ${encodeURIComponent(phone)}`;
            
            setTimeout(() => {
                window.open(`https://wa.me/?text=${waMessage}`, '_blank');
                document.getElementById('quote-form').reset();
                feedback.innerHTML = '';
            }, 1000);
        } else {
            feedback.innerHTML = `<p class="error-msg">${data.error}</p>`;
        }
    } catch (err) {
        feedback.innerHTML = `<p class="error-msg">Error saving request. Please try again.</p>`;
    }
}

function toggleCartModal() {
    alert('Cart preview opened!');
}
