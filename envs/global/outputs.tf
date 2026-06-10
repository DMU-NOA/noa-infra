output "alb_certificate_arn" {
  description = "dev/prod ALB에서 공유하는 ACM 인증서 ARN"
  value       = module.acm.alb_certificate_arn
}

output "cloudfront_certificate_arn" {
  description = "CloudFront에서 사용하는 ACM 인증서 ARN (us-east-1)"
  value       = module.acm.cloudfront_certificate_arn
}

output "domain_validation_options" {
  description = "가비아에 등록할 CNAME 레코드"
  value       = module.acm.domain_validation_options
}
