variable "aws_region" {
  description = "Region de AWS"
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Nombre del cluster EKS"
  default     = "portfolio-eks-cluster"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}
