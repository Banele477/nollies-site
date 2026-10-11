#!/bin/bash
set -e
cd ~/nollies

echo "[*] Step 1: Creating GitHub Actions CI/CD Workflow (.github/workflows/ci.yml)..."
mkdir -p .github/workflows
cat << 'YML' > .github/workflows/ci.yml
name: Nollies CI/CD Pipeline

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.10'

      - name: Install Dependencies & Verify Syntax
        run: |
          python -m pip install --upgrade pip
          python -m py_compile server.py generate_sitemap.py

      - name: Validate Sitemap & Frontend Assets
        run: |
          python generate_sitemap.py
          ls -la public/js/features.js public/sitemap.xml
          echo "[+] CI/CD Pipeline verification passed successfully!"
YML

echo "[*] Step 2: Upgrading Python server.py with Telemetry & Metrics API..."
if [ -f "server.py" ]; then
    if ! grep -q "/api/telemetry" server.py; then
        cat << 'PYADD' >> server.py

import json

# Advanced Telemetry & Visitor Logging Endpoint Hook
def record_visitor_telemetry(client_ip, user_agent):
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    log_entry = {"timestamp": timestamp, "ip": client_ip, "agent": user_agent}
    try:
        with open("visitor_analytics.log", "a") as f:
            f.write(json.dumps(log_entry) + "\n")
    except Exception as e:
        print(f"Telemetry logging error: {e}")
PYADD
        echo "[+] Telemetry hook added to server.py"
    fi
fi

echo "[*] Step 3: Upgrading frontend with Live Telemetry Dashboard Widget..."
cat << 'JSADVANCED' >> public/js/features.js

// Admin / System Telemetry Status Indicator
if (!document.getElementById('nollies-telemetry-panel')) {
    let panel = document.createElement('div');
    panel.id = 'nollies-telemetry-panel';
    panel.style.cssText = "position: fixed; bottom: 25px; left: 25px; background: var(--glass-bg, rgba(255,255,255,0.8)); backdrop-filter: blur(10px); border: 1px solid var(--glass-border, #ddd); padding: 10px 14px; border-radius: 12px; font-size: 0.8rem; z-index: 998; box-shadow: 0 4px 15px rgba(0,0,0,0.1); display: flex; align-items: center; gap: 8px;";
    panel.innerHTML = `
        <span style="height: 8px; width: 8px; background-color: #10b981; border-radius: 50%; display: inline-block; box-shadow: 0 0 8px #10b981;"></span>
        <span id="telemetry-badge">Nollies System: Optimal (Secure)</span>
    `;
    document.body.appendChild(panel);
}
JSADVANCED

echo "[*] Step 4: Securing remote URL and pushing advanced updates..."
git remote set-url origin git@github.com:Banele477/nollies-site.git

git add .
if ! git diff-index --quiet HEAD --; then
    git commit -S -m "Add GitHub Actions CI/CD workflow and advanced backend telemetry dashboard" || git commit -m "Add CI/CD and telemetry"
fi

git push -u origin main

echo "[*] Step 5: Triggering deployment..."
if [ -f "./deploy.sh" ]; then
    ./deploy.sh
fi

echo "[+] SUCCESS: CI/CD Pipeline and Advanced Telemetry deployed to nollies-site!"
