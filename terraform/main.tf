provider "aws" {
  region = "eu-west-1"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.0.0"

  cluster_name                   = "my-eks-cluster"
  cluster_version                = "1.27"
  cluster_endpoint_public_access = true

  vpc_id     = aws_vpc.eks_vpc.id
  subnet_ids = concat(aws_subnet.public_subnets[*].id, aws_subnet.private_subnets[*].id)

  enable_irsa = true

  # Use self-managed node groups as a workaround for the node_groups error.
  self_managed_node_groups = [
    {
      name                      = "worker-nodes"
      desired_capacity          = 2
      min_capacity              = 2
      max_capacity              = 3
      instance_types            = ["t3.medium"]
      subnet_ids                = aws_subnet.private_subnets[*].id

      # Ensure the launch template name prefix is at least 3 characters.
      launch_template_use_name_prefix = true
      launch_template_name      = "worker-node"  # This string is > 3 characters.
    }
  ]

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
