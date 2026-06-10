# -- common
variable "app" {
  type        = string
  description = "애플리케이션 이름"
}

variable "env" {
  type        = string
  description = "배포 환경 (dev, prod)"
}

# -- ec2
variable "ami" {
  type        = string
  description = "EC2 AMI ID"
}

variable "backend_instance_type" {
  type        = string
  description = "Backend EC2 인스턴스 타입"
}

variable "backend_port" {
  type        = number
  description = "Backend 애플리케이션 포트"
}

variable "user_data" {
  type        = string
  description = "EC2 User Data 스크립트"
}

# -- vpc
variable "certificate_arn" {
  type        = string
  description = "HTTPS 리스너에 사용할 ACM 인증서 ARN"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Backend EC2를 배치할 Private 서브넷 ID 목록"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "ALB를 배치할 Public 서브넷 ID 목록"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}
