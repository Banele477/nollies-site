from app import create_app
import os

app = create_app()

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    print(f"🚀 Nollie's Enterprise Server running on http://0.0.0.0:{port}")
    app.run(host="0.0.0.0", port=port, debug=False)
