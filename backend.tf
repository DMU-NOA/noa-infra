# 현재는 혼자 작업 중이라 로컬 state를 사용한다.
# 협업이 시작되면 아래 backend "s3" 블록 주석을 해제하고
# `terraform init -migrate-state`로 원격 state로 전환한다.
#
# terraform {
#   backend "s3" {
#     bucket = "noa-terraform-state"       # tfstate 파일을 저장할 S3 버킷명
#     key    = "noa/terraform.tfstate"     # 버킷 내 저장 경로 (프로젝트별로 구분)
#     region = "ap-northeast-2"            # 백엔드 버킷 리전 (변수 사용 불가 - 하드코딩 필수)
#
#     dynamodb_table = "noa-terraform-lock" # 상태 잠금용 DynamoDB 테이블명
#     encrypt        = true                 # S3 서버 측 암호화 활성화
#   }
# }
