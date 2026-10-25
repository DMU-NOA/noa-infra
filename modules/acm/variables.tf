variable "alb_domain_name" {
  type        = string
  description = "ALB(백엔드 API)용 도메인 (CloudFront와 분리)"
}

variable "app" {
  type        = string
  description = "애플리케이션 이름"
}

variable "domain_name" {
  type        = string
  description = "CloudFront(프론트엔드)용 루트 도메인명"
}

variable "subject_alternative_names" {
  type        = list(string)
  description = "SAN에 추가할 도메인 목록"
  default     = []
}
