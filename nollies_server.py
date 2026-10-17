"""Standalone Nollie's server: serves public/ and the order API."""
import os
from flask import Flask, jsonify, request
import orders_api

BASE = os.path.dirname(os.path.abspath(__file__))
app = Flask(__name__, static_folder=os.path.join(BASE, "public"), static_url_path="")
orders_api.init_app(app)


@app.route("/")
def home():
    return app.send_static_file("index.html")


@app.errorhandler(404)
def not_found(_e):
    if request.path.startswith("/api/"):
        return jsonify(error="Not found."), 404
    return app.send_static_file("404.html"), 404


@app.errorhandler(413)
def too_big(_e):
    return jsonify(error="Request too large."), 413


if __name__ == "__main__":
    app.run(host=os.environ.get("HOST", "127.0.0.1"), port=int(os.environ.get("PORT", "5000")))
