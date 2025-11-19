output "cluster_name" {
  description = "Nombre del cluster ECS"
  value       = aws_ecs_cluster.this.name
}

output "cluster_arn" {
  description = "ARN del cluster ECS"
  value       = aws_ecs_cluster.this.arn
}

output "execution_role_arn" {
  description = "ARN del rol de ejecución de tareas ECS"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "task_role_arn" {
  description = "ARN del rol de la tarea ECS"
  value       = aws_iam_role.ecs_task_role.arn
}
