# main.tf
# this file contains the main infra config for the EKS Cluster
# includes VPC, subnets and EKS module config

provider "aws" {
  region = var.aws_region
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.0.0"

  cluster_name                   = var.cluster_name
  cluster_version                = var.cluster_version
  cluster_endpoint_public_access = true

  vpc_id     = aws_vpc.eks_vpc.id
  subnet_ids = concat(aws_subnet.public_subnets[*].id, aws_subnet.private_subnets[*].id)

  enable_irsa = true      # Allows service accounts to get IAM Roles

  access_entries = {
    # Access entry for system admin user of the cluster
    example = {
      kubernetes_groups = []
      principal_arn     = var.principal_arn_id      # Defined in the variables.tf file

      policy_associations = {
        example = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            namespaces = []
            type       = "cluster"
          }
        }
      }
    }
  }

  eks_managed_node_groups = {
    worker_nodes = {
      desired_capacity = 2
      min_capacity     = 2
      max_capacity     = 3
      instance_types   = [var.instance_type]
      subnet_ids       = aws_subnet.private_subnets[*].id
    }
  }

  tags = {
    Name        = var.cluster_name
    Environment = "dev"
  }
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_id" {
  value = module.eks.cluster_id
}
