variable "vpc_id" {
  description = "ID de la VPC donde se desplegará la aplicación"
  type        = string
}

variable "private_app_subnets" {
  description = "Subnets privadas para las tasks ECS"
  type        = list(string)
}

variable "alb_subnets" {
  description = "Subnets donde se ubicará el ALB interno"
  type        = list(string)
}
