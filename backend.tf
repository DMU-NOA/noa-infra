terraform {
  # S3 원격 상태 저장소 설정
  # tfstate를 S3에 보관하여 팀 협업 시 상태 충돌 방지
  # DynamoDB로 상태 잠금을 걸어 동시 apply 충돌 방지
  backend "s3" {
    bucket = "noa-terraform-state"       # tfstate 파일을 저장할 S3 버킷명
    key    = "noa/terraform.tfstate"     # 버킷 내 저장 경로 (프로젝트별로 구분)
    region = "ap-northeast-2"            # 백엔드 버킷 리전 (변수 사용 불가 - 하드코딩 필수)

    dynamodb_table = "noa-terraform-lock" # 상태 잠금용 DynamoDB 테이블명
    encrypt        = true                 # S3 서버 측 암호화 활성화
  }
}
