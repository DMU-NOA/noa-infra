# RDS 서브넷 그룹
resource "aws_db_subnet_group" "this" {
  name       = "${var.app}-${var.env}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.app}-${var.env}-rds-subnet-group"
  }
}

# RDS 인스턴스 - MySQL 기반
resource "aws_db_instance" "this" {
  identifier        = local.prefix         # 인스턴스 식별자
  engine            = "mysql"              # 데이터베이스 엔진
  instance_class    = var.instance_type    # 인스턴스 사양
  allocated_storage = 20                   # 스토리지 용량 (GB)
  storage_type      = "gp2"               # 범용 SSD 스토리지 타입
  multi_az          = var.multi_az         # 가용 영역 배포 여부

  db_name  = var.app
  username = var.MYSQL_USER
  password = var.MYSQL_PASSWORD

  db_subnet_group_name   = aws_db_subnet_group.this.name  # 위에서 정의한 서브넷 그룹 연결
  vpc_security_group_ids = [aws_security_group.db.id]     # DB 전용 보안 그룹 연결

  skip_final_snapshot = true   # 인스턴스 삭제 시 최종 스냅샷 생략
  publicly_accessible = false  # 퍼블릭 인터넷 접근 차단

  tags = merge(
    local.tags, {
      Name = "${local.prefix}-${local.tags["tier"]}"
    }
  )
}

# DB 보안 그룹 - 애플리케이션 서버에서 DB 포트로의 인바운드만 허용
resource "aws_security_group" "db" {
  vpc_id = var.vpc_id

  name = "${local.prefix}-db-sg"

  # 인바운드 규칙 - 앱 서버 보안 그룹에서 DB 포트로의 접근만 허용
  ingress {
    from_port       = var.database_port
    to_port         = var.database_port
    protocol        = local.tcp_protocol
    security_groups = [var.app_security_group_id]  # 앱 서버 보안 그룹 ID 참조
  }

  tags = merge(
    local.tags, {
      Name = "${local.prefix}-db-sg"
    }
  )
}