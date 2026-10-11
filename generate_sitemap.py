import os
import datetime

DOMAIN = "https://nollies.co.za" # Update with your domain

urls = [
    "/",
    "/#products",
    "/#about"
]

sitemap_xml = '<?xml version="1.0" encoding="UTF-8"?>\n'
sitemap_xml += '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n'

today = datetime.datetime.now().strftime("%Y-%m-%d")

for url in urls:
    sitemap_xml += f'  <url>\n    <loc>{DOMAIN}{url}</loc>\n    <lastmod>{today}</lastmod>\n    <priority>0.8</priority>\n  </url>\n'

sitemap_xml += '</urlset>'

with open("public/sitemap.xml", "w") as f:
    f.write(sitemap_xml)

print("[+] Generated public/sitemap.xml successfully!")
