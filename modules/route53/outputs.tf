# 호스팅 영역 ID - ACM DNS 검증 레코드 및 A 레코드 생성 시 사용
output "zone_id" {
  description = "Route 53 호스팅 영역 ID"
  value       = data.aws_route53_zone.this.zone_id
}

# 네임서버 목록 - 도메인 등록기관에서 네임서버 설정 시 참조
output "name_servers" {
  description = "Route 53 호스팅 영역 네임서버 목록"
  value       = data.aws_route53_zone.this.name_servers
}
