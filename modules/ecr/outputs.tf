# ECR 리포지토리 URL 맵 - 서비스명을 키로, 리포지토리 URL을 값으로 반환
output "repository_urls" {
  value = { for k, v in aws_ecr_repository.this : k => v.repository_url }
}
