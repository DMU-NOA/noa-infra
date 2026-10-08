# VPC 모듈 - Public/Private 서브넷, NAT Gateway
module "vpc" {
  source = "./modules/vpc"

  app                  = var.app
  env                  = var.env
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
}

# S3 모듈 - 프론트엔드 정적 파일 버킷
module "s3" {
  source               = "./modules/s3"
  frontend_bucket_name = var.frontend_bucket_name
}

# CloudFront 모듈 - S3를 오리진으로 하는 CDN 배포
# 커스텀 도메인 미지정 시 CloudFront 기본 도메인(*.cloudfront.net) 사용
module "cloudfront" {
  source = "./modules/cloudfront"

  app                         = var.app
  env                         = var.env
  bucket_id                   = module.s3.bucket_id
  bucket_arn                  = module.s3.bucket_arn
  bucket_regional_domain_name = module.s3.bucket_regional_domain_name
}