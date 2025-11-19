variable "env" {
  description = "Nombre del ambiente (dev, qa, pdn)"
  type        = string
}

variable "aws_region" {
  description = "Región de AWS"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegará WSO2 APIM"
  type        = string
}

variable "private_app_subnets" {
  description = "Subnets privadas para ECS (aplicación)"
  type        = list(string)
}

variable "alb_subnets" {
  description = "Subnets donde se colocará el ALB interno"
  type        = list(string)
}

variable "allowed_cidrs_alb" {
  description = "CIDR(s) permitidos para acceder al ALB (red corporativa/VPN)"
  type        = list(string)
}

variable "certificate_arn" {
  description = "ARN del certificado ACM que utilizará el ALB para HTTPS"
  type        = string
}

variable "console_image" {
  description = "Imagen del contenedor para la Console WSO2 (ECR URL + tag)"
  type        = string
}

variable "gateway_image" {
  description = "Imagen del contenedor para el Gateway WSO2 (ECR URL + tag)"
  type        = string
}

# === NUEVAS PARA ROUTE53 ===
variable "route53_zone_id" {
  description = "ID de la Hosted Zone de Route53 donde se creará el A record (ej: btgpactual.com.co)"
  type        = string
}

variable "route53_record_name" {
  description = "Nombre completo del registro A para el ALB (ej: apimdev.btgpactual.com.co)"
  type        = string
}
