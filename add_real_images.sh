#!/bin/bash
set -e
cd ~/nollies

echo "[*] Injecting real image assets and rendering helpers into public/js/products.js..."

mkdir -p public/js

# Check if products.js exists, if not initialize it
if [ ! -f "public/js/products.js" ]; then
    echo "let products = [];" > public/js/products.js
fi

# Append or update products with real high-res Unsplash image URLs
cat << 'JSIMG' >> public/js/products.js

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
JSIMG

echo "[*] Step 2: Committing and pushing changes securely..."
if [ -f "./git-secure-push.sh" ]; then
    ./git-secure-push.sh "Add real product photography and image grid layout"
else
    git add .
    git commit -m "Add real high-res images"
    git push origin main
fi

echo "[*] Step 3: Running deployment script..."
if [ -f "./deploy.sh" ]; then
    ./deploy.sh
fi

echo "[+] SUCCESS: Real images integrated, pushed, and deployed!"
