provider "aws" {
  region = "eu-west-1"
}

# Use Terraform AWS EKS module to create the cluster
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"  # Check for latest version

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.27"
  cluster_endpoint_public_access = true

  vpc_id     = aws_vpc.eks_vpc.id
  subnet_ids = concat(aws_subnet.public_subnets[*].id, aws_subnet.private_subnets[*].id)

  enable_irsa = true  # Enable IAM Roles for Service Accounts

  node_groups = {
    worker_nodes = {
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