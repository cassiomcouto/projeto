module "vpc" {
  source  = "terraform-aws-modules/vpc/aws" # Fonte do módulo VPC para criação de VPCs na AWS
  version = "5.18.1"                        # Versão do módulo VPC

  name = var.vpc_name # Nome da VPC a ser criada
  cidr = var.vpc_cidr # Bloco CIDR da VPC, determinando o intervalo de IPs da VPC

  # Configurações para as zonas de disponibilidade (AZs) e subnets
  azs             = var.azs             # Zonas de Disponibilidade onde as subnets serão criadas
  private_subnets = var.private_subnets # Subnets privadas dentro da VPC
  public_subnets  = var.public_subnets  # Subnets públicas dentro da VPC

  # Configurações para gateways
  enable_nat_gateway = var.enable_nat_gateway # Define se o NAT Gateway será habilitado
  enable_vpn_gateway = var.enable_vpn_gateway # Define se o VPN Gateway será habilitado

  # Tags para a VPC
  tags = merge(
    {
      Environment = var.environment # Tag que define o ambiente (ex: dev, prod)
    },
    var.additional_tags # Mescla com tags adicionais configuradas via variável
  )
}
