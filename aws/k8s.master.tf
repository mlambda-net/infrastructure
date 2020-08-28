
resource "aws_launch_configuration" "master" {
  name = "master-${var.env}"
  key_name = var.ssh_key_name
  image_id = var.image_id
  instance_type = var.instance_type
  associate_public_ip_address = false
  security_groups = [aws_security_group.private_ipsec.id]
  placement_tenancy = "default"
  user_data = file("${path.module}/provision/master_data.sh")
  root_block_device {
    volume_size = "20"
    volume_type = "gp2"
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "master_scaling" {
  name = "master_scaling_${var.env}"
  max_size = 2
  min_size = 1
  launch_configuration = aws_launch_configuration.master.name
  vpc_zone_identifier = [aws_subnet.private_net.id]
  health_check_type = "ELB"
  lifecycle {
    create_before_destroy = true
  }
}
