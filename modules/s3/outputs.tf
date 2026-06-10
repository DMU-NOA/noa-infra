# 버킷 ID - 다른 리소스(CloudFront OAC 등)에서 버킷을 참조할 때 사용
output "bucket_id" {
  description = "프론트엔드 S3 버킷 ID"
  value       = aws_s3_bucket.frontend.id
}

# 버킷 ARN - IAM 정책에서 버킷 접근 권한 부여 시 사용
output "bucket_arn" {
  description = "프론트엔드 S3 버킷 ARN"
  value       = aws_s3_bucket.frontend.arn
}

# 리전 도메인 - CloudFront 오리진 도메인으로 사용
output "bucket_regional_domain_name" {
  description = "프론트엔드 S3 버킷 리전 도메인명"
  value       = aws_s3_bucket.frontend.bucket_regional_domain_name
}
