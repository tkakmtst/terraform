variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "service_name" {
  description = "Name of the application"
  type        = string
}

variable "task_cpu" {
  description = "CPU units for the ECS task"
  type        = number
}

variable "task_memory" {
  description = "Memory (MiB) for the ECS task"
  type        = number
}

variable "container_image" {
  description = "Docker image for the container"
  type        = string
}

variable "container_cpu" {
  description = "CPU units for the container"
  type        = number
  default     = 256
}

variable "container_memory" {
  description = "Memory (MiB) for the container"
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Number of desired tasks for the ECS service"
  type        = number
  default     = 1
}

variable "domain_name" {
  description = "The domain name of the existing Route 53 Hosted Zone"
  type        = string
}

variable "api_subdomain_name" {
  description = "The subdomain for the API (e.g., api.example.com)"
  type        = string
}

variable "acm_certificate_arn" {
  description = "The ACM certificate Arn"
  type        = string
}
