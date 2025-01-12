variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "environment" {
  description = "The environment name (e.g. stg, prd)"
  type        = string
}

resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.environment}-vpc"
  }
}
