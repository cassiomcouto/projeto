
# Documentação de Testes

Este documento descreve como configurar e executar os testes do app do Projeto.

## Estrutura dos Arquivos de Teste

A estrutura dos arquivos de teste no diretório `tests` é a seguinte:

```
tests/
│
├── __init__.py              # Arquivo de inicialização do pacote de testes
├── test_api.py              # Testes relacionados à API
├── test_main.py             # Testes principais da aplicação
├── test_operations.py       # Testes de operações e funcionalidades principais
├── test_performance.py      # Testes de performance
```

### Descrição dos Arquivos:
- **`test_api.py`**: Contém testes relacionados às funcionalidades da API, como endpoints, validações e comportamentos esperados.
- **`test_main.py`**: Testes principais da aplicação, verificando o fluxo geral do sistema.
- **`test_operations.py`**: Testes focados nas operações internas da aplicação. Inclui testes unitários para funções como soma, subtração, multiplicação e divisão. O objetivo dos testes unitários é garantir que as funções individuais, isoladas do resto do sistema, se comportem como esperado.
- **`test_performance.py`**: Testes focados no desempenho e carga da aplicação.

## Como Rodar os Testes

Para rodar os testes no ambiente Docker, siga os passos abaixo:

### 1. **Construir a Imagem do Docker**
```bash
docker build -t app-test .
```
Este comando cria uma imagem Docker com o nome especificado `app` e a etiqueta `-test`.

### 2. **Executar os Testes Dentro do Docker**
```bash
docker run --rm -e PYTHONPATH=/app app-test pytest --cov=app --cov-report=term-missing tests/
```
Este comando executa os testes dentro do container Docker. O comando `pytest` executa os testes e gera um relatório de cobertura de código. A variável `PYTHONPATH` é configurada para garantir que o código da aplicação seja corretamente localizado dentro do container.

## Configuração do Ambiente

Certifique-se de ter o Docker instalado e configurado corretamente antes de rodar os testes. A imagem Docker é construída com base no arquivo Dockerfile, que inclui todas as dependências necessárias para executar os testes.

