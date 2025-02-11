module "ecr_app" {
  source  = "terraform-aws-modules/ecr/aws" # Utiliza o módulo oficial do Terraform para criar um repositório no ECR
  version = "~> 2.3"                        # Define a versão do módulo para garantir compatibilidade

  repository_name = var.repository_name     # Define o nome do repositório com base em uma variável

  repository_read_write_access_arns = [     # Configura permissões de leitura e escrita para o repositório
    module.iam_assumable_role_ecr.iam_role_arn # Especifica a IAM Role que terá acesso ao ECR
  ]

  # Configuração de mutabilidade das tags de imagem: permitido alterar as tags após a criação
  repository_image_tag_mutability = "MUTABLE"

  # Política de ciclo de vida do repositório para expiração de imagens
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1                    # Prioridade da regra de expiração
        description  = "Keep last 5 images" # Descrição da regra
        selection = {
          tagStatus     = "tagged"             # Filtra imagens com tags
          tagPrefixList = ["v"]                # Prefixo da tag a ser considerado
          countType     = "imageCountMoreThan" # Tipo de contagem (baseado em número de imagens)
          countNumber   = 5                    # Número máximo de imagens a serem mantidas
        },
        action = {
          type = "expire" # Ação de expiração para as imagens mais antigas
        }
      }
    ]
  })

  tags = var.additional_tags # Tags adicionais para o repositório
}
