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
