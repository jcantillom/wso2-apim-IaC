variable "env" {
  description = "Nombre del ambiente (dev, qa, pdn) para nombrar el cluster ECS y roles"
  type        = string
}

variable "name" {
  description = "Nombre explícito del cluster ECS. Si se omite, se usará apim-<env>-cluster"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Mapa de tags corporativas a aplicar a todos los recursos del módulo"
  type        = map(string)
  default     = {}
}
