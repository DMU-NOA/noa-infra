resource "aws_ecr_repository" "this" {
  for_each = toset(["backend", "frontend"])

  name = "${local.prefix}-${each.key}"

  tags = {
    app     = var.app
    env     = var.env
    service = each.key
    managed = "terraform"
  }
}
