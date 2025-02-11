variable "aws_region" {
  type        = string
  description = "Região da AWS onde a infraestrutura será provisionada"
}

variable "vpc_name" {
  type        = string
  description = "Nome da VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "Bloco CIDR da VPC"
}

variable "azs" {
  type        = list(string)
  description = "Lista de zonas de disponibilidade"
}

variable "private_subnets" {
  type        = list(string)
  description = "Lista de subnets privadas na VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "Lista de subnets públicas na VPC"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Habilita ou desabilita o NAT Gateway"
}

variable "enable_vpn_gateway" {
  type        = bool
  description = "Habilita ou desabilita o VPN Gateway"
}

variable "environment" {
  type        = string
  description = "Nome do ambiente (development, production)"
}

# EKS 
variable "cluster_version" {
  type        = string
  default     = "1.31"
  description = "Versão do cluster EKS"
}

variable "eks_managed_node_groups" {
  description = "Configuração dos Managed Node Groups do EKS"
  type = map(object({
    instance_types = list(string)
    min_size       = number
    max_size       = number
    desired_size   = number
  }))
}

# ECR
variable "repository_name" {
  type        = string
  description = "Nome do repositorio ECR"
}

# Tags
variable "additional_tags" {
  type        = map(string)
  description = "Tags adicionais para o EKS"
  default     = {}
}
