# 공통 태그 정의 - 모든 리소스에 적용되는 메타데이터 태그
locals {
  tags = {
    app     = var.app       # 애플리케이션 이름
    managed = "terraform"   # 리소스 관리 도구
    env     = var.env       # 배포 환경
    tier    = "database"    # 아키텍처 계층
  }

  # 리소스 이름 접두사
  prefix      = "${var.app}-${var.env}"

  # DB 도메인 이름
  domain_name = "db.%{if var.env != "prod"}${var.env}.%{endif}${var.domain}"

  # 네트워크 접근 범위
  all_ips      = ["0.0.0.0/0"]  # 모든 IP 허용 (IPv4 전체 대역)
  all_protocol = "-1"            # 모든 프로토콜 허용 (AWS 보안 그룹 규칙용)
  tcp_protocol = "tcp"           # TCP 프로토콜 지정자
}