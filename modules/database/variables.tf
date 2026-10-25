# -- common --
variable "app" {
  type = string
}

variable "env" {
  type = string
}

# -- RDS --
variable "database_port" {
  type = string
}

variable "db_name" {
  type        = string
  description = "RDS에 생성할 데이터베이스 이름"
}

variable "instance_type" {
  type = string
}

variable "POSTGRES_USER" {
  type = string
}

variable "POSTGRES_PASSWORD" {
  type      = string
  sensitive = true
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "app_security_group_id" {
  type = string
}

# -- VPC --
variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(any)
}