# ECR 리포지토리 - 백엔드 컨테이너 이미지 저장소 생성
resource "aws_ecr_repository" "backend" {
  name = "${var.app}-backend"

  tags = {
    app     = var.app     # 애플리케이션 이름
    env     = var.env     # 배포 환경
    service = "backend"   # 서비스 구분
    managed = "terraform" # 리소스 관리 도구
  }
}
