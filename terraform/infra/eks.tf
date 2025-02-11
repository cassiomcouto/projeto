module "eks" {
  source  = "terraform-aws-modules/eks/aws" # Fonte do módulo EKS da AWS
  version = "~> 20.33"                      # Versão do módulo

  cluster_name    = "eks-${var.environment}" # Nome do cluster EKS, com base no ambiente (ex: eks-development)
  cluster_version = var.cluster_version      # Versão do Kubernetes a ser utilizada no cluster

  # Addons para o cluster EKS, que são serviços e ferramentas adicionais a serem instalados
  cluster_addons = {
    kube-proxy             = true # Habilita o Kube Proxy para roteamento de rede dentro do cluster
    metrics-server         = true # Habilita o Metrics Server para coleta de métricas de recursos
  }

  # Configurações de acesso público e permissões administrativas
  cluster_endpoint_public_access           = true # Permite acesso público ao endpoint do cluster
  enable_cluster_creator_admin_permissions = true # Concede permissões administrativas ao criador do cluster

  # VPC e subnets onde o cluster será instalado
  vpc_id     = module.vpc.vpc_id          # ID da VPC onde o cluster será criado
  subnet_ids = module.vpc.private_subnets # Subnets privadas onde os nós serão criados

  # Configuração padrão para grupos de nós gerenciados
  eks_managed_node_group_defaults = {
    instance_types = ["t3.medium"] # Tipo de instância padrão para os nós gerenciados
    capacity_type  = "SPOT"        # Capacitadade da instância: ON_DEMAND ou SPOT
  }

  # Definição dos grupos de nós gerenciados para o cluster, passando variáveis configuráveis
  eks_managed_node_groups = var.eks_managed_node_groups # Definições específicas para grupos de nós

  # Adição de tags ao cluster EKS, mesclando tags padrão e adicionais
  tags = merge(
    {
      Environment = var.environment # Tag para o ambiente (ex: dev, prod)
    },
    var.additional_tags # Tags adicionais configuradas via variável
  )
}
