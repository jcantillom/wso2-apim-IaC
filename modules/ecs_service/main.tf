locals {
  # Ahora solo depende de un booleano conocido en plan
  use_service_discovery = var.enable_service_discovery
}

resource "aws_service_discovery_service" "this" {
  count = local.use_service_discovery ? 1 : 0

  name = var.discovery_service_name != "" ? var.discovery_service_name : var.service_name

  dns_config {
    # Este namespace_id puede ser "known after apply" sin problema
    namespace_id = var.namespace_id

    dns_records {
      ttl  = var.discovery_ttl
      type = var.discovery_dns_record_type
    }

    routing_policy = "WEIGHTED"
  }

  tags = merge(
    var.tags,
    {
      Name = "sd-${var.service_name}-${var.env}"
    }
  )
}
