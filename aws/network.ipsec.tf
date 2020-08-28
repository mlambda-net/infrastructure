
# public ipsec
resource "aws_security_group" "public_ipsec" {
  name = "public_ipsec"
  description = "public subnet ip security"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-${var.env}-ipsec"
  }
}



# private ipsec
resource "aws_security_group" "private_ipsec" {
  name = "private_ipsec"
  description = "private subnet ipsec"
  vpc_id = aws_vpc.vpc.id

  # allow mysql port within VPC.
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [
      aws_subnet.public_net.cidr_block]
  }

  # allow http port connections.
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      aws_subnet.public_net.cidr_block]
  }

  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = {
    Name = "private-${var.env}-ipsec"
  }
}
