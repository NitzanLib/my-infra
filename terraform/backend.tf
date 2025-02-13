terraform {
  backend "s3" {
    bucket = "nitz-tf-state"
    key    = "eks-cluster/terraform.tfstate"
    region = "eu-west-1"
  }
}