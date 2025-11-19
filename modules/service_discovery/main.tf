locals {
  namespace_name = var.env == "pdn" ? "${var.project}.io" : "${var.env}.${var.project}.io"
}

resource "aws_service_discovery_private_dns_namespace" "this" {
  name        = local.namespace_name
  description = "Private DNS namespace for ${var.project} (${var.env})"
  vpc         = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "sdns-${var.project}-${var.env}"
    }
  )
}
