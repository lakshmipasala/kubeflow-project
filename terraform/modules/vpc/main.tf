resource "aws_vpc" "kubeflow_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "kubeflow_internet_gateway" {
  vpc_id = aws_vpc.kubeflow_vpc.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.kubeflow_vpc.id
  cidr_block = var.public_subnets
  availability_zone = var.availability_zones
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.kubeflow_vpc.id
  cidr_block = var.private_subnets
  availability_zone = var.availability_zones
  tags = {
    Name = "private-subnet"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id = aws_vpc.kubeflow_vpc.id
  cidr_block = var.private_subnet1
  availability_zone = "us-east-1b"
  tags = {
    Name = "private-subnet-1"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public.id

  depends_on = [

    aws_internet_gateway.kubeflow_internet_gateway

  ]

}
resource "aws_route_table" "public" {

  vpc_id = aws_vpc.kubeflow_vpc.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.kubeflow_internet_gateway.id

  }

}
resource "aws_route_table" "private" {

  vpc_id = aws_vpc.kubeflow_vpc.id

  route {

    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.nat_gateway.id

  }
}
resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private.id

}
