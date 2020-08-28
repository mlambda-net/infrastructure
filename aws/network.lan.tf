
resource "aws_subnet" "private_net" {
  cidr_block = var.vpc_private_cidr
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "private subnet ${var.env}"
  }
}

# Routing table for private subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.lan.id
  }
}

# Assign the the route table as main table.
resource "aws_main_route_table_association" "main_route" {
  route_table_id = aws_route_table.private_route_table.id
  vpc_id = aws_vpc.vpc.id
}
