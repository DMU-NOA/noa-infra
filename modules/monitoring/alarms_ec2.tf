# 모니터링 대상 EC2 인스턴스 맵 - 서비스명을 키로, 인스턴스 ID를 값으로 정의
locals {
  instances = {
    frontend = var.instance_ids.frontend  # 프론트엔드 서버 인스턴스 ID
    app      = var.instance_ids.app       # 백엔드 앱 서버 인스턴스 ID
  }
}

# EC2 CPU 사용률 알람 - 각 인스턴스의 CPU가 임계값 초과 시 SNS 알림 발송
resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
  for_each = local.instances  # frontend, app 각각에 대해 알람 생성

  alarm_name          = "${var.app}-${var.env}-${each.key}-cpu-high"
  alarm_description   = "${each.key} EC2 CPU 사용률 ${var.cpu_threshold}% 초과"
  metric_name         = "CPUUtilization"  # CPU 사용률 메트릭
  namespace           = "AWS/EC2"
  statistic           = "Average"         # 5분 평균값 기준
  period              = 300               # 측정 주기 (초) - 5분
  evaluation_periods  = 2                 # 연속 2회 초과 시 알람 발동
  threshold           = var.cpu_threshold # CPU 사용률 임계값 (%)
  comparison_operator = "GreaterThanThreshold"

  dimensions = {
    InstanceId = each.value  # 각 서비스의 인스턴스 ID 지정
  }

  alarm_actions = [aws_sns_topic.alerts.arn]  # 알람 발생 시 SNS 토픽으로 알림
  ok_actions    = [aws_sns_topic.alerts.arn]  # 알람 해제 시 SNS 토픽으로 알림

  tags = {
    app     = var.app
    env     = var.env
    managed = "terraform"
  }
}

# EC2 인스턴스 상태 체크 알람 - 인스턴스 또는 시스템 상태 이상 감지 시 SNS 알림 발송
resource "aws_cloudwatch_metric_alarm" "ec2_status" {
  for_each = local.instances  # frontend, app 각각에 대해 알람 생성

  alarm_name          = "${var.app}-${var.env}-${each.key}-status-failed"
  alarm_description   = "${each.key} EC2 인스턴스 상태 이상"
  metric_name         = "StatusCheckFailed"  # 인스턴스/시스템 상태 체크 메트릭
  namespace           = "AWS/EC2"
  statistic           = "Maximum"            # 측정 주기 내 최댓값 기준
  period              = 60                   # 측정 주기 (초) - 1분
  evaluation_periods  = 2                    # 연속 2회 실패 시 알람 발동
  threshold           = 1                    # 상태 체크 실패 횟수 임계값
  comparison_operator = "GreaterThanOrEqualToThreshold"

  dimensions = {
    InstanceId = each.value  # 각 서비스의 인스턴스 ID 지정
  }

  alarm_actions = [aws_sns_topic.alerts.arn]  # 알람 발생 시 SNS 토픽으로 알림
  ok_actions    = [aws_sns_topic.alerts.arn]  # 알람 해제 시 SNS 토픽으로 알림

  tags = {
    app     = var.app
    env     = var.env
    managed = "terraform"
  }
}