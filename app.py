from flask import Flask, render_template, request, jsonify
from flask_sqlalchemy import SQLAlchemy
import os

app = Flask(__name__, static_folder='static', template_folder='templates')
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///nollies.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

class BulkQuote(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    customer_name = db.Column(db.String(100), nullable=False)
    whatsapp_number = db.Column(db.String(30), nullable=False)
    requirements = db.Column(db.Text, nullable=False)
    created_at = db.Column(db.DateTime, server_default=db.func.current_timestamp())

with app.app_context():
    db.create_all()

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/bulk-quote', methods=['POST'])
def handle_bulk_quote():
    data = request.get_json()
    if not data or not data.get('customer_name') or not data.get('whatsapp_number') or not data.get('requirements'):
        return jsonify({'success': False, 'error': 'Please complete all required fields.'}), 400
    
    quote = BulkQuote(
        customer_name=data.get('customer_name').strip(),
        whatsapp_number=data.get('whatsapp_number').strip(),
        requirements=data.get('requirements').strip()
    )
    db.session.add(quote)
    db.session.commit()
    
    return jsonify({
        'success': True, 
        'message': 'Quote request saved successfully!'
    }), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)
