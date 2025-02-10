terraform {
  required_version = "~> 1.10.0" # Define a versão mínima do Terraform necessária para executar esse código

  # Configuração de integração com o Terraform Cloud
  cloud {
    organization = "cassiomcouto" # Nome da organização no Terraform Cloud

    workspaces {
      name = "infra" # Nome do workspace do Terraform Cloud, utilizado para organizar o código e estado da infraestrutura
    }
  }

  # Definição dos provedores necessários para o Terraform
  required_providers {
    aws = {
      source  = "hashicorp/aws" # Especifica o provedor AWS utilizado, vindo do Terraform Registry
      version = "~> 5.0"        # Define a versão mínima do provedor AWS necessária (5.x.x)
    }
  }
}
