resource "aws_lb" "lb" {
  name               = "aws-lb"
  internal           = false
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg1.id]
  subnets            = [aws_subnet.pub.id, aws_subnet.pub1.id]
  tags = {
    name = "aws-lb"
  }
}
resource "aws_alb_target_group" "tg" {
  health_check {
    interval            = "10"
    path                = "/"
    protocol            = "HTTP"
    timeout             = "5"
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
  }
  name        = "tg"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.vpc1.id
}
resource "aws_alb_listener" "listner" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.tg.arn
    type             = "forward"
  }
}
resource "aws_lb_target_group_attachment" "tg-attach" {
  target_group_arn = aws_alb_target_group.tg.arn
  target_id        = aws_instance.pub1.id
}
resource "aws_lb_target_group_attachment" "tg-attach1" {
  target_group_arn = aws_alb_target_group.tg.arn
  target_id        = aws_instance.pub2.id
}