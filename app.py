import os
from flask import Flask, jsonify, request, render_template
from flask_migrate import Migrate
from models import db
from routes import students_bp
import requests
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Initialize Flask app
app = Flask(__name__)

# Configurations
app.config.from_object('config.Config')

# Initialize database and migrations
db.init_app(app)
migrate = Migrate(app, db)

# Register routes
app.register_blueprint(students_bp)

# Fetch Postman collection
POSTMAN_API_URL = app.config['POSTMAN_API_URL']
ACCESS_KEY = app.config['POSTMAN_ACCESS_KEY']

response = requests.get(f"{POSTMAN_API_URL}?access_key={ACCESS_KEY}")
if response.status_code == 200:
    print("Postman Collection retrieved successfully")
else:
    print("Failed to retrieve Postman Collection")

# Serve the index.html form
@app.route('/')
def index():
    return render_template('index.html')

# Run the application
if __name__ == '__main__':
    app.run(debug=True)
