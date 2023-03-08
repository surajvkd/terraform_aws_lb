resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "my_vpc"
  }
}
resource "aws_subnet" "pub" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.0.0/25"
  map_public_ip_on_launch = true
  availability_zone = "ca-central-1b"
  tags = {
    Name = "public"
  }
}
resource "aws_subnet" "pub1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.0.128/25"
  map_public_ip_on_launch = true
  availability_zone = "ca-central-1a"
  tags = {
    Name = "public1"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "IGW"
  }
}
resource "aws_route_table" "pub" {
  vpc_id = aws_vpc.vpc1.id
}
resource "aws_route_table_association" "pub" {
  route_table_id = aws_route_table.pub.id
  subnet_id      = aws_subnet.pub.id
}
resource "aws_route" "pub" {
  route_table_id         = aws_route_table.pub.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}