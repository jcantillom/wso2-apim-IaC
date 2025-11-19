// modules/alb/main.tf

resource "aws_lb" "this" {
  name               = "apim-${var.env}-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.alb_subnets

  enable_deletion_protection = false

  tags = merge(
    var.tags,
    {
      Name = "apim-${var.env}-alb"
    }
  )
}

# Target Group para Gateway (HTTPS entre ALB y tareas ECS)
resource "aws_lb_target_group" "gateway" {
  name        = "apim-${var.env}-gw-tg"
  port        = var.gateway_target_port
  protocol    = "HTTPS"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    protocol            = "HTTPS"
    path                = var.gateway_healthcheck_path
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = merge(
    var.tags,
    {
      Name = "apim-${var.env}-gw-tg"
    }
  )
}

# Target Group para Console (HTTPS entre ALB y tareas ECS)
resource "aws_lb_target_group" "console" {
  name        = "apim-${var.env}-console-tg"
  port        = var.console_target_port
  protocol    = "HTTPS"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    protocol            = "HTTPS"
    path                = var.console_healthcheck_path
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = merge(
    var.tags,
    {
      Name = "apim-${var.env}-console-tg"
    }
  )
}

# Listener HTTPS 443 -> Console
resource "aws_lb_listener" "https_443" {
  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.console.arn
  }
}

# Listener HTTPS 8243 -> Gateway
resource "aws_lb_listener" "https_8243" {
  load_balancer_arn = aws_lb.this.arn
  port              = 8243
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.gateway.arn
  }
}
