variable "project_name" {}


variable "vpc_cidr" {}

variable "public_subnets" {
  type = string
}

variable "private_subnets" {
  type = string
}

variable "availability_zones" {
  type = string
}