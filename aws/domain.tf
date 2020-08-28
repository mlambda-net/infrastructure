data "aws_route53_zone" "domain" {
  name = var.domain_name
}

resource "aws_route53_zone" "local" {
  name = "${var.env}.${var.private_domain}"
  vpc {
    vpc_id = aws_vpc.vpc.id
  }
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}