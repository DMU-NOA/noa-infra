provider "aws" {
  region = "ap-northeast-2"
}

# CloudFront ACM 인증서는 반드시 us-east-1에서 생성해야 한다
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
