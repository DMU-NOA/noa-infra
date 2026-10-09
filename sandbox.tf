# - 테스트용 인스턴스


data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# -- IAM Role: SSM Session Manager 접속용
resource "aws_iam_role" "sandbox_ssm" {
  name = "${var.app}-sandbox-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })

  tags = { app = var.app, managed = "terraform", purpose = "sandbox" }
}

resource "aws_iam_role_policy_attachment" "sandbox_ssm" {
  role       = aws_iam_role.sandbox_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "sandbox_ecr_read" {
  role       = aws_iam_role.sandbox_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_instance_profile" "sandbox_ssm" {
  name = "${var.app}-sandbox-ssm-profile"
  role = aws_iam_role.sandbox_ssm.name
}

# -- Security Group
resource "aws_security_group" "sandbox" {
  vpc_id = data.aws_vpc.default.id
  name   = "${var.app}-sandbox-sg"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { app = var.app, managed = "terraform", purpose = "sandbox" }
}

# -- EC2 인스턴스
resource "aws_instance" "sandbox" {
  ami                  = "ami-06e9e3574a0459db2"
  instance_type        = "t3.small"
  subnet_id            = data.aws_subnets.default.ids[0]
  iam_instance_profile = aws_iam_instance_profile.sandbox_ssm.name

  vpc_security_group_ids = [aws_security_group.sandbox.id]

  tags = { Name = "${var.app}-sandbox", app = var.app, managed = "terraform", purpose = "sandbox" }
}
