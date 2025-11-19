data "aws_vpc" "this" {
  id = var.vpc_id
}

data "aws_subnet" "private_app" {
  for_each = toset(var.private_app_subnets)
  id       = each.value
}

data "aws_subnet" "alb" {
  for_each = toset(var.alb_subnets)
  id       = each.value
}
