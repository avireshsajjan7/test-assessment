output "test_user_name" {
  value = aws_iam_user.test_user.name
}

output "policy_arn" {
  value = aws_iam_policy.s3_tagged_access.arn
}