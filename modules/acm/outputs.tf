output "cloudfront_certificate_arn" {
  description = "CloudFront용 ACM 인증서 ARN (us-east-1)"
  value       = aws_acm_certificate.cloudfront.arn
}

output "alb_certificate_arn" {
  description = "ALB용 ACM 인증서 ARN (배포 리전)"
  value       = aws_acm_certificate.alb.arn
}

output "domain_validation_options" {
  description = "DNS 검증용 CNAME 레코드 목록"
  value       = aws_acm_certificate.alb.domain_validation_options
}
