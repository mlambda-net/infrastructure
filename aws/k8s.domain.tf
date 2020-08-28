
resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = "admin@mlambda.net"
}

resource "acme_certificate" "certificate" {
  account_key_pem           = acme_registration.reg.account_key_pem
  common_name               = "portal-${var.env}.mlambda.net"

  dns_challenge {
    provider = "route53"
  }
}

resource "aws_iam_server_certificate" "portal_cert" {
  name_prefix       = "portal-cert-${var.env}"
  certificate_body  =  acme_certificate.certificate.certificate_pem
  private_key       = acme_certificate.certificate.private_key_pem

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "portal_record" {
  name = acme_certificate.certificate.certificate_domain
  type = "A"
  zone_id = data.aws_route53_zone.domain.zone_id
  alias {
    evaluate_target_health = true
    name = aws_elb.portal_balancer.dns_name
    zone_id = aws_elb.portal_balancer.zone_id
  }
}
