let cart = [];

function addToCart(title, price) {
    cart.push({ title, price });
    updateCartUI();
}

function updateCartUI() {
    document.getElementById('cart-count').innerText = cart.length;
    const cartItemsContainer = document.getElementById('cart-items');
    cartItemsContainer.innerHTML = '';
    
    let total = 0;
    cart.forEach((item) => {
        total += item.price;
        cartItemsContainer.innerHTML += `
            <div class="cart-item">
                <div><strong>${item.title}</strong></div>
                <div>R ${item.price.toFixed(2)}</div>
            </div>
        `;
    });

    document.getElementById('cart-total').innerText = `R ${total.toFixed(2)}`;
}

function toggleCart() {
    const modal = document.getElementById('cart-modal');
    modal.style.display = modal.style.display === 'flex' ? 'none' : 'flex';
}

function toggleTheme() {
    document.body.classList.toggle('dark-theme');
}

function toggleDataSaver() {
    document.body.classList.toggle('lite-mode');
    alert('Data Saver mode toggled!');
}

function checkoutWhatsApp() {
    if (cart.length === 0) {
        alert('Your cart is empty!');
        return;
    }
    
    let message = "Hi Nollie's, I would like to order the following:%0A";
    let total = 0;
    cart.forEach(item => {
        message += `- ${item.title}: R${item.price}%0A`;
        total += item.price;
    });
    message += `%0ATotal Amount: R${total.toFixed(2)}%0APayment Method: EFT / Capitec / Card`;
    
    window.open(`https://wa.me/?text=${message}`, '_blank');
}
