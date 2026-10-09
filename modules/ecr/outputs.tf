# ECR 리포지토리 URL - 백엔드 이미지를 push/pull할 주소
output "repository_url" {
  value = aws_ecr_repository.backend.repository_url
}
