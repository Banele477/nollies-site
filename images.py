#!/usr/bin/env python3
"""Image helper for Nollie's site.

Drop product photos into public/img/products/ and name each one after the product id
(juice-5l.jpg, combo-1.png ...). Upper case, spaces and underscores are fine:
"Juice_5L.JPG" matches juice-5l.
"""
import json, os, re
from urllib.parse import quote

BASE = os.path.dirname(os.path.abspath(__file__))
PUBLIC = os.path.join(BASE, "public")
EXT = {".jpg", ".jpeg", ".png", ".webp"}


def norm(stem):
    return re.sub(r"[\s_]+", "-", stem.strip().lower())


def _dir(public):
    return os.path.join(public, "img", "products")


def _files(public):
    d = _dir(public)
    if not os.path.isdir(d):
        return []
    return sorted(f for f in os.listdir(d) if os.path.splitext(f)[1].lower() in EXT)


def build_manifest(public=PUBLIC):
    products = {}
    for f in _files(public):
        stem = os.path.splitext(f)[0]
        mtime = int(os.path.getmtime(os.path.join(_dir(public), f)))
        products[norm(stem)] = "img/products/%s?v=%d" % (quote(f), mtime)
    return {"products": products}


def optimize(public=PUBLIC, max_px=1200, quality=82, big_bytes=1_500_000):
    """Downscale huge phone photos. Needs Pillow; quietly does nothing without it."""
    try:
        from PIL import Image, ImageOps
    except Exception:
        return 0
    done = 0
    for f in _files(public):
        path = os.path.join(_dir(public), f)
        try:
            with Image.open(path) as im:
                if max(im.size) <= max_px and os.path.getsize(path) <= big_bytes:
                    continue
                im = ImageOps.exif_transpose(im)
                im.thumbnail((max_px, max_px))
                ext = os.path.splitext(f)[1].lower()
                if ext in (".jpg", ".jpeg"):
                    im.convert("RGB").save(path, "JPEG", quality=quality, optimize=True)
                elif ext == ".png":
                    im.save(path, "PNG", optimize=True)
                else:
                    im.save(path, "WEBP", quality=quality)
                done += 1
        except Exception as e:
            print("Skipped", f, "-", e)
    return done


def main():
    shrunk = optimize()
    manifest = build_manifest()
    out = os.path.join(PUBLIC, "img", "manifest.json")
    os.makedirs(os.path.dirname(out), exist_ok=True)
    with open(out, "w") as fh:
        json.dump(manifest, fh, indent=1)
    print(f"{len(manifest['products'])} product photo(s) found, {shrunk} shrunk.")


if __name__ == "__main__":
    main()
