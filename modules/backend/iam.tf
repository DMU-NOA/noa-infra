# -- IAM Role
resource "aws_iam_role" "ec2_ssm" {
  name = "${local.prefix}-ec2-ssm-role"

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

  tags = merge(local.tags, { Name = "${local.prefix}-ec2-ssm-role" })
}

# -- Policy Attachment
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ecr_read" {
  role       = aws_iam_role.ec2_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# -- 데이터 버킷 읽기 권한 (초기 데이터 .sql 다운로드용)
resource "aws_iam_role_policy" "data_bucket_read" {
  name = "${local.prefix}-data-bucket-read"
  role = aws_iam_role.ec2_ssm.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject"]
        Resource = "${var.data_bucket_arn}/*"
      },
      {
        Effect   = "Allow"
        Action   = ["s3:ListBucket"]
        Resource = var.data_bucket_arn
      }
    ]
  })
}

# -- Instance Profile
resource "aws_iam_instance_profile" "ec2_ssm" {
  name = "${local.prefix}-ec2-ssm-profile"
  role = aws_iam_role.ec2_ssm.name
}
