import pytest
from fastapi.testclient import TestClient
from app.main import app  # 🔹 Certifique-se de que `app` está sendo importado corretamente

# Criando `client` globalmente antes de rodar os testes
@pytest.fixture(scope="module")
def test_client():
    return TestClient(app)

# Teste para soma
def test_sum(test_client):
    response = test_client.get("/api/sum?term_one=2&term_two=3")
    assert response.status_code == 200
    assert response.json() == {"result": 5}

# Teste para subtração
def test_sub(test_client):
    response = test_client.get("/api/sub?term_one=5&term_two=3")
    assert response.status_code == 200
    assert response.json() == {"result": 2}

# Teste para multiplicação
def test_mul(test_client):
    response = test_client.get("/api/mul?term_one=4&term_two=3")
    assert response.status_code == 200
    assert response.json() == {"result": 12}

# Teste para divisão
def test_div(test_client):
    response = test_client.get("/api/div?term_one=10&term_two=2")
    assert response.status_code == 200
    assert response.json() == {"result": 5.0}

# Teste para divisão por zero
def test_div_by_zero(test_client):
    response = test_client.get("/api/div?term_one=10&term_two=0")
    assert response.status_code == 400
    assert response.json() == {"detail": "Divisão por zero não permitida"}

# Testando healthcheck
def test_health(test_client):
    response = test_client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "healthy"}

# Testando inputs inválidos para todos os endpoints
@pytest.mark.parametrize("endpoint", ["/api/sum", "/api/sub", "/api/mul", "/api/div"])
def test_invalid_inputs(test_client, endpoint):
    response = test_client.get(f"{endpoint}?term_one=a&term_two=b")
    assert response.status_code == 422  # FastAPI retorna 422 para erro de input
