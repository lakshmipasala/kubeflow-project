variable "project_name" {}

variable "environment" {}

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
variable "private_subnet1" {
  type = string
}