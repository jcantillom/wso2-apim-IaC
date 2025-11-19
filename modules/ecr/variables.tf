variable "env" {
  description = "Nombre del ambiente (dev, qa, pdn) para nombrar repositorios"
  type        = string
}

variable "repository_base_names" {
  description = "Lista de nombres base de repositorios ECR (sin sufijo de ambiente)"
  type        = list(string)
}
