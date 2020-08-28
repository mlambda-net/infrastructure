
resource "aws_route53_record" "vault_domain" {
  zone_id = aws_route53_zone.local.zone_id
  name = "vault"
  type = "A"
  ttl = 300
  records = [aws_instance.vault.private_ip]
}

resource "aws_instance" "vault" {
  ami = var.image_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.private_net.id
  vpc_security_group_ids = [aws_security_group.private_ipsec.id]
  user_data = file("${path.module}/provision/master_data.sh")
  key_name = var.ssh_key_name

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 10
  }

  tags = {
    Name = "vault-${var.env}"
  }
}

