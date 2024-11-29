import os

class Config:
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL', 'sqlite:///students.db')  # Default to SQLite
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    POSTMAN_API_URL = "https://api.postman.com/collections/40077421-7a7db72b-2afc-450b-af9e-afe6b0b98724"
    POSTMAN_ACCESS_KEY = os.getenv("POSTMAN_API_KEY")

