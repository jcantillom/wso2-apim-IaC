output "alb_arn" {
  description = "ARN del Application Load Balancer"
  value       = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "DNS del ALB interno"
  value       = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "Zone ID del ALB (para alias en Route53)"
  value       = aws_lb.this.zone_id
}

output "tg_gateway_arn" {
  description = "ARN del Target Group del Gateway"
  value       = aws_lb_target_group.gateway.arn
}

output "tg_console_arn" {
  description = "ARN del Target Group de la Console"
  value       = aws_lb_target_group.console.arn
}

output "listener_443_arn" {
  description = "ARN del listener HTTPS 443"
  value       = aws_lb_listener.https_443.arn
}

output "listener_8243_arn" {
  description = "ARN del listener HTTPS 8243"
  value       = aws_lb_listener.https_8243.arn
}
