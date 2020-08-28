resource "aws_elb" "portal_balancer" {
  name = "portal"
  security_groups = [aws_security_group.master_ipsec.id]
  subnets = [aws_subnet.public_net.id, aws_subnet.private_net.id]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 443
    lb_protocol = "https"
    ssl_certificate_id = aws_iam_server_certificate.portal_cert.arn
  }

  tags = {
    Name = "portal_k8s_elb_${var.env}"
  }
}
