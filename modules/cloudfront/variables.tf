variable "app" {
  type        = string
  description = "애플리케이션 이름"
}

variable "bucket_arn" {
  type        = string
  description = "프론트엔드 S3 버킷 ARN"
}

variable "bucket_id" {
  type        = string
  description = "프론트엔드 S3 버킷 ID"
}

variable "bucket_regional_domain_name" {
  type        = string
  description = "프론트엔드 S3 버킷 리전 도메인명"
}

variable "certificate_arn" {
  type        = string
  description = "CloudFront HTTPS용 ACM 인증서 ARN (us-east-1). domain_name 미지정 시 사용 안 함"
  default     = null
}

variable "domain_name" {
  type        = string
  description = "CloudFront 배포에 연결할 커스텀 도메인. 미지정 시 CloudFront 기본 도메인(*.cloudfront.net)과 기본 인증서를 사용"
  default     = null
}

variable "env" {
  type        = string
  description = "배포 환경 (dev, prod)"
}

variable "price_class" {
  type        = string
  description = "CloudFront 엣지 로케이션 범위 (PriceClass_100 / PriceClass_200 / PriceClass_All)"
  default     = "PriceClass_200"
}
