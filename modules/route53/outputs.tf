output "alb_record_fqdn" {
  description = "FQDN creado en Route53 apuntando al ALB"
  value       = aws_route53_record.alb_alias.fqdn
}
