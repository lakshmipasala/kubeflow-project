terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
module "vpc" {
  source = "./modules/vpc"
  availability_zones = var.availability_zones
  vpc_cidr = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  project_name = var.project_name
}
module "vpc" {
  source = "./modules/eks"
}