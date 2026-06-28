output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.kubeflow_vpc.id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "Private subnet ID"
  value       = aws_subnet.private.id
}
output "private_subnet_id_1" {
  description = "Private subnet ID"
  value       = aws_subnet.private_1.id
}