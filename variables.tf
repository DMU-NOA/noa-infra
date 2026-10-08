variable "app" {
  type        = string
  description = "애플리케이션 이름"
}

variable "aws_region" {
  type    = string
  default = "ap-northeast-2"
}

variable "env" {
  type        = string
  description = "배포 환경 (dev, prod)"
}

variable "frontend_bucket_name" {
  type = string
}
