import pytest
from app import app  # replace 'your_app_filename' with your Python file name without .py

@pytest.fixture
def client():
    with app.test_client() as client:
        yield client

def test_hello_world(client):
    response = client.get('/')
    assert response.status_code == 200
    assert response.data.decode('utf-8') == "Hello, World!"

