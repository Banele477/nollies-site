// Toast Notification System
function showToast(message) {
    let toast = document.getElementById("toast");
    if (!toast) {
        toast = document.createElement("div");
        toast.id = "toast";
        toast.style.cssText = "visibility: hidden; min-width: 250px; background-color: #333; color: #fff; text-align: center; border-radius: 4px; padding: 16px; position: fixed; z-index: 1000; left: 50%; bottom: 30px; transform: translateX(-50%); transition: visibility 0.5s, opacity 0.5s; opacity: 0;";
        document.body.appendChild(toast);
    }
    toast.innerText = message;
    toast.style.visibility = "visible";
    toast.style.opacity = "1";
    setTimeout(() => {
        toast.style.opacity = "0";
        toast.style.visibility = "hidden";
    }, 3000);
}

// Theme Toggle System
if (localStorage.getItem('theme') === 'dark') {
    document.body.classList.add('dark-theme');
}

function toggleTheme() {
    document.body.classList.toggle('dark-theme');
    let isDark = document.body.classList.contains('dark-theme');
    localStorage.setItem('theme', isDark ? 'dark' : 'light');
    showToast(isDark ? "Dark mode enabled" : "Light mode enabled");
}

// Product Search Filter
function filterProducts() {
    let input = document.getElementById('searchInput');
    if (!input) return;
    let filter = input.value.toLowerCase();
    let cards = document.querySelectorAll('.product-card');
    cards.forEach(card => {
        let title = card.innerText.toLowerCase();
        card.style.display = title.includes(filter) ? "" : "none";
    });
}
