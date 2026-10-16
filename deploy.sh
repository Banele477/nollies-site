#!/usr/bin/env bash
set -e
echo "🚀 Setting up Python virtual environment..."
if [ ! -d "venv" ]; then
    python3 -m venv venv
fi
source venv/bin/activate
pip install --upgrade pip --quiet
pip install -r requirements.txt --quiet
echo "✨ Starting Flask server..."
python3 app.py
