data "aws_caller_identity" "current" {}

# SSM 토큰 읽기 권한을 기존 Role에 추가
resource "aws_iam_policy" "read_gc_token" {
  name = "${var.app}-${var.env}-read-grafana-token"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["ssm:GetParameter"]
      Resource = "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter${var.gc_token_param_name}"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "read_gc_token" {
  for_each   = var.ec2_role_names
  role       = each.value
  policy_arn = aws_iam_policy.read_gc_token.arn
}

# 2) Alloy 설치/설정용 SSM Command 문서
locals {
  alloy_scripts = {
    for name, id in local.instances : name => templatefile("${path.module}/templates/install_alloy.sh.tftpl", {
      region      = var.region
      token_param = var.gc_token_param_name
      prom_url    = var.gc_prom_url
      prom_user   = var.gc_prom_user
      loki_url    = var.gc_loki_url
      loki_user   = var.gc_loki_user
      app_log_dir = var.app_log_dir
      config_alloy = templatefile("${path.module}/templates/config.alloy.tftpl", {
        service          = name
        env              = var.env
        scrape_app       = name == "app" # app 서버만 /metrics 수집
        app_metrics_port = var.app_metrics_port
        app_metrics_path = var.app_metrics_path
        app_log_dir      = var.app_log_dir
      })
    })
  }
}

resource "aws_ssm_document" "install_alloy" {
  for_each      = local.alloy_scripts
  name          = "${var.app}-${var.env}-${each.key}-install-alloy"
  document_type = "Command"

  content = jsonencode({
    schemaVersion = "2.2"
    description   = "Install and configure Grafana Alloy"
    mainSteps = [{
      action = "aws:runShellScript"
      name   = "installAlloy"
      inputs = { runCommand = split("\n", each.value) }
    }]
  })
}

# 인스턴스에 적용
resource "aws_ssm_association" "install_alloy" {
  for_each = local.instances
  name     = aws_ssm_document.install_alloy[each.key].name

  targets {
    key    = "InstanceIds"
    values = [each.value]
  }

  depends_on = [aws_iam_role_policy_attachment.read_gc_token]
}