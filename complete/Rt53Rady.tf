
resource "aws_route53_record" "www" {
  zone_id = "Z08533508ZO3K7C0UQL8"
  name    = "www.casmcloud.com"
  type    = "A"
  alias {
    name                   = aws_lb.web-tier-lb.dns_name
    zone_id                = aws_lb.web-tier-lb.zone_id
    evaluate_target_health = true
  }
}