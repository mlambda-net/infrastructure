#the vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.vpc_name}-${var.env}"
  }
}

#internet gateway
resource "aws_internet_gateway" "wan" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "internet ${var.env}"
  }
}

#intranet gateway
#define a eip for nat gateway
resource "aws_eip" "lan_ip" {
  vpc = true
  tags = {
    Name = "nat public ip ${var.env}"
  }
}

resource "aws_nat_gateway" "lan" {
  allocation_id = aws_eip.lan_ip.id
  depends_on = [aws_internet_gateway.wan]
  subnet_id = aws_subnet.public_net.id
  tags = {
    Name = "intranet ${var.env}"
  }
}