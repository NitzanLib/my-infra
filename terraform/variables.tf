variable "aws_region" {
  description = "AWS region where the infrastructure will be deployed"
  type        = string
  default     = "eu-west-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "my-eks-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.31"
}

variable "instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "principal_arn_id" {
  description = "IAM ARN to grant cluster admin access"
  type        = string
  default     = "arn:aws:iam::424579921836:user/nitzanl"
}
