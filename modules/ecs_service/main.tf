locals {
  use_service_discovery = var.enable_service_discovery
}

# =======================================
# SERVICE DISCOVERY (Cloud Map opcional)
# =======================================
resource "aws_service_discovery_service" "this" {
  count = local.use_service_discovery ? 1 : 0

  name = var.discovery_service_name != "" ? var.discovery_service_name : var.service_name

  dns_config {
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
      Env  = var.env
    }
  )
}

# =========================
# CLOUDWATCH LOG GROUP
# =========================
resource "aws_cloudwatch_log_group" "this" {
  name              = "${var.log_group_path_prefix}/${var.log_group_stream_prefix}"
  retention_in_days = 30

  tags = merge(
    var.tags,
    {
      Name = "logs-${var.service_name}-${var.env}"
      Env  = var.env
    }
  )
}

# =========================
# TASK DEFINITION (FARGATE)
# =========================
resource "aws_ecs_task_definition" "this" {
  family                   = "${var.service_name}-${var.env}"
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.image
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.this.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = var.log_group_stream_prefix
        }
      }
    }
  ])

  tags = merge(
    var.tags,
    {
      Name = "${var.service_name}-${var.env}-taskdef"
      Env  = var.env
    }
  )
}

# =========================
# ECS SERVICE (FARGATE)
# =========================
resource "aws_ecs_service" "this" {
  name            = var.service_name
  cluster         = var.cluster_name
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_group_ids
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  dynamic "service_registries" {
    for_each = local.use_service_discovery ? [1] : []
    content {
      registry_arn = aws_service_discovery_service.this[0].arn
      port         = var.container_port
    }
  }

  tags = merge(
    var.tags,
    {
      Name = var.service_name
      Env  = var.env
    }
  )

  lifecycle {
    ignore_changes = [desired_count]
  }
}
