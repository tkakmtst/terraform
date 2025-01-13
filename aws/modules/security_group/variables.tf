variable "environment" {
  description = "The environment name (e.g. stg, prd)"
  type        = string
}

variable "service_name" {
  description = "Name of the application"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the ALB service"
  type        = string
}
