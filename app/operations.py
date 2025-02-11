# Função para somar dois números inteiros
def add(a: int, b: int) -> int:
    return a + b

# Função para subtrair dois números inteiros
def subtract(a: int, b: int) -> int:
    return a - b

# Função para multiplicar dois números inteiros
def multiply(a: int, b: int) -> int:
    return a * b

# Função para dividir dois números
def divide(a: int, b: int) -> float:
    if b == 0:
        raise ZeroDivisionError("Divisão por zero não permitida")  # Tratamento de erro para divisão por zero
    return a / b
