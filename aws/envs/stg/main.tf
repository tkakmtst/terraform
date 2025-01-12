module "vpc" {
  source      = "../../modules/vpc"
  cidr_block  = var.cidr_block
  environment = var.environment
}
