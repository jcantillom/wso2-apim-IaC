variable "env" {
  description = "Ambiente (dev, qa, pdn)"
  type        = string
}

variable "project" {
  description = "Nombre corto del proyecto/aplicativo (ej: apim)"
  type        = string
}

variable "vpc_id" {
  description = "VPC donde se creará el namespace privado"
  type        = string
}

variable "tags" {
  description = "Tags comunes para el namespace"
  type        = map(string)
  default     = {}
}
