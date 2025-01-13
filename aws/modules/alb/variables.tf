variable "environment" {
  description = "The environment name (e.g. stg, prd)"
  type        = string
}

variable "service_name" {
  description = "Name of the application"
  type        = string
}

variable "security_group_id" {
  description = "security group for the ALB service"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of subnet ids for the ALB service"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for the ALB service"
  type        = string
}
