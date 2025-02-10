
# Estrutura do Diretório `terraform/infra`

```
terraform/
│
└── infra/
    ├── backend.tf                # Configuração do backend (onde o estado do Terraform será armazenado)
    ├── ecr.tf                    # Configuração para criação do ECR (Elastic Container Registry)
    ├── eks.tf                    # Configuração para criação do EKS (Elastic Kubernetes Service)
    ├── provider.tf               # Configuração do provedor AWS (define a região e acesso)
    ├── terraform.auto.tfvars     # Arquivo automático de variáveis para configuração (geralmente usado em ambientes)
    ├── variables.tf              # Declaração de variáveis que serão utilizadas no Terraform
    └── vpc.tf                    # Configuração da VPC (Virtual Private Cloud) e suas subnets
```

## Descrição dos Arquivos:

- **`backend.tf`**: Arquivo que configura o backend do Terraform, ou seja, o local onde o estado do Terraform será armazenado, como em S3, Consul, etc.
- **`ecr.tf`**: Configuração para criar e gerenciar o repositório ECR (Elastic Container Registry), onde as imagens de contêiner serão armazenadas.
- **`eks.tf`**: Configuração para criar e gerenciar o cluster EKS (Elastic Kubernetes Service) para rodar e orquestrar os containers Kubernetes.
- **`provider.tf`**: Arquivo que configura o provedor AWS, especificando a região e credenciais necessárias para o Terraform interagir com a AWS.
- **`terraform.auto.tfvars`**: Arquivo de variáveis automaticamente carregado pelo Terraform, utilizado para definir valores de variáveis, como credenciais, regiões e configurações do ambiente.
- **`variables.tf`**: Declaração de variáveis usadas em toda a configuração do Terraform. Essas variáveis são definidas e podem ser atribuídas a valores específicos em outros arquivos.
- **`vpc.tf`**: Arquivo responsável pela configuração da VPC (Virtual Private Cloud) dentro da AWS, definindo CIDR, subnets públicas e privadas, e configurações de segurança e conectividade.

## Comandos do Makefile

### 🌍 **Infraestrutura com Terraform**

1. **Inicializar o Terraform**:
   - Este comando inicializa o diretório do Terraform:
   ```bash
   make terraform-init
   ```

2. **Verificar Mudanças do Terraform**:
   - Este comando exibe o plano de execução do Terraform:
   ```bash
   make terraform-plan
   ```

3. **Aplicar a Infraestrutura com Terraform**:
    - Este comando aplica as mudanças de infraestrutura com o Terraform:
    ```bash
    make terraform-apply
    ```

4. **Destruir a Infraestrutura com Terraform**:
    - Este comando destrói a infraestrutura gerenciada pelo Terraform:
    ```bash
    make terraform-destroy
    ```
