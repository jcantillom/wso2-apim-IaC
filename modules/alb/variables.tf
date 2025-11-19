// modules/alb/variables.tf
variable "env" {
  description = "Nombre del ambiente (dev, qa, pdn) para nombrar recursos"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se creará el ALB y los Target Groups"
  type        = string
}

variable "alb_subnets" {
  description = "Subnets donde se ubicará el ALB interno"
  type        = list(string)
}

variable "alb_sg_id" {
  description = "Security Group ID a asociar al ALB"
  type        = string
}

variable "certificate_arn" {
  description = "ARN del certificado ACM para listeners HTTPS"
  type        = string
}

variable "gateway_target_port" {
  description = "Puerto donde escucha el Gateway WSO2 en el container"
  type        = number
  default     = 8243
}

variable "console_target_port" {
  description = "Puerto donde escucha la Console WSO2 en el container"
  type        = number
  default     = 9443
}

variable "gateway_healthcheck_path" {
  description = "Path para healthcheck del Gateway"
  type        = string
  default     = "/"
}

variable "console_healthcheck_path" {
  description = "Path para healthcheck de la Console"
  type        = string
  default     = "/"
}

variable "tags" {
  description = "Mapa de tags corporativas a aplicar en los recursos del ALB"
  type        = map(string)
  default     = {}
}
