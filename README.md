
# Documentação para Testes e Deploy da Aplicação

Esta documentação descreve o processo passo a passo para **construir a imagem Docker**, **enviar para um repositório Docker**, **realizar o deploy usando Helm**, e **testar a aplicação diretamente no Kubernetes**. 

## 1. Construção da Imagem Docker

### 1.1. Construir a Imagem Docker Localmente

1. **Abra o terminal** no diretório raiz do projeto.
2. Execute o comando abaixo para construir a imagem Docker:

   ```bash
   docker build -t <nome-do-repositorio>/<nome-da-imagem>:<tag> .
   ```

   **Exemplo**:

   ```bash
   docker build -t mydockerrepo/my-app:latest .
   ```

   Isso criará uma imagem Docker chamada `my-app` com a tag `latest`. Você pode substituir `mydockerrepo` pelo nome do seu repositório Docker.

### 1.2. Verificar a Imagem Criada

Depois que a imagem for construída, você pode verificar se ela foi criada com sucesso executando:

```bash
docker images
```

Isso listará todas as imagens Docker locais, incluindo a que você acabou de criar.

## 2. Enviar a Imagem para o Repositório Docker

Agora que a imagem está construída, é hora de enviá-la para o repositório Docker.

### 2.1. Fazer Login no Docker Hub (ou repositório privado)

Se você ainda não fez login no seu repositório Docker, faça o login com o comando:

```bash
docker login
```

Esse comando solicitará seu nome de usuário e senha.

### 2.2. Enviar a Imagem para o Repositório

Para enviar a imagem para o repositório, execute:

```bash
docker push <nome-do-repositorio>/<nome-da-imagem>:<tag>
```

**Exemplo**:

```bash
docker push mydockerrepo/my-app:latest
```

Isso enviará a imagem para o repositório Docker.

## 3. Realizar o Deploy no Kubernetes Usando Helm

Agora, vamos realizar o deploy da aplicação no Kubernetes utilizando o **Helm**.

### 3.1. Configurar o Kubernetes

Certifique-se de que seu `kubectl` está configurado corretamente para o cluster Kubernetes onde você deseja realizar o deploy.

Para verificar se o `kubectl` está apontando para o cluster correto, use:

```bash
kubectl config current-context
```

### 3.2. Instalar a Aplicação no Kubernetes

1. Navegue até o diretório onde está o **chart do Helm** da aplicação (`k8s/app`).
2. **Editar o arquivo `values.yaml`** para configurar o repositório e a tag da imagem Docker:

   - Abra o arquivo `k8s/app/values.yaml` no editor de sua preferência.
   - Localize a seção da imagem, que deve estar parecida com isso:

     ```yaml
     image:
       repository: <nome-do-repositorio>/<nome-da-imagem>
       tag: <tag-da-imagem>
     ```

   - **Edite os campos `repository` e `tag`** com os valores da sua imagem Docker:

     ```yaml
     image:
       repository: mydockerrepo/my-app
       tag: latest
     ```

3. Após editar o arquivo, execute o seguinte comando para realizar o deploy com Helm:

   ```bash
   make helm-deploy
   ```
   
   Isso realizará o deploy da aplicação no Kubernetes, usando a imagem Docker que você acabou de enviar para o repositório.

### 3.3. Verificar o Status do Deploy

Após o deploy, você pode verificar se os pods estão em execução com o comando:

```bash
kubectl get pods -n default
```

Isso listará todos os pods no namespace `default` e mostrará o status da aplicação, caso tenha implementado em outro namespace é preciso alterar o `default`pelo namespace utilizado no helm-release.yaml.



## 4. Testes de Endpoint no Kubernetes

Agora que a aplicação está implantada no Kubernetes, você pode testar os endpoints diretamente no cluster usando o `kubectl port-forward` para mapear a porta do serviço para o seu localhost.

### 4.1. Rodar o `kubectl port-forward`

