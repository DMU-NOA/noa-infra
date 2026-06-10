# RDS 인스턴스 엔드포인트 주소 - 애플리케이션에서 DB 연결 시 사용하는 호스트명
output "host" {
  value = aws_db_instance.this.address
}

# RDS 인스턴스 고유 식별자 - 콘솔 조회 및 타 모듈에서 참조 시 사용
output "identifier" {
  value = aws_db_instance.this.identifier
}