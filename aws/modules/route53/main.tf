# The Host Zone is already created.

data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "api" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.api_subdomain_name
  type    = "A"

  alias {
    name                   = var.api_target_dns
    zone_id                = var.api_target_zone_id
    evaluate_target_health = true
  }
}

