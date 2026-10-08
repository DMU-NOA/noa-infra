# SNS 토픽 ARN 출력 - 타 모듈에서 알림 토픽 참조 시 사용
output "sns_topic_arn" {
  value = aws_sns_topic.alerts.arn
}