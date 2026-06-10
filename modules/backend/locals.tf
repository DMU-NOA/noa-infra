locals {
  tags = {
    app     = var.app
    env     = var.env
    managed = "terraform"
    tier    = "backend"
  }
  prefix       = "${var.app}-${var.env}"
  all_ips      = ["0.0.0.0/0"]
  all_protocol = "-1"
  tcp_protocol = "tcp"
}
