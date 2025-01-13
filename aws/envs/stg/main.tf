module "vpc" {
  source                     = "../../modules/vpc"
  cidr_block                 = var.cidr_block
  environment                = var.environment
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  availability_zones         = var.availability_zones
}

module "security_group" {
  source       = "../../modules/security_group"
  environment  = var.environment
  service_name = var.service_name
  vpc_id = module.vpc.vpc_id  
}

module "alb" {
  source = "../../modules/alb"
  environment = var.environment
  service_name = var.service_name
  security_group_id = module.security_group.pub_alb_sg_id
  public_subnet_ids = module.vpc.public_subnet_ids 
  vpc_id = module.vpc.vpc_id
  acm_certificate_arn = var.acm_certificate_arn
}

module "route53" {
  source = "../../modules/route53"
  domain_name = var.domain_name
  api_subdomain_name = var.api_subdomain_name
  api_target_dns = module.alb.alb_dns_name
  api_target_zone_id = module.alb.alb_zone_id
}

module "ecs" {
  source             = "../../modules/ecs"
  environment        = var.environment
  service_name       = var.service_name
  task_cpu           = var.task_cpu
  task_memory        = var.task_memory
  container_image    = var.container_image
  container_cpu      = var.container_cpu
  container_memory   = var.container_memory
  desired_count      = var.desired_count
  private_subnet_ids = module.vpc.private_subnet_ids
  security_group_id  = module.security_group.ecs_sg_id
  alb_target_group_arn = module.alb.target_group_arn
}
