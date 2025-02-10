
# 📖 Documentação para Testes e Deploy da Aplicação

Esta documentação descreve o processo passo a passo para **construir a imagem Docker**, **enviar para um repositório Docker**, **realizar o deploy usando Helm** e **testar a aplicação diretamente no Kubernetes**.

---

## **📌 Pré-requisitos**

### **🛠️ Ferramentas Necessárias**

| Ferramenta    | Versão Recomendada |
|---------------|--------------------|
| Helm          | 3.17.0             |
| Docker        | 24.0.2             |
| Kubectl       | (versão do Cluster) |
| YQ            | 4.45.1             |

---

## 🚀 1. Construção da Imagem Docker

### 1.1. Construir a Imagem Docker Localmente

1. **Abra o terminal** no diretório raiz do projeto.
2. Execute o comando abaixo para construir a imagem Docker:

   ```bash
   docker build -t <nome-do-repositorio>/<nome-da-imagem>:<tag> .
   ```

   **Exemplo**:

   ```bash
   docker build -t mydockerrepo/app:latest .
   ```

   Isso criará uma imagem Docker chamada `app` com a tag `latest`.

### 1.2. Verificar a Imagem Criada

Após a construção da imagem, verifique se ela foi criada com sucesso:

```bash
docker images
```

Isso listará todas as imagens Docker locais.

---

## 📤 2. Enviar a Imagem para o Repositório Docker

Agora que a imagem está construída, é necessário enviá-la para um repositório Docker.

### 2.1. Fazer Login no Docker Hub (ou repositório privado)

```bash
docker login
```

Esse comando solicitará seu nome de usuário e senha.

### 2.2. Enviar a Imagem para o Repositório

```bash
docker push <nome-do-repositorio>/<nome-da-imagem>:<tag>
```

**Exemplo**:

```bash
docker push mydockerrepo/app:latest
```

---

## ☸️ 3. Realizar o Deploy no Kubernetes Usando Helm

### 3.1. Configurar o Kubernetes

Verifique se o `kubectl` está configurado corretamente:

```bash
kubectl config current-context
```

### 3.2. Editar o Arquivo `values.yaml`

1. Abra `k8s/app/values.yaml` e edite os seguintes campos, informando o repositório da imagem, nome da imagem e tag:

   ```yaml
   image:
     repository: <nome-do-repositorio>/<nome-da-imagem>
     tag: <tag-da-imagem>
   ```

   **Exemplo**:

   ```yaml
   image:
     repository: mydockerrepo/app
     tag: latest
   ```

2. Salve o arquivo e execute o deploy da aplicação no Cluster EKS:

   ```bash
   make helm-deploy
   ```

   ou de acordo com as informaçãoes do ./k8s/apps/helm-release.yaml:

   ```bash
   helm upgrade --install app ./k8s/basechart --values ./k8s/apps/values.yaml -n default
   ```

### 3.3. Verificar o Status do Deploy

```bash
kubectl get pods -n <namespace>
```

**Exemplo**:

```bash
kubectl get pods -n default
```

Caso tenha implementado em outro namespace, altere `default` para o namespace correto.

---

## 🔍 4. Testes de Endpoint no Kubernetes

### 4.1. Redirecionar a Porta do Serviço

```bash
kubectl port-forward svc/<nome-do-release> 8000:8000 -n <namespace>
```

**Exemplo**:

```bash
kubectl port-forward svc/app 8000:8000 -n default
```

Agora você pode acessar a aplicação em `http://localhost:8000`.

### 4.2. Testar os Endpoints da Aplicação com `curl`

#### ✅ Testar o Healthcheck

```bash
curl http://localhost:8000/health
```

**Saída esperada**:

```json
{"status": "healthy"}
```

#### ➕ Testar Operações de Cálculo

- **Soma**:

  ```bash
  curl -X GET "http://localhost:8000/api/sum?term_one=5&term_two=3"
  ```

  **Saída esperada**:

  ```json
  {"result": 8}
  ```

- **Subtração**:

  ```bash
  curl -X GET "http://localhost:8000/api/sub?term_one=5&term_two=3"
  ```

  **Saída esperada**:

  ```json
  {"result": 2}
  ```

- **Multiplicação**:

  ```bash
  curl -X GET "http://localhost:8000/api/mul?term_one=5&term_two=3"
  ```

  **Saída esperada**:

  ```json
  {"result": 15}
  ```

- **Divisão**:

  ```bash
  curl -X GET "http://localhost:8000/api/div?term_one=5&term_two=3"
  ```

  **Saída esperada**:

  ```json
  {"result": 2}
  ```

- **Divisão por Zero (Erro esperado)**:

  ```bash
  curl -X GET "http://localhost:8000/api/div?term_one=10&term_two=0"
  ```

  **Saída esperada**:

  ```json
  {"error": "Cannot divide by zero"}
  ```

---

## ❌ 5. Remover a Aplicação do Kubernetes

Caso precise remover a aplicação do Kubernetes, execute:

```bash
helm uninstall <nome-do-release> -n <namespace>
```

**Exemplo**:

```bash
helm uninstall app -n default
```

Para verificar se foi removido corretamente:

```bash
kubectl get pods -n default
```

---

## 📌 6. Considerações Finais

✔ **Port-Forward**: Use `kubectl port-forward` para acessar a aplicação dentro do Kubernetes localmente.

✔ **Testes**: Execute `curl` para validar os endpoints após o deploy.

✔ **Helm**: Utilize o Helm para facilitar o gerenciamento e a repetição do processo de deploy.

✔ **Monitoramento**: Use `kubectl get pods` e `kubectl get services` para verificar o status da aplicação.

---

📂 **Para mais detalhes**, consulte a documentação disponível na pasta `/doc`.
