output "service_name" {
  description = "Nombre del servicio ECS"
  value       = aws_ecs_service.this.name
}

output "service_arn" {
  description = "ARN del servicio ECS"
  value       = aws_ecs_service.this.arn
}

output "task_definition_arn" {
  description = "ARN de la task definition"
  value       = aws_ecs_task_definition.this.arn
}

output "log_group_name" {
  description = "Nombre del log group de CloudWatch"
  value       = aws_cloudwatch_log_group.this.name
}

output "service_discovery_name" {
  description = "Nombre del servicio en Cloud Map (si está habilitado)"
  value = (
    local.use_service_discovery && length(aws_service_discovery_service.this) > 0
    ? aws_service_discovery_service.this[0].name
    : null
  )
}
