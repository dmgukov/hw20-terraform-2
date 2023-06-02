resource "aws_iam_role" "ssm_role" {
  count = var.create_ssm_role == "true" ? 1 : 0

  name = "ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "ec2-ssm-role"
  }
}

resource "aws_iam_role_policy_attachment" "ssm_role_policy_attachment" {
  count = var.create_ssm_role == "true" ? 1 : 0

  role       = aws_iam_role.ssm_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_role" {
  count = var.create_ssm_role == "true" ? 1 : 0

  name = "ec2-ssm-role"
  role = aws_iam_role.ssm_role[0].name
}