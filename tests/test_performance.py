import pytest
from app.operations import divide

# 🚨 Testando erro de divisão por zero
def test_divide_by_zero():
    with pytest.raises(ZeroDivisionError, match="Divisão por zero não permitida"):
        divide(10, 0)
