# S3 모듈 - 프론트엔드 정적 파일 버킷
module "s3" {
  source = "./modules/s3"
  frontend_bucket_name = var.frontend_bucket_name
}

module "monitoring" {
  source = "./modules/monitoring"

  app            = "noa"
  env            = "dev"
  alert_email    = "dummy@example.com"
  rds_identifier = "dummy-db"

  instance_ids = {
    frontend = "i-00000000000000001"
    app      = "i-00000000000000002"
    ai       = "i-00000000000000003"
  }

  ec2_role_names = {
    frontend = "dummy-frontend-role"
    app      = "dummy-app-role"
    ai       = "dummy-ai-role"
  }

  gc_prom_url  = var.gc_prom_url
  gc_prom_user = var.gc_prom_user
  gc_loki_url  = var.gc_loki_url
  gc_loki_user = var.gc_loki_user
  app_log_dir  = "/var/log/noa"
}