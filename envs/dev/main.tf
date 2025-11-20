locals {
  project = "apim"

  base_tags = {
    Ambiente       = var.env
    Despliegue     = "Terraform"
    Celula         = "Automation"
    Aplicativo     = "apim"
    Compania       = "Transversal"
    Producto       = "Transversal"
    Area           = "TECHNOLOGY"
  }
}

# =========================
# NETWORKING (VPC, subnets ya existentes)
# =========================
module "networking" {
  source              = "../../modules/networking"
  vpc_id              = var.vpc_id
  private_app_subnets = var.private_app_subnets
  alb_subnets         = var.alb_subnets


}

# =========================
# SECURITY GROUPS
# =========================
module "security_groups" {
  source            = "../../modules/security_groups"
  env               = var.env
  vpc_id            = module.networking.vpc_id
  allowed_cidrs_alb = var.allowed_cidrs_alb

}

# =========================
# ALB INTERNO + LISTENERS + TARGET GROUPS
# =========================
module "alb" {
  source = "../../modules/alb"

  env                      = var.env
  vpc_id                   = module.networking.vpc_id
  alb_subnets              = module.networking.alb_subnets
  alb_sg_id                = module.security_groups.alb_sg_id
  certificate_arn          = var.certificate_arn
  gateway_target_port      = 8243
  console_target_port      = 9443
  gateway_healthcheck_path = "/"
  console_healthcheck_path = "/"

}

# =========================
# ECS CLUSTER
# =========================
module "ecs_cluster" {
  source = "../../modules/ecs_cluster"
  env    = var.env
  name   = "apim-${var.env}-cluster"

  tags = local.base_tags
}

# =========================
# ECS SERVICES (Gateway & Console)
# =========================
module "ecs_service_gateway" {
  source                  = "../../modules/ecs_service"
  env                     = var.env
  cluster_name            = module.ecs_cluster.cluster_name
  service_name            = "apim-gateway-${var.env}-svc"
  container_name          = "apim-gateway"
  image                   = var.gateway_image
  cpu                     = 1024
  memory                  = 2048
  desired_count           = 1
  subnets                 = module.networking.private_app_subnets
  security_group_ids      = [module.security_groups.ecs_gateway_sg_id]
  container_port          = 8243
  target_group_arn        = module.alb.tg_gateway_arn
  execution_role_arn      = module.ecs_cluster.execution_role_arn
  log_group_path_prefix   = "/ecs/apim/${var.env}"
  log_group_stream_prefix = "gateway"

  aws_region    = var.aws_region
  task_role_arn = module.ecs_cluster.task_role_arn
  # Service Discovery (Cloud Map)
  enable_service_discovery  = true
  namespace_id              = module.service_discovery.namespace_id
  discovery_service_name    = "gateway"
  discovery_dns_record_type = "A"
  discovery_ttl             = 10
}


module "ecs_service_console" {
  source                  = "../../modules/ecs_service"
  env                     = var.env
  cluster_name            = module.ecs_cluster.cluster_name
  service_name            = "apim-console-${var.env}-svc"
  container_name          = "apim-console"
  image                   = var.console_image
  cpu                     = 1024
  memory                  = 2048
  desired_count           = 1
  subnets                 = module.networking.private_app_subnets
  security_group_ids      = [module.security_groups.ecs_console_sg_id]
  container_port          = 9443
  target_group_arn        = module.alb.tg_console_arn
  execution_role_arn      = module.ecs_cluster.execution_role_arn
  log_group_path_prefix   = "/ecs/apim/${var.env}"
  log_group_stream_prefix = "console"

  aws_region    = var.aws_region
  task_role_arn = module.ecs_cluster.task_role_arn

  # Service Discovery (Cloud Map)
  enable_service_discovery  = true
  namespace_id              = module.service_discovery.namespace_id
  discovery_service_name    = "console"
  discovery_dns_record_type = "A"
  discovery_ttl             = 10
}


# =========================
# DNS PÚBLICO / FQDN APIM
# =========================
module "route53_apim" {
  source          = "../../modules/route53"
  env             = var.env
  route53_zone_id = var.route53_zone_id
  record_name     = var.route53_record_name
  alb_dns_name    = module.alb.alb_dns_name
  alb_zone_id     = module.alb.alb_zone_id
}


# =========================
# SERVICE DISCOVERY NAMESPACE (Cloud Map)
# =========================
module "service_discovery" {
  source  = "../../modules/service_discovery"
  env     = var.env
  project = "apim"
  vpc_id  = var.vpc_id
}
