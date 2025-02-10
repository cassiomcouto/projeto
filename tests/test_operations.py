from app.operations import add, subtract, multiply, divide
import pytest

@pytest.mark.parametrize("a, b, expected", [
    (1, 2, 3),
    (-1, -2, -3),
    (-1, 2, 1),
])
def test_add(a, b, expected):
    assert add(a, b) == expected

@pytest.mark.parametrize("a, b, expected", [
    (5, 3, 2),
    (-1, -2, 1),
    (0, 3, -3),
])
def test_subtract(a, b, expected):
    assert subtract(a, b) == expected

@pytest.mark.parametrize("a, b, expected", [
    (4, 3, 12),
    (-1, -2, 2),
    (0, 3, 0),
])
def test_multiply(a, b, expected):
    assert multiply(a, b) == expected

@pytest.mark.parametrize("a, b, expected", [
    (10, 2, 5),
    (9, 3, 3),
])
def test_divide(a, b, expected):
    assert divide(a, b) == expected

# 🚨 Testando erro de divisão por zero
def test_divide_by_zero():
    with pytest.raises(ZeroDivisionError):
        divide(10, 0)
