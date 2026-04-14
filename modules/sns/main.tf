resource "aws_sns_topic" "this" {
  name = "${var.owner}-${var.project}-${var.environment}-sns"

  tags = {
    Environment = var.environment
    Owner       = var.owner
    CostCenter  = var.cost_center
  }
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = var.email
}