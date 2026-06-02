# 기본 AWS 프로바이더 - 서비스 배포 리전
# 리전은 변수로 관리하여 환경별 유연하게 적용
provider "aws" {
  region = var.aws_region
}

# CloudFront ACM 인증서용 프로바이더
# CloudFront는 ACM 인증서를 반드시 us-east-1에서 생성해야 연결 가능함
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
