.PHONY: build push run test helm-deploy helm-uninstall terraform-init terraform-plan terraform-apply terraform-destroy

# EKS
AWS_REGION=us-east-1
AWS_ACCOUNT_ID=918282016206
CLUSTER_EKS=eks-development
ECR_REGISTRY=$(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com
IMAGE_NAME=app

# Diretórios
TERRAFORM_DIR=terraform/infra
HELM_APPS_DIR=k8s/app
HELM_BASECHART_DIR=k8s/basechart

## ==========================================
## 🚀 Kubernetes - EKS Configuração
## ==========================================

# Configurar acesso ao cluster EKS
config-eks:
	aws eks update-kubeconfig --name $(CLUSTER_EKS) --region $(AWS_REGION)

## ==============================================
## 🏗️ Build e Push da Imagem Docker (Aplicação)
## ==============================================

# Construir a imagem Docker com tag `latest`
build:
	@echo "🔧 Construindo a imagem Docker com a tag 'latest'..."
	docker build -t $(IMAGE_NAME):latest .

# Enviar a imagem para o ECR com a tag `latest`
push: build
	@echo "🔐 Autenticando no Amazon ECR..."
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(ECR_REGISTRY)
	@echo "🚀 Enviando imagem para o ECR..."
	docker tag $(IMAGE_NAME):latest $(ECR_REGISTRY)/$(IMAGE_NAME):latest
	docker push $(ECR_REGISTRY)/$(IMAGE_NAME):latest
	@echo "✔️ Imagem enviada com sucesso!"

# Rodar o container localmente
run:
	docker run -p 8000:8000 --rm --name $(IMAGE_NAME) $(IMAGE_NAME):latest

test-docker:
	@echo "🚀 Rodando testes dentro do container..."
	docker build -t $(IMAGE_NAME)-test .
	docker run --rm -e PYTHONPATH=/app $(IMAGE_NAME)-test pytest --cov=app --cov-report=term-missing tests/



## ==========================================
## ☸️ Helm - Gerenciamento do Deploy
## ==========================================

# Instalar Helm Charts de todos os releases encontrados
helm-deploy:
	@echo "🚀 Iniciando deploy via Helm..."
	@for DIR in $(shell find $(HELM_APPS_DIR) -name "helm-release.yaml"); do \
		RELEASE_NAME=$$(yq eval '.release.name' $$DIR); \
		NAMESPACE=$$(yq eval '.release.namespace' $$DIR); \
		VALUES_FILE=$$(dirname $$DIR)/values.yaml; \
		echo "🔹 Deploying $$RELEASE_NAME no namespace $$NAMESPACE..."; \
		kubectl get namespace $$NAMESPACE >/dev/null 2>&1 || kubectl create namespace $$NAMESPACE; \
		helm upgrade --install $$RELEASE_NAME $(HELM_BASECHART_DIR) \
			--namespace $$NAMESPACE \
			--values $$VALUES_FILE \
			--create-namespace; \
	done
	@echo "✔️ Deploy finalizado!"

## ==========================================
## 🌍 Terraform - Infraestrutura
## ==========================================

# Inicializar o Terraform
terraform-init:
	cd $(TERRAFORM_DIR) && terraform init

# Verificar mudanças do Terraform
terraform-plan:
	cd $(TERRAFORM_DIR) && terraform plan

# Aplicar a infraestrutura
terraform-apply:
	cd $(TERRAFORM_DIR) && terraform apply -auto-approve

# Destruir a infraestrutura
terraform-destroy:
	cd $(TERRAFORM_DIR) && terraform destroy -auto-approve
