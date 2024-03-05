output "target_group_arn" {
  value = aws_lb_target_group.public_tg.arn
}

output "load_balancer_dns_name" {
  value = aws_lb.public_alb.dns_name
}