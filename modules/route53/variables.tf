variable "env" {
  description = "Ambiente (dev, qa, pdn), solo para trazabilidad"
  type        = string
}

variable "route53_zone_id" {
  description = "ID de la Hosted Zone donde se creará el registro"
  type        = string
}

variable "record_name" {
  description = "Nombre completo del registro A (FQDN)"
  type        = string
}

variable "alb_dns_name" {
  description = "DNS Name del ALB (output del módulo alb)"
  type        = string
}

variable "alb_zone_id" {
  description = "Hosted Zone ID del ALB (output del módulo alb)"
  type        = string
}
