# my-infra

This repository contains Terraform configurations for provisioning the EKS cluster and the necessary resources to deploy the counter-service application. 

It creates the VPC, subnets, EKS cluster, node groups, and supporting resources (IAM roles, security groups, etc.). 

The repository also includes GitHub Actions workflows for validation and deployment.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Repository Structure](#repository-structure)
- [How to Use](#how-to-use)
- [Required Variables](#required-variables)
- [GitHub Actions Workflows](#github-actions-workflows)
- [Additional Resources](#additional-resources)

## Prerequisites

- **Terraform**: Version 1.10.5.
- **AWS CLI**: Installed and configured with appropriate permissions.
- An AWS account with permissions to create VPCs, EKS clusters, IAM roles, and other required resources.
- (Optional) GitHub Actions enabled for CI/CD automation.

## Repository Structure
```
my-infra/
├── .github/
│   └── workflows/
│       ├── tf-validate.yml    # Validates Terraform formatting, and configuration
│       └── tf-deploy.yml      # Deploys AWS infrastructure via Terraform (runs on main branch after validation)
├── terraform/
│   ├── main.tf              # Main terraform configuration
│   ├── backend.tf           # Backend for TF state file
│   ├── vpc.tf               # VPC and networking configuration (VPC, subnets, route tables, etc.)
│   ├── nat.tf               # Nat configuration
│   ├── route.tf             # Route configuration
│   ├── subnets.tf           # Subnets configuration
│   ├── igw.tf               # Internet Gateway configuration
│   ├── variables.tf         # Variable declarations
│   ├── outputs.tf           # Outputs for resources
├── terraform.tfvars         # (Optional) Variable values file for customization
└── README.md                # This file

```
## How to Use

1. Initialization:
   - To download necessary providers and initialize your backend, in the root directory (where your terraform files are), run:
   - ```terraform init```
     
2. Plan:
   - Generate execution plan:
   - ```terraform plan -out=tfplan```
   - Review the output to confirm changes.
     
3. Apply the planned changes to deploy the infra:
   - ```terraform apply -auto-approve tfplan```
   - Terraform will provision all the defined resources.

4. Destroy:
   - To tear down the infrastructure, run ```terraform destroy -auto-approve```

## Required Variables

The following variables should be set, all have defaults. These variables can be set in the ```variables.tf``` or ```terraform.tfvars``` file.

- ```aws_region``` - AWS region where the infrastructure will be deployed
- ```cluster_name``` - EKS cluster name
- ```cluster_version``` - Kubernetes version for the EKS cluster
- ```instance_type``` - EC2 instance type for worker nodes
- ```principal_arn_id``` - IAM ARN to grant cluster admin access (Make sure to update with your own Principal ARN)


## Github Actions Workflows

This repository includes two GitHub Actions workflows:

1. Terraform Validation Workflow (tf-validate.yml):
   - Runs on every push and pull request.
   - Checks Terraform formatting, validates configuration, and runs yamllint on YAML files.
     
2. Terraform Deployment Workflow (tf-deploy.yml):
   - Triggers after the validation workflow completes successfully on the main branch.
   - Initializes, plans, and applies your Terraform configuration to deploy your infrastructure.

## Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS EKS Module for Terraform](https://github.com/terraform-aws-modules/terraform-aws-eks)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)


Let me know if you have any questions :]
