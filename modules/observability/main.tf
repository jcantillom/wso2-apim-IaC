resource "aws_cloudwatch_log_group" "ecs" {
  for_each = toset(var.service_names)

  name              = "/ecs/apim-${var.env}-${each.value}"
  retention_in_days = var.log_retention_in_days

  tags = {
    Name = "logs-apim-${var.env}-${each.value}"
    Env  = var.env
  }
}
