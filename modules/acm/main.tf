# ACM 인증서 - CloudFront HTTPS 연결을 위한 SSL/TLS 인증서
# CloudFront는 us-east-1 리전의 인증서만 연결 가능하므로 provider alias 사용
resource "aws_acm_certificate" "this" {
  provider = aws.us_east_1

  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
