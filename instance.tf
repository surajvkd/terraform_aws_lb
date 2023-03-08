resource "aws_instance" "pub1" {
  ami             = "ami-04604153c1ddc4880"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.pub.id
  security_groups = [aws_security_group.sg1.id]
  key_name        = "canada"
  user_data       = file("userdata1.sh")
  tags = {
    Name = "lbser1"
  }
}
resource "aws_instance" "pub2" {
  ami             = "ami-04604153c1ddc4880"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.pub1.id
  security_groups = [aws_security_group.sg1.id]
  key_name        = "canada"
  user_data       = file("userdata1.sh")
  tags = {
    Name = "lbser2"
  }
}
#nothing
