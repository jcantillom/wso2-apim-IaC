output "vpc_id" {
  description = "ID de la VPC usada para el despliegue"
  value       = data.aws_vpc.this.id
}

output "vpc_cidr_block" {
  description = "CIDR block de la VPC"
  value       = data.aws_vpc.this.cidr_block
}

output "private_app_subnets" {
  description = "Listado de subnets privadas para ECS"
  value       = [for s in data.aws_subnet.private_app : s.id]
}

output "alb_subnets" {
  description = "Listado de subnets donde se ubica el ALB"
  value       = [for s in data.aws_subnet.alb : s.id]
}

output "private_app_subnet_azs" {
  description = "AZs de las subnets privadas de aplicación"
  value       = [for s in data.aws_subnet.private_app : s.availability_zone]
}
