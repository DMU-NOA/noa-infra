# ECR 리포지토리 - backend, frontend 서비스별 컨테이너 이미지 저장소 생성
resource "aws_ecr_repository" "this" {
  for_each = toset(["backend", "frontend"])  # 2개 서비스에 대해 각각 리포지토리 생성

  name = "${local.prefix}-${each.key}"

  tags = {
    app     = var.app     # 애플리케이션 이름
    env     = var.env     # 배포 환경
    service = each.key    # 서비스 구분 (backend / frontend)
    managed = "terraform" # 리소스 관리 도구
  }
}