# 기존 Route 53 호스팅 영역 참조
# 도메인은 외부에서 이미 등록된 것을 사용하므로 data source로 조회
data "aws_route53_zone" "this" {
  name         = var.domain_name
  private_zone = false
}
