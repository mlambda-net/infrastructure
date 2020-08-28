

resource "aws_route53_record" "vpn_domain" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name = "vpn-${var.env}"
  type = "A"
  ttl = 300
  records = [aws_instance.vpn.public_ip]

}

resource "aws_instance" "vpn" {
  ami = var.image_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.public_net.id
  vpc_security_group_ids = [
    #aws_security_group.private_ipsec.id,
    aws_security_group.public_ipsec.id
  ]
  user_data = file("${path.module}/provision/master_data.sh")

  key_name = var.ssh_key_name
  associate_public_ip_address = true

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 10
  }

  tags = {
    Name = "vpn-${var.env}"
  }
}

resource "aws_network_interface" "public_vpn_interface" {
  subnet_id = aws_subnet.public_net.id
  security_groups = [aws_security_group.public_ipsec.id]
  attachment {
    device_index = 1
    instance = aws_instance.vpn.id
  }
  tags = {
    Name = "public_vpn_interface_${var.env}"
  }
}
