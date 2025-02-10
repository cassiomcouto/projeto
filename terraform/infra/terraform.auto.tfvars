aws_region         = "us-east-1"
environment        = "development"
vpc_name           = "vpc"
vpc_cidr           = "100.0.0.0/16"
azs                = ["us-east-1a", "us-east-1b"]
private_subnets    = ["100.0.1.0/24", "100.0.2.0/24"]
public_subnets     = ["100.0.101.0/24", "100.0.102.0/24"]
enable_nat_gateway = false
enable_vpn_gateway = false

# EKS
cluster_version = "1.32"

eks_managed_node_groups = {
  development = {
    ami_type       = "AL2023_x86_64_STANDARD"
    instance_types = ["t3.medium"]

    min_size     = 1
    max_size     = 1
    desired_size = 1
  }
}

# ECR
repository_name = "app"

# Tags
additional_tags = {
  Terraform  = "true"
  Owner      = "DevOps Team"
  Project    = "Foxbit"
  Department = "Engineering"
}
