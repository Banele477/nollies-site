/* Edit, add or remove products here. Prices are examples: replace with yours.
   cat must be one of: juice, perfume, cereal, combo, hamper
   feat: true shows the product in "Popular right now" on the home page.
   image (optional): path like "img/mango-juice.jpg". Without it, the emoji shows. */
window.CATEGORIES = [
  { id: "juice",   label: "Juice" },
  { id: "perfume", label: "Perfume" },
  { id: "cereal",  label: "Cereal" },
  { id: "combo",   label: "Combo packs" },
  { id: "hamper",  label: "Hampers" }
];

window.PRODUCTS = [
  { id: "juice-2l",    cat: "juice",   name: "Fruit juice 2L",            price: 45,  emoji: "🧃", desc: "Everyday juice for the whole family." },
  { id: "juice-5l",    cat: "juice",   name: "Fruit juice 5L",            price: 95,  emoji: "🥤", desc: "Big bottle for events, church and funerals.", feat: true },
  { id: "perfume-60",  cat: "perfume", name: "Perfume 60ml",              price: 120, emoji: "🌸", desc: "Long-lasting scent at a fair price." },
  { id: "perfume-100", cat: "perfume", name: "Perfume 100ml",             price: 180, emoji: "💐", desc: "Our bigger size for perfume lovers." },
  { id: "cereal-box",  cat: "cereal",  name: "Baby and kids cereal",      price: 65,  emoji: "🥣", desc: "Regular buy for parents of little ones." },
  { id: "combo-1",     cat: "combo",   name: "Combo: juice + perfume",    price: 150, emoji: "🎁", desc: "One juice and one perfume together for less.", feat: true, tag: "Best value" },
  { id: "combo-2",     cat: "combo",   name: "Family combo",              price: 260, emoji: "🛍️", desc: "Two juices, one perfume and one cereal.", feat: true },
  { id: "hamper-s",    cat: "hamper",  name: "Small gift hamper",         price: 220, emoji: "🧺", desc: "Packed neatly and ready to give." },
  { id: "hamper-l",    cat: "hamper",  name: "Large gift hamper",         price: 380, emoji: "🎀", desc: "Juice, perfume and treats in better packaging." }
];

// Real curated product images integration
const realProductImages = [
    {
        id: "p1",
        name: "Modern Tech Setup",
        price: 450.00,
        image: "https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=600&auto=format&fit=crop&q=80",
        description: "High-performance workspace setup for professionals."
    },
    {
        id: "p2",
        name: "Minimalist Desk Accessory",
        price: 120.00,
        image: "https://images.unsplash.com/photo-1507238691740-187a5b1d37b8?w=600&auto=format&fit=crop&q=80",
        description: "Sleek gear designed to keep your desk organized."
    },
    {
        id: "p3",
        name: "Creative Studio Essentials",
        price: 280.00,
        image: "https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=600&auto=format&fit=crop&q=80",
        description: "Tools engineered for digital creators and developers."
    }
];

// Function to render products with real images automatically if a container exists
function renderRealProducts() {
    let container = document.getElementById('product-grid') || document.body;
    
    // Check if grid container exists, otherwise create a nice section for it
    if (!document.getElementById('product-grid')) {
        let gridDiv = document.createElement('div');
        gridDiv.id = 'product-grid';
        gridDiv.style.cssText = "display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; padding: 20px;";
        document.body.appendChild(gridDiv);
        container = gridDiv;
    } else {
        container.innerHTML = "";
    }

    realProductImages.forEach(product => {
        let card = document.createElement('div');
        card.className = 'product-card';
        card.style.cssText = "background: var(--card-bg, #fff); border: 1px solid #ddd; border-radius: 8px; padding: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);";
        
        card.innerHTML = `
            <img src="${product.image}" alt="${product.name}" style="width: 100%; height: 180px; object-fit: cover; border-radius: 6px; margin-bottom: 10px;">
            <h3 style="font-size: 1.2rem; margin: 10px 0;">${product.name}</h3>
            <p style="color: #666; font-size: 0.9rem;">${product.description}</p>
            <p style="font-weight: bold; color: #2e7d32; font-size: 1.1rem;">R ${product.price.toFixed(2)}</p>
            <button onclick="addToCart('${product.id}', '${product.name}', ${product.price})" style="background: #007bff; color: white; border: none; padding: 10px 15px; border-radius: 5px; cursor: pointer; margin-top: 10px;">Add to Cart</button>
        `;
        container.appendChild(card);
    });
}

document.addEventListener("DOMContentLoaded", renderRealProducts);
