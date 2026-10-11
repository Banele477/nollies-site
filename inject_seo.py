import os

html_files = [f for f in os.listdir("public") if f.endswith(".html")]
if not html_files and os.path.exists("index.html"):
    html_files = ["index.html"]

seo_tags = """
    <!-- Rank #1 SEO Optimization & Meta Tags -->
    <meta name="description" content="Nollies - Enterprise-grade digital solutions, high-performance web systems, real-world data integration, and automated workflows.">
    <meta name="keywords" content="Nollies, web development, automation, Python backend, secure integration, data analytics">
    <meta name="author" content="Banele Gumbi">
    <meta name="robots" content="index, follow">
    
    <!-- Open Graph / Social Media Sharing Meta Tags -->
    property="og:title" content="Nollies | Professional Digital Systems & Web Platform">
    <meta property="og:description" content="Discover professional-grade digital applications, secure workflows, and modern web features.">
    <meta property="og:type" content="website">
    <meta property="og:url" content="https://nollies-site.vercel.app">
    
    <!-- JSON-LD Structured Data for Search Engine Knowledge Graphs -->
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "WebSite",
      "name": "Nollies",
      "url": "https://nollies-site.vercel.app",
      "potentialAction": {
        "@type": "SearchAction",
        "target": "https://nollies-site.vercel.app/?q={search_term_string}",
        "query-input": "required name=search_term_string"
      }
    }
    </script>
"""

print("[+] SEO injection payload ready.")
