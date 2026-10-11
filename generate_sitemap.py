import os
import datetime

DOMAIN = "https://nollies-site.vercel.app" # Update to your production domain if custom
urls = [
    {"loc": "/", "priority": "1.0", "changefreq": "daily"},
    {"loc": "/#products", "priority": "0.9", "changefreq": "weekly"},
    {"loc": "/#real-world-grid", "priority": "0.8", "changefreq": "weekly"}
]

sitemap_xml = '<?xml version="1.0" encoding="UTF-8"?>\n'
sitemap_xml += '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n'
today = datetime.datetime.now().strftime("%Y-%m-%d")

for u in urls:
    sitemap_xml += f'  <url>\n'
    sitemap_xml += f'    <loc>{DOMAIN}{u["loc"]}</loc>\n'
    sitemap_xml += f'    <lastmod>{today}</lastmod>\n'
    sitemap_xml += f'    <changefreq>{u["changefreq"]}</changefreq>\n'
    sitemap_xml += f'    <priority>{u["priority"]}</priority>\n'
    sitemap_xml += f'  </url>\n'

sitemap_xml += '</urlset>'

with open("public/sitemap.xml", "w") as f:
    f.write(sitemap_xml)

print("[+] Advanced SEO Sitemap generated successfully!")
