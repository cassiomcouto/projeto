# Importações necessárias
from fastapi import FastAPI, HTTPException
from app.operations import add, subtract, multiply, divide
from app.health import healthcheck

# Inicializa a aplicação FastAPI
app = FastAPI()

# Endpoints de operações matemáticas
@app.get("/api/sum")
def sum_numbers(term_one: int, term_two: int):
    """Retorna a soma de dois números"""
    return {"result": add(term_one, term_two)}

@app.get("/api/sub")
def sub_numbers(term_one: int, term_two: int):
    """Retorna a subtração de dois números"""
    return {"result": subtract(term_one, term_two)}

@app.get("/api/mul")
def mul_numbers(term_one: int, term_two: int):
    """Retorna a multiplicação de dois números"""
    return {"result": multiply(term_one, term_two)}

@app.get("/api/div")
def div_numbers(term_one: float, term_two: float):
    """Retorna a divisão de dois números. Se `term_two` for 0, retorna erro 400"""
    if term_two == 0:
        raise HTTPException(status_code=400, detail="Divisão por zero não permitida")
    return {"result": term_one / term_two}

# Healthcheck da aplicação
@app.get("/health")
def health():
    """Verifica a saúde da aplicação"""
    return healthcheck()
