variable "env" {
  description = "Nombre del ambiente (dev, qa, pdn)"
  type        = string
}

variable "service_names" {
  description = "Listado de servicios ECS para los que se crearán log groups"
  type        = list(string)
}

variable "log_retention_in_days" {
  description = "Días de retención de logs en CloudWatch"
  type        = number
  default     = 30
}
