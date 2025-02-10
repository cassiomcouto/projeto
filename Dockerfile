FROM python:3.11-slim

WORKDIR /app

# Copia os arquivos necessários para instalação das dependências
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Definir o PYTHONPATH para garantir que os testes localizem `app`
ENV PYTHONPATH=/app

# Copiar o código da aplicação e os testes
COPY app /app/app
COPY tests /app/tests

# Executar a aplicação corretamente
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
