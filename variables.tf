variable "alb_certificate_arn" {
  type        = string
  description = "ALB HTTPS용 ACM 인증서 ARN (api 서브도메인, envs/global에서 발급한 값)"
}

variable "ami" {
  type        = string
  description = "Backend EC2에 쓸 AMI ID (검증된 값을 직접 고정, 필터로 동적 조회하지 않음)"
}

variable "app" {
  type        = string
  description = "애플리케이션 이름"
}

variable "aws_region" {
  type    = string
  default = "ap-northeast-2"
}

variable "azs" {
  type        = list(string)
  description = "사용할 가용 영역 목록"
}

variable "backend_instance_type" {
  type        = string
  description = "Backend EC2 인스턴스 타입"
}

variable "backend_port" {
  type        = number
  description = "Backend 애플리케이션 포트"
}

variable "balance_port" {
  type        = number
  description = "밸런스 게임 애플리케이션 포트 (같은 인스턴스의 별도 프로세스)"
}

variable "cloudfront_certificate_arn" {
  type        = string
  description = "CloudFront HTTPS용 ACM 인증서 ARN (us-east-1, envs/global에서 발급한 값)"
  default     = null
}

variable "data_bucket_name" {
  type        = string
  description = "데이터 파이프라인 초기 데이터(.sql 등) 저장용 S3 버킷명"
}

# RDS 사용 안 함(Postgres를 Backend EC2에 직접 설치)으로 주석 처리. 나중에 다시 쓸 수 있어 남겨둠.
# variable "database_port" {
#   type        = string
#   description = "RDS 포트"
# }

# variable "db_name" {
#   type        = string
#   description = "RDS에 생성할 데이터베이스 이름"
# }

variable "domain_name" {
  type        = string
  description = "CloudFront에 연결할 커스텀 도메인"
  default     = null
}

variable "env" {
  type        = string
  description = "배포 환경 (dev, prod)"
}

variable "frontend_bucket_name" {
  type = string
}

#IAM Role 이름
variable "ec2_role_names" {
  type = map(string)
}

variable "gc_prom_url"  { type = string }
variable "gc_prom_user" { type = string }
variable "gc_loki_url"  { type = string }
variable "gc_loki_user" { type = string }

# SSM 파라미터 이름
variable "gc_token_param_name" {
  type    = string
  default = "/monitoring/grafana-cloud-token"
}

variable "app_metrics_port" {
  type    = number
  default = 8080
}

variable "app_metrics_path" {
  type    = string
  default = "/metrics"
}

variable "app_log_dir" {
  type    = string
  default = "/var/log/app"
# variable "postgres_password" {
#   type        = string
#   description = "RDS PostgreSQL 비밀번호"
#   sensitive   = true
# }

# variable "postgres_user" {
#   type        = string
#   description = "RDS PostgreSQL 사용자명"
# }

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private 서브넷 CIDR 목록"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public 서브넷 CIDR 목록"
}

# variable "rds_instance_type" {
#   type        = string
#   description = "RDS 인스턴스 타입"
# }

variable "user_data" {
  type        = string
  description = "Backend EC2 User Data 스크립트"
  default     = ""
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR 블록"
}
