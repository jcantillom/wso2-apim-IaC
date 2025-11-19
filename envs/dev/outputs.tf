output "vpc_id" {
  description = "ID de la VPC usada para este ambiente"
  value       = module.networking.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block de la VPC"
  value       = module.networking.vpc_cidr_block
}

output "app_subnets" {
  description = "Subnets privadas usadas para ECS (aplicación)"
  value       = module.networking.private_app_subnets
}

output "alb_subnets" {
  description = "Subnets donde se ubica el ALB interno"
  value       = module.networking.alb_subnets
}

output "alb_dns_name" {
  description = "DNS del ALB interno"
  value       = module.alb.alb_dns_name
}

output "alb_zone_id" {
  description = "Zone ID del ALB (para alias en Route53)"
  value       = module.alb.alb_zone_id
}

output "ecs_cluster_name" {
  description = "Nombre del cluster ECS para APIM"
  value       = module.ecs_cluster.cluster_name
}

output "ecs_cluster_arn" {
  description = "ARN del cluster ECS para APIM"
  value       = module.ecs_cluster.cluster_arn
}

# output "ecs_gateway_service_arn" {
#   description = "ARN del servicio ECS del Gateway"
#   value       = module.ecs_service_gateway.service_arn
# }
#
# output "ecs_console_service_arn" {
#   description = "ARN del servicio ECS de la Console"
#   value       = module.ecs_service_console.service_arn
# }

# output "logs_gateway" {
#   description = "Log group de CloudWatch para el Gateway"
#   value       = module.ecs_service_gateway.log_group_name
# }
#
# output "logs_console" {
#   description = "Log group de CloudWatch para la Console"
#   value       = module.ecs_service_console.log_group_name
# }
