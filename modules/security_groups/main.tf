resource "aws_security_group" "alb" {
  name        = "apim-alb-${var.env}"
  description = "Security Group para ALB interno de WSO2 APIM (${var.env})"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.alb_ingress_ports
    content {
      description = "ALB port ${ingress.value} from corporate network"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.allowed_cidrs_alb
    }
  }

  egress {
    description = "Salida a cualquier destino"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    { Name = "apim-alb-${var.env}-sg" }
  )
}

resource "aws_security_group" "ecs_gateway" {
  name        = "apim-ecs-gateway-${var.env}"
  description = "Security Group para ECS Fargate Gateway WSO2 APIM (${var.env})"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Traffic from ALB to Gateway"
    from_port       = var.ecs_gateway_port
    to_port         = var.ecs_gateway_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Salida a cualquier destino (DBs, servicios internos, etc.)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    { Name = "apim-ecs-gateway-${var.env}-sg" }
  )
}

resource "aws_security_group" "ecs_console" {
  name        = "apim-ecs-console-${var.env}"
  description = "Security Group para ECS Fargate Console WSO2 APIM (${var.env})"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Traffic from ALB to Console"
    from_port       = var.ecs_console_port
    to_port         = var.ecs_console_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Salida a cualquier destino (DBs, servicios internos, etc.)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    { Name = "apim-ecs-console-${var.env}-sg" }
  )
}
