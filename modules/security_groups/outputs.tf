output "alb_sg_id" {
  description = "ID del Security Group del ALB"
  value       = aws_security_group.alb.id
}

output "ecs_gateway_sg_id" {
  description = "ID del Security Group del servicio ECS Gateway"
  value       = aws_security_group.ecs_gateway.id
}

output "ecs_console_sg_id" {
  description = "ID del Security Group del servicio ECS Console"
  value       = aws_security_group.ecs_console.id
}
