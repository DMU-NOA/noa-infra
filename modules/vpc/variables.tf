variable "app" {
  type        = string
  description = "애플리케이션 이름"
}

variable "azs" {
  type        = list(string)
  description = "사용할 가용 영역 목록"
}

variable "env" {
  type        = string
  description = "배포 환경 (dev, prod)"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private 서브넷 CIDR 목록"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public 서브넷 CIDR 목록"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR 블록"
}
