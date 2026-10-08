variable "aws_region" {
  type    = string
  default = "ap-northeast-2"
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
}
