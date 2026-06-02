terraform {
  # Terraform 최소 버전 고정 - 하위 호환성 문제 방지
  required_version = ">= 1.0"

  required_providers {
    # AWS 프로바이더 버전 고정 - 마이너 업데이트 자동 허용, 메이저 변경 차단
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
