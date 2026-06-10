# -- ALB Security Group
resource "aws_security_group" "alb" {
  vpc_id = var.vpc_id
  name   = "${local.prefix}-alb-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = local.tcp_protocol
    cidr_blocks = local.all_ips
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = local.tcp_protocol
    cidr_blocks = local.all_ips
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = local.all_protocol
    cidr_blocks = local.all_ips
  }

  tags = merge(local.tags, { Name = "${local.prefix}-alb-sg" })
}

# -- Backend Security Group
resource "aws_security_group" "app" {
  vpc_id = var.vpc_id
  name   = "${local.prefix}-app-sg"

  ingress {
    from_port       = var.backend_port
    to_port         = var.backend_port
    protocol        = local.tcp_protocol
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = local.all_protocol
    cidr_blocks = local.all_ips
  }

  tags = merge(local.tags, { Name = "${local.prefix}-app-sg" })
}

# -- Backend Instance (Private Subnet)
resource "aws_instance" "app" {
  ami                  = var.ami
  instance_type        = var.backend_instance_type
  subnet_id            = var.private_subnet_ids[0]
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm.name
  user_data            = var.user_data

  vpc_security_group_ids = [aws_security_group.app.id]
  tags = merge(local.tags, { Name = "${local.prefix}-app" })
}
