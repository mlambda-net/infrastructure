data "aws_route53_zone" "domain" {
  name = var.domain_name
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}