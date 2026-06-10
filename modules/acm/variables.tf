variable "app" {
  type        = string
  description = "애플리케이션 이름"
}

variable "domain_name" {
  type        = string
  description = "ACM 인증서에 등록할 루트 도메인명"
}

variable "subject_alternative_names" {
  type        = list(string)
  description = "SAN에 추가할 도메인 목록"
  default     = []
}
