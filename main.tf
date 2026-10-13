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

# Backend 모듈 - EC2 + ALB
module "backend" {
  source = "./modules/backend"

  app                   = var.app
  env                   = var.env
  ami                   = var.ami
  backend_instance_type = var.backend_instance_type
  backend_port          = var.backend_port
  user_data             = var.user_data
  certificate_arn       = var.alb_certificate_arn
  data_bucket_arn       = aws_s3_bucket.data.arn
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  private_subnet_ids    = module.vpc.private_subnet_ids
}

# Database 모듈 - RDS PostgreSQL (사용 안 함: Postgres를 Backend EC2에 직접 설치하는 걸로 변경)
# module "database" {
#   source = "./modules/database"
#
#   app                   = var.app
#   env                   = var.env
#   db_name               = var.db_name
#   database_port         = var.database_port
#   instance_type         = var.rds_instance_type
#   POSTGRES_USER         = var.postgres_user
#   POSTGRES_PASSWORD     = var.postgres_password
#   app_security_group_id = module.backend.app_security_group_id
#   vpc_id                = module.vpc.vpc_id
#   private_subnet_ids    = module.vpc.private_subnet_ids
# }

# ECR 모듈 - 백엔드 컨테이너 이미지 저장소
module "ecr" {
  source = "./modules/ecr"

  app = var.app
  env = var.env
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
  domain_name                 = var.domain_name
  certificate_arn             = var.cloudfront_certificate_arn
}