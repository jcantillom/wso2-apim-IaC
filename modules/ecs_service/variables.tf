variable "env" {
  description = "Ambiente (dev, qa, pdn)"
  type        = string
}

variable "cluster_name" {
  description = "Nombre del cluster ECS donde se desplegará el servicio"
  type        = string
}

variable "service_name" {
  description = "Nombre del servicio ECS"
  type        = string
}

variable "container_name" {
  description = "Nombre del contenedor dentro de la task definition"
  type        = string
}

variable "image" {
  description = "Imagen del contenedor (ECR URL + tag)"
  type        = string
}

variable "cpu" {
  description = "CPU (en unidades de Fargate, ej: 256, 512, 1024)"
  type        = number
}

variable "memory" {
  description = "Memoria en MiB (ej: 512, 1024, 2048)"
  type        = number
}

variable "desired_count" {
  description = "Cantidad deseada de tareas ECS"
  type        = number
  default     = 1
}

variable "subnets" {
  description = "Subnets donde se desplegarán las tareas Fargate"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Lista de Security Groups a asociar a las tareas"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Si se asigna IP pública a las tareas (en tu caso, false)"
  type        = bool
  default     = false
}

variable "container_port" {
  description = "Puerto en el que el contenedor escucha (ej: 8243, 9443)"
  type        = number
}

variable "target_group_arn" {
  description = "ARN del Target Group al que se asociará el servicio"
  type        = string
}

variable "health_check_grace_period_seconds" {
  description = "Tiempo de gracia para health checks del ALB"
  type        = number
  default     = 60
}

variable "execution_role_arn" {
  description = "ARN del rol de ejecución de tareas ECS (ecsTaskExecutionRole)"
  type        = string
}

variable "log_group_path_prefix" {
  description = "Prefijo del log group (ej: /ecs/apim/dev)"
  type        = string
}

variable "log_group_stream_prefix" {
  description = "Stream prefix para logs (ej: gateway, console)"
  type        = string
}

variable "tags" {
  description = "Mapa de tags comunes a aplicar a los recursos ECS"
  type        = map(string)
  default     = {}
}

# ==============================
# SERVICE DISCOVERY (Cloud Map)
# ==============================

variable "enable_service_discovery" {
  description = "Si se habilita o no el registro en Cloud Map"
  type        = bool
  default     = false
}

variable "discovery_service_name" {
  description = "Nombre del servicio en Cloud Map (por defecto usa service_name)"
  type        = string
  default     = ""
}

variable "discovery_dns_record_type" {
  description = "Tipo de registro DNS en Cloud Map (A o SRV)"
  type        = string
  default     = "A"
}

variable "discovery_ttl" {
  description = "TTL de los registros DNS de Cloud Map"
  type        = number
  default     = 10
}

variable "namespace_id" {
  description = "ID del namespace de Cloud Map (ej: de module.service_discovery.namespace_id)"
  type        = string
  default     = ""

  validation {
    condition     = !(var.enable_service_discovery && var.namespace_id == "")
    error_message = "Si enable_service_discovery = true, debes pasar un namespace_id válido."
  }
}

# ==============================
# EXTRAS NUEVOS
# ==============================

variable "aws_region" {
  description = "Región de AWS (para CloudWatch Logs)"
  type        = string
}

variable "task_role_arn" {
  description = "ARN del rol de la tarea ECS (permisos de la app)"
  type        = string
}
