terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket"
    key    = "eks-cluster/terraform.tfstate"
    region = "eu-west-1"
  }
}