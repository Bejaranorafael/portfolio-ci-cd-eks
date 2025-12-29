terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Configura el bucket S3 real y la clave para tu estado remoto
  # backend "s3" {
  #   bucket = "tu-nombre-de-bucket-s3"
  #   key    = "tf-state/terraform.tfstate"
  #   region = "us-east-1"
  # }
}

provider "aws" {
  region = var.aws_region
}

# Modulo de VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "portfolio-vpc"
  cidr = var.vpc_cidr

  public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  enable_nat_gateway = true
  single_nat_gateway = true
}

# Modulo de EKS
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name    = var.cluster_name
  vpc_id  = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
  kubernetes_version = "1.28"

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    general = {
      instance_types = ["t3.medium"]
      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }
}
