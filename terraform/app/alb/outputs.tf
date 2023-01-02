output "alb_security_group_id" {
  description = "Repository url of the books app"
  value       = aws_security_group.main.id
}

output "alb_target_group_arn" {
  description = "Alb target group arn"
  value       = aws_lb_target_group.main.arn
}
