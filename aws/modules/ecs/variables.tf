variable "environment" {
  description = "The environment name (e.g. stg, prd)"
  type        = string
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
}

variable "container_memory" {
  description = "Memory (MiB) for the container"
  type        = number
}

variable "desired_count" {
  description = "Number of desired tasks for the ECS service"
  type        = number
}

variable "private_subnet_ids" {
  description = "List of subnets for the ECS service"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group id for the ECS service"
  type        = string
}

variable "alb_target_group_arn" {
  description = "ALB target gruop arn for the ECS service"
  type        = string
}
