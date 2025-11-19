output "namespace_id" {
  description = "ID del namespace de Cloud Map"
  value       = aws_service_discovery_private_dns_namespace.this.id
}

output "namespace_arn" {
  description = "ARN del namespace de Cloud Map"
  value       = aws_service_discovery_private_dns_namespace.this.arn
}

output "namespace_name" {
  description = "Nombre DNS del namespace (ej: dev.apim.io)"
  value       = aws_service_discovery_private_dns_namespace.this.name
}
