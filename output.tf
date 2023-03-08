output "aws_lb_arn" {
  value = aws_lb.lb.arn
}
output "aws_lb_pub_dns" {
  value = aws_lb.lb.dns_name
}