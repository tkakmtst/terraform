variable "domain_name" {
  description = "The domain name of the existing Route 53 Hosted Zone"
  type        = string
}

variable "api_subdomain_name" {
  description = "The subdomain for the API (e.g., api.example.com)"
  type        = string
}

variable "api_target_dns" {
  description = "The DNS name of the API Gateway or ALB"
  type        = string
}

variable "api_target_zone_id" {
  description = "The Hosted Zone ID of the API Gateway or ALB"
  type        = string
}
