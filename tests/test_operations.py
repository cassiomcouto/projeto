# Importa as funções matemáticas da aplicação
from app.operations import add, subtract, multiply, divide
# Importa o pytest para realizar os testes
import pytest

# Testes para a função de soma
@pytest.mark.parametrize("a, b, expected", [
    (1, 2, 3),     # 1 + 2 = 3
    (-1, -2, -3),  # -1 + (-2) = -3
    (-1, 2, 1),    # -1 + 2 = 1
])
def test_add(a, b, expected):
    assert add(a, b) == expected  # Valida se a função retorna o valor esperado

# Testes para a função de subtração
@pytest.mark.parametrize("a, b, expected", [
    (5, 3, 2),    # 5 - 3 = 2
    (-1, -2, 1),  # -1 - (-2) = 1
    (0, 3, -3),   # 0 - 3 = -3
])
def test_subtract(a, b, expected):
    assert subtract(a, b) == expected

# Testes para a função de multiplicação
@pytest.mark.parametrize("a, b, expected", [
    (4, 3, 12),   # 4 * 3 = 12
    (-1, -2, 2),  # -1 * -2 = 2
    (0, 3, 0),    # 0 * 3 = 0
])
def test_multiply(a, b, expected):
    assert multiply(a, b) == expected

# Testes para a função de divisão
@pytest.mark.parametrize("a, b, expected", [
    (10, 2, 5),  # 10 / 2 = 5
    (9, 3, 3),   # 9 / 3 = 3
])
def test_divide(a, b, expected):
    assert divide(a, b) == expected

# Teste para garantir que a divisão por zero gera um erro
def test_divide_by_zero():
    with pytest.raises(ZeroDivisionError, match="Divisão por zero não permitida"):
        divide(10, 0)
