output "log_group_names" {
  description = "Mapa de nombres de log groups por servicio"
  value       = { for k, lg in aws_cloudwatch_log_group.ecs : k => lg.name }
}

output "log_group_arns" {
  description = "Mapa de ARNs de log groups por servicio"
  value       = { for k, lg in aws_cloudwatch_log_group.ecs : k => lg.arn }
}
