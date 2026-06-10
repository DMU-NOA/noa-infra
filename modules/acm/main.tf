# CloudFront용 인증서 - us-east-1 고정 (CloudFront 요구사항)
resource "aws_acm_certificate" "cloudfront" {
  provider = aws.us_east_1

  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name    = var.domain_name
    app     = var.app
    managed = "terraform"
  }
}

# ALB용 인증서 - 배포 리전
resource "aws_acm_certificate" "alb" {
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name    = var.domain_name
    app     = var.app
    managed = "terraform"
  }
}
