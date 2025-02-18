import os
from .main import app
from fastapi.testclient import TestClient

client = TestClient(app)

def test_get_me_variable_set():
    os.environ['DATAHOW_GETME'] = "Test User"  # Set the env variable
    response = client.get("/me")
    assert response.status_code == 200
    assert response.text == '\"Hello, my name is Test User\"'
    del os.environ['DATAHOW_GETME']  # Clean up

def test_get_me_variable_not_set():
    # Ensure it's not set (important for test isolation)
    if 'DATAHOW_GETME' in os.environ:
        del os.environ['DATAHOW_GETME']

    response = client.get("/me")
    assert response.status_code == 200
    assert response.text == '\"Hello, my name is None\"'  # Or your default message
