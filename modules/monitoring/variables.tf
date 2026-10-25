variable "app" {
  type = string
}

variable "env" {
  type = string
}

variable "alert_email" {
  type        = string
  description = "SNS 알림 수신 이메일"
}

variable "instance_ids" {
  type = object({
    frontend = string
    app      = string
    ai       = string
  })
  description = "EC2 인스턴스 ID 맵"
}

variable "rds_identifier" {
  type        = string
  description = "RDS 인스턴스 식별자"
}

variable "cpu_threshold" {
  type        = number
  default     = 80
  description = "CPU 사용률 알림 임계값 (%)"
}

variable "rds_free_storage_threshold" {
  type        = number
  default     = 2147483648 # 2GB
  description = "RDS 남은 스토리지 알림 임계값 (bytes)"
}

variable "rds_connections_threshold" {
  type        = number
  default     = 100
  description = "RDS DB 연결 수 알림 임계값"
}

variable "gc_prom_url"  { type = string }
variable "gc_prom_user" { type = string }
variable "gc_loki_url"  { type = string }
variable "gc_loki_user" { type = string }

variable "gc_token_param_name" {
  type        = string
  default     = "/monitoring/grafana-cloud-token"
  description = "Grafana Cloud 토큰이 저장된 SSM 파라미터 이름"
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
}

variable "ec2_role_names" {
  type        = map(string)
  description = "인스턴스별 IAM Role 이름 (SSM 토큰 읽기 정책을 붙일 대상)"
}

variable "region" {
  type    = string
  default = "ap-northeast-2"
}