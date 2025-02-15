# backend.tf
# defines the backend where the tf state will be stored

terraform {
  backend "s3" {
    bucket = "nitz-tf-state"
    key    = "eks-cluster/terraform.tfstate"
    region = "eu-west-1"
  }
}
