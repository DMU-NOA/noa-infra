output "cloudfront_distribution_domain_name" {
  description = "CloudFront 배포 도메인명 (브라우저로 접속할 기본 주소)"
  value       = module.cloudfront.distribution_domain_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront 배포 ID"
  value       = module.cloudfront.distribution_id
}

output "frontend_bucket_arn" {
  description = "프론트엔드 정적 파일 S3 버킷 ARN"
  value       = module.s3.bucket_arn
}

output "frontend_bucket_id" {
  description = "프론트엔드 정적 파일 S3 버킷 ID (업로드 시 사용)"
  value       = module.s3.bucket_id
}

output "private_subnet_ids" {
  description = "Private 서브넷 ID 목록"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  description = "Public 서브넷 ID 목록"
  value       = module.vpc.public_subnet_ids
}

output "sandbox_instance_id" {
  description = "DevOps 테스트용 EC2 인스턴스 ID (aws ssm start-session --target 에 사용)"
  value       = aws_instance.sandbox.id
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

# ======================================================
# 예정 output 목록 (모듈 구현 완료 시 순차적으로 추가)
# ======================================================

# ACM
# output "acm_certificate_arn" — CloudFront 연결용 ACM 인증서 ARN (us-east-1)

# Route53
# output "route53_zone_id" — 도메인 호스팅 존 ID
