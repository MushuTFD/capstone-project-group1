resource "aws_route53_zone" "primary" {
  name = "sctp-sandbox.com"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "sctp-sandbox.com"
  type    = "A"

  alias {
    name                   = "${var.alb_dns_name}"
    zone_id                = "${var.zone_id}"
    evaluate_target_health = true
  }
}