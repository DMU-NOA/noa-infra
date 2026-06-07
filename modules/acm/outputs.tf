# 인증서 ARN - CloudFront 배포 시 viewer_certificate에 연결
output "certificate_arn" {
  description = "ACM 인증서 ARN"
  value       = aws_acm_certificate.this.arn
}
