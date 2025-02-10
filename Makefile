.PHONY: terraform-init terraform-plan terraform-apply terraform-destroy

# Diretórios
TERRAFORM_DIR=terraform/infra


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
