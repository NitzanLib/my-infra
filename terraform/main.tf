provider "aws" {
  region = "eu-west-1"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.0.0"

  cluster_name                   = "my-eks-cluster"
  cluster_version                = "1.31"
  cluster_endpoint_public_access = true

  vpc_id     = aws_vpc.eks_vpc.id
  subnet_ids = concat(aws_subnet.public_subnets[*].id, aws_subnet.private_subnets[*].id)

  enable_irsa = true

  access_entries = {
    # One access entry with a policy associated
    example = {
      kubernetes_groups = []
      principal_arn     = "arn:aws:iam::424579921836:user/nitzanl"

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
      key = "nitzan-kpem"
      desired_capacity = 2
      min_capacity     = 2
      max_capacity     = 3
      instance_types   = ["t3.medium"]
      subnet_ids       = aws_subnet.private_subnets[*].id
    }
  }

  tags = {
    Name        = "my-eks-cluster"
    Environment = "dev"
  }
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_id" {
  value = module.eks.cluster_id
}

