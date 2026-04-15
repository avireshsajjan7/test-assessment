resource "aws_iam_user" "test_user" {
  name = "${var.owner}-${var.project}-${var.environment}-test-user"

  tags = {
    Environment = var.environment
    Owner       = var.owner
    CostCenter  = var.cost_center
  }
}

resource "aws_iam_policy" "s3_tagged_access" {
  name = "${var.owner}-${var.project}-${var.environment}-s3-tagged-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:ResourceTag/Environment" = var.environment
            "aws:ResourceTag/Owner"       = var.owner
          }
        }
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeImages",
          "rds:DescribeDBInstances"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:ResourceTag/Environment" = var.environment
            "aws:ResourceTag/Owner"       = var.owner
          }
        }
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attach" {
  user       = aws_iam_user.test_user.name
  policy_arn = aws_iam_policy.s3_tagged_access.arn
}