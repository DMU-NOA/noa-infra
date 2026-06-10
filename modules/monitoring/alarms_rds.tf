# RDS CPU 사용률 알람 - CPU가 임계값 초과 시 SNS 알림 발송
resource "aws_cloudwatch_metric_alarm" "rds_cpu" {
  alarm_name          = "${var.app}-${var.env}-rds-cpu-high"
  alarm_description   = "RDS CPU 사용률 ${var.cpu_threshold}% 초과"
  metric_name         = "CPUUtilization"  # CPU 사용률 메트릭
  namespace           = "AWS/RDS"
  statistic           = "Average"         # 5분 평균값 기준
  period              = 300               # 측정 주기 (초) - 5분
  evaluation_periods  = 2                 # 연속 2회 초과 시 알람 발동
  threshold           = var.cpu_threshold # CPU 사용률 임계값 (%)
  comparison_operator = "GreaterThanThreshold"

  dimensions = {
    DBInstanceIdentifier = var.rds_identifier  # 모니터링 대상 RDS 인스턴스 지정
  }

  alarm_actions = [aws_sns_topic.alerts.arn]  # 알람 발생 시 SNS 토픽으로 알림
  ok_actions    = [aws_sns_topic.alerts.arn]  # 알람 해제 시 SNS 토픽으로 알림

  tags = {
    app     = var.app
    env     = var.env
    managed = "terraform"
  }
}

# RDS 스토리지 부족 알람 - 남은 스토리지가 임계값 미만으로 떨어질 시 SNS 알림 발송
resource "aws_cloudwatch_metric_alarm" "rds_free_storage" {
  alarm_name          = "${var.app}-${var.env}-rds-storage-low"
  alarm_description   = "RDS 남은 스토리지 부족"
  metric_name         = "FreeStorageSpace"          # 남은 스토리지 용량 메트릭 (Bytes)
  namespace           = "AWS/RDS"
  statistic           = "Average"                   # 5분 평균값 기준
  period              = 300                          # 측정 주기 (초) - 5분
  evaluation_periods  = 1                            # 1회 감지 즉시 알람 발동
  threshold           = var.rds_free_storage_threshold  # 남은 스토리지 임계값 (Bytes)
  comparison_operator = "LessThanThreshold"          # 임계값 미만일 때 알람 발동

  dimensions = {
    DBInstanceIdentifier = var.rds_identifier  # 모니터링 대상 RDS 인스턴스 지정
  }

  alarm_actions = [aws_sns_topic.alerts.arn]  # 알람 발생 시 SNS 토픽으로 알림
  ok_actions    = [aws_sns_topic.alerts.arn]  # 알람 해제 시 SNS 토픽으로 알림

  tags = {
    app     = var.app
    env     = var.env
    managed = "terraform"
  }
}

# RDS 연결 수 알람 - DB 연결 수가 임계값 초과 시 SNS 알림 발송
resource "aws_cloudwatch_metric_alarm" "rds_connections" {
  alarm_name          = "${var.app}-${var.env}-rds-connections-high"
  alarm_description   = "RDS DB 연결 수 ${var.rds_connections_threshold} 초과"
  metric_name         = "DatabaseConnections"          # 현재 DB 연결 수 메트릭
  namespace           = "AWS/RDS"
  statistic           = "Average"                      # 5분 평균값 기준
  period              = 300                             # 측정 주기 (초) - 5분
  evaluation_periods  = 2                               # 연속 2회 초과 시 알람 발동
  threshold           = var.rds_connections_threshold   # DB 연결 수 임계값
  comparison_operator = "GreaterThanThreshold"

  dimensions = {
    DBInstanceIdentifier = var.rds_identifier  # 모니터링 대상 RDS 인스턴스 지정
  }

  alarm_actions = [aws_sns_topic.alerts.arn]  # 알람 발생 시 SNS 토픽으로 알림
  ok_actions    = [aws_sns_topic.alerts.arn]  # 알람 해제 시 SNS 토픽으로 알림

  tags = {
    app     = var.app
    env     = var.env
    managed = "terraform"
  }
}