Para testar os endpoints da aplicação diretamente, execute o seguinte comando para redirecionar a porta do serviço para sua máquina local:

```bash
kubectl port-forward svc/app 8000:8000 -n default
```

Isso irá mapear a porta `8000` do serviço `app` no Kubernetes para a porta `8000` na sua máquina local. Após isso, você poderá acessar a aplicação localmente, usando `http://localhost:8000`.

### 4.2. Testar os Endpoints da Aplicação com `curl`

Agora que a aplicação está acessível localmente, você pode usar o `curl` para testar os diferentes endpoints.

1. **Testar o Healthcheck da Aplicação**:
   Verifique se o endpoint de saúde está funcionando corretamente.

   ```bash
   curl http://localhost:8000/health
   ```

   **Saída Esperada**:
   ```json
   {"status": "healthy"}
   ```

2. **Testar os Endpoints de Cálculo**:
   Teste os endpoints que executam as operações de soma, subtração, multiplicação e divisão.

   - **Soma**:
     ```bash
     curl -X GET "http://localhost:8000/api/sum?term_one=5&term_two=3"
     ```
     **Saída Esperada**:
     ```json
     {"result": 8}
     ```

   - **Subtração**:
     ```bash
     curl -X GET "http://localhost:8000/api/sub?term_one=5&term_two=3"
     ```
     **Saída Esperada**:
     ```json
     {"result": 2}
     ```

   - **Multiplicação**:
     ```bash
     curl -X GET "http://localhost:8000/api/mul?term_one=5&term_two=3"
     ```
     **Saída Esperada**:
     ```json
     {"result": 15}
     ```

   - **Divisão**:
     ```bash
     curl -X GET "http://localhost:8000/api/div?term_one=5&term_two=3"
     ```
     **Saída Esperada**:
     ```json
     {"result": 2}
     ```

   - **Divisão por Zero (Erro)**:
     Verifique se a aplicação trata corretamente o erro de divisão por zero.

     ```bash
     curl -X GET "http://localhost:8000/api/div?term_one=10&term_two=0"
     ```

     **Saída Esperada**:
     ```json
     {"error": "Cannot divide by zero"}
     ```


## 5. Remover a Aplicação do Kubernetes

Caso você precise remover a aplicação do Kubernetes, basta executar o comando `helm uninstall` para remover o release correspondente.

### 5.1. Comando para Remover a Aplicação

1. Para remover o deploy da aplicação, execute o seguinte comando:

   ```bash
   helm uninstall <nome-do-release> -n default
   ```

   **Exemplo**:

   ```bash
   helm uninstall app -n default
   ```

   Isso irá remover a aplicação do Kubernetes, incluindo todos os recursos associados (como pods, serviços, etc.) relacionados a esse release.

2. Para verificar se a aplicação foi removida corretamente, execute o comando:

   ```bash
   kubectl get pods -n default
   ```

   Isso deve listar os pods no namespace `default` e, ao remover a aplicação, não deve aparecer o pod da aplicação no retorno do comando.

---

## 5. Considerações Finais

- **Port-Forward**: Use o `kubectl port-forward` para acessar a aplicação de dentro do Kubernetes localmente. Isso permite que você teste a aplicação sem a necessidade de expor o serviço diretamente.
- **Testes**: Após o deploy, faça os testes com `curl` para garantir que todos os endpoints estejam funcionando corretamente.
- **Helm**: Utilize o Helm para garantir que o deploy seja realizado de maneira consistente e repetível no Kubernetes. Isso facilita o gerenciamento de versões da aplicação e facilita os upgrades.
- **Manutenção e Monitoramento**: Verifique regularmente o status dos pods e serviços no Kubernetes, usando `kubectl get pods` e `kubectl get services`. Caso a aplicação precise ser atualizada ou escalada, o Helm facilita esse processo.

Para mais detalhes sobre cada parte do processo, consulte a documentação disponível na pasta `/doc`.