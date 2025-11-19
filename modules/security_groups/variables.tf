variable "env" {
  description = "Nombre del ambiente (dev, qa, pdn) para nombrar SGs"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se crearán los Security Groups"
  type        = string
}

variable "allowed_cidrs_alb" {
  description = "CIDR(s) permitidos para acceder al ALB"
  type        = list(string)
}

variable "ecs_gateway_port" {
  description = "Puerto en el que el gateway WSO2 escucha dentro del container"
  type        = number
  default     = 8243
}

variable "ecs_console_port" {
  description = "Puerto en el que la consola WSO2 escucha dentro del container"
  type        = number
  default     = 9443
}

variable "alb_ingress_ports" {
  description = "Puertos a exponer en el ALB (HTTPS gateway/console)"
  type        = list(number)
  default     = [443, 8243]
}

variable "tags" {
  description = "Mapa de tags corporativas a aplicar en los SGs"
  type        = map(string)
  default     = {}
}
