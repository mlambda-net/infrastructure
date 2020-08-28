
resource "aws_subnet" "public_net" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.vpc_public_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "public subnet ${var.env}"
  }
}

# Routing table for public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wan.id
  }
}

# Assign the route table to public subnet.
resource "aws_route_table_association" "public_subnet_table" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.public_net.id
}