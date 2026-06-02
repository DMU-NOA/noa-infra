# S3 모듈 - 프론트엔드 정적 파일 버킷
module "s3" {
  source = "./modules/s3"
  frontend_bucket_name = var.frontend_bucket_name
}