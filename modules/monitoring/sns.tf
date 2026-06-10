# SNS 알림 토픽 - CloudWatch 알람 발생 시 알림을 수신할 토픽 생성
resource "aws_sns_topic" "alerts" {
  name = "${var.app}-${var.env}-alerts"
  tags = {
    app     = var.app
    env     = var.env
    managed = "terraform"
  }
}

# SNS 이메일 구독 - 알림 토픽을 이메일로 수신하도록 구독 설정
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn  # 위에서 생성한 알림 토픽 참조
  protocol  = "email"                   # 이메일 프로토콜로 수신
  endpoint  = var.alert_email           # 알림 수신 이메일 주소
}

# SNS 토픽 정책 - CloudWatch 알람이 SNS 토픽에 메시지를 publish할 수 있도록 허용
resource "aws_sns_topic_policy" "alerts" {
  arn = aws_sns_topic.alerts.arn  # 정책을 적용할 SNS 토픽 ARN

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudWatchAlarms"          # 정책 식별자
        Effect = "Allow"
        Principal = {
          Service = "cloudwatch.amazonaws.com"    # CloudWatch 서비스에 권한 부여
        }
        Action   = "SNS:Publish"                  # SNS 메시지 발행 권한
        Resource = aws_sns_topic.alerts.arn       # 대상 SNS 토픽 ARN
      }
    ]
  })
}