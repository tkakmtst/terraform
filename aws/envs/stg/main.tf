module "vpc" {
  source                     = "../../modules/vpc"
  cidr_block                 = var.cidr_block
  environment                = var.environment
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  availability_zones         = var.availability_zones
}
