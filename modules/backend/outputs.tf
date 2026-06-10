output "alb_dns_name" {
  description = "ALB DNS 이름"
  value       = aws_lb.this.dns_name
}

output "alb_security_group_id" {
  description = "ALB 보안그룹 ID"
  value       = aws_security_group.alb.id
}

output "app_instance_id" {
  description = "Backend EC2 인스턴스 ID"
  value       = aws_instance.app.id
}

output "app_security_group_id" {
  description = "Backend 보안그룹 ID"
  value       = aws_security_group.app.id
}
