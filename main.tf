terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  region = var.aws_region
}

# CloudFront ACM 인증서용 provider
# CloudFront는 ACM 인증서를 반드시 us-east-1에서 생성해야 연결 가능함
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

# S3 모듈 - 프론트엔드 정적 파일 버킷
module "s3" {
  source = "./modules/s3"
  frontend_bucket_name = var.frontend_bucket_name
}