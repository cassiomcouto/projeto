from fastapi import FastAPI, HTTPException
from app.operations import add, subtract, multiply, divide
from app.health import healthcheck

app = FastAPI()

@app.get("/api/sum")
def sum_numbers(term_one: int, term_two: int):
    return {"result": add(term_one, term_two)}

@app.get("/api/sub")
def sub_numbers(term_one: int, term_two: int):
    return {"result": subtract(term_one, term_two)}

@app.get("/api/mul")
def mul_numbers(term_one: int, term_two: int):
    return {"result": multiply(term_one, term_two)}

@app.get("/api/div")
def div_numbers(term_one: float, term_two: float):
    if term_two == 0:
        raise HTTPException(status_code=400, detail="Divisão por zero não permitida")
    return {"result": term_one / term_two}

@app.get("/health")
def health():
    return healthcheck()
