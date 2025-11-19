resource "aws_ecr_repository" "this" {
  for_each = toset(var.repository_base_names)

  # Nombre final: <base>-<env>, por ejemplo: wso2-apim-gateway-dev
  name = "${each.value}-${var.env}"

  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${each.value}-${var.env}"
    Env  = var.env
  }
}
