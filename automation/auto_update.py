import os
import json

TEMPLATES_DIR = "templates"
PUBLIC_DIR = "public"

def load_template(name):
    path = os.path.join(TEMPLATES_DIR, name)
    if os.path.exists(path):
        with open(path, "r", encoding="utf-8") as f:
            return f.read()
    return None

def generate_product_card(product):
    return f"""
    <div class="bg-glass rounded-3xl border silver-border shadow-xl overflow-hidden flex flex-col justify-between hover:border-slate-400 transition-all">
        <div onclick="openProductModal('{product['title']}', {product['price']}, '{product['desc']}', '{product['img']}', '{product['fallback']}')" class="cursor-pointer">
            <div class="h-48 overflow-hidden relative bg-slate-950 flex items-center justify-center">
                <img src="{product['img']}" alt="{product['title']}" class="w-full h-full object-cover hover:scale-105 transition-transform duration-500" onerror="this.onerror=null;this.src='{product['fallback']}';">
                <span class="absolute top-3 left-3 silver-gradient text-slate-950 text-[10px] font-extrabold px-3 py-1 rounded-full uppercase shadow">{product['badge']}</span>
            </div>
            <div class="p-4">
                <h3 class="text-sm font-extrabold text-white mb-1">{product['title']}</h3>
                <p class="text-[11px] text-slate-300 line-clamp-2">{product['desc']}</p>
            </div>
        </div>
        <div class="p-4 pt-0 flex justify-between items-center">
            <span class="text-base font-black silver-text">R {product['price']:.2f}</span>
            <button onclick="addToCart('{product['title']}', {product['price']})" class="press-effect silver-gradient text-slate-950 text-xs font-extrabold px-4 py-2.5 rounded-xl shadow">+ Add</button>
        </div>
    </div>
    """

print("Automation engine initialized successfully!")
