
# Documentação do Kubernetes - Usando Helm e Makefile

Esta documentação descreve como configurar e realizar o deploy da aplicação utilizando Kubernetes no EKS (Elastic Kubernetes Service), além de integrar com Docker, ECR (Elastic Container Registry), e Terraform.

## Estrutura do Diretório

```
k8s/
│
├── app/
│   ├── helm-release.yaml      # Arquivo de release do Helm para a aplicação
│   └── values.yaml            # Valores para configuração da aplicação no Helm
│
└── basechart/
    ├── templates/
    │   ├── deployment.yaml    # Configuração do Deployment do Kubernetes
    │   ├── service.yaml       # Configuração do Service do Kubernetes
    ├── Chart.yaml         # Definição do Chart do Helm
    └── values.yaml        # Valores para o Chart do Kubernetes
```

## Variáveis no Makefile

As variáveis de configuração usadas no Makefile são:

- **`AWS_REGION`**: Região AWS onde o EKS e ECR estão localizados (ex: `us-east-1`).
- **`AWS_ACCOUNT_ID`**: ID da conta AWS (ex: `XXXXXXXXXXXXXXX`).
- **`CLUSTER_EKS`**: Nome do cluster EKS (ex: `eks-development`).
- **`ECR_REGISTRY`**: URL do repositório ECR onde as imagens Docker serão enviadas.
- **`IMAGE_NAME`**: Nome da imagem Docker (ex: `app`).
- **`HELM_APPS_DIR`**: Diretório onde estão localizados os arquivos Helm para deploy da aplicação.
- **`HELM_BASECHART_DIR`**: Diretório do Helm Chart base.

## Comandos do Makefile

### 🚀 **Configuração do EKS**

1. **Configurar Acesso ao EKS**:
   - Este comando configura o acesso ao cluster EKS usando o AWS CLI:
   ```bash
   make config-eks
   ```

### 🏗️ **Build e Push da Imagem Docker**

2. **Construir a Imagem Docker**:
   - Este comando constrói a imagem Docker com a tag `latest`:
   ```bash
   make build
   ```

3. **Enviar a Imagem para o ECR**:
   - Este comando envia a imagem Docker para o repositório ECR:
   ```bash
   make push
   ```

4. **Rodar o Container Localmente**:
   - Para rodar o container Docker localmente:
   ```bash
   make run
   ```

5. **Rodar Testes Dentro do Container**:
   - Para rodar os testes dentro do container Docker:
   ```bash
   make test-docker
   ```

### ☸️ **Gerenciamento do Deploy com Helm**

6. **Deploy da Aplicação com Helm**:
   - Este comando executa o deploy do Helm chart encontrados no diretório `k8s/app`:
   ```bash
   make helm-deploy
   ```
   - O Helm irá usar o arquivo `helm-release.yaml` para configurar o release e o `values.yaml` para passar os valores de configuração para o Helm Chart.
