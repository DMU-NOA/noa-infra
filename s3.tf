resource "aws_s3_bucket" "frontend" {
  bucket = var.frontend_bucket_name
}

# 버킷 퍼블릭 액세스 차단
resource "aws_s3_bucket_public_access_block" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  block_public_acls       = true # 퍼블릭 ACL 설정 차단
  block_public_policy     = true # 퍼블릭 버킷 정책 차단
  ignore_public_acls      = true # 기존 퍼블릭 ACL 무시
  restrict_public_buckets = true # 퍼블릭 버킷 접근 제한
}
