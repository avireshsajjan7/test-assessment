resource "random_password" "db" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret" "db" {
  name = "${var.owner}-${var.project}-${var.environment}-db-secret"

  tags = {
    Environment = var.environment
    Owner       = var.owner
    CostCenter  = var.cost_center
  }
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db.result
  })
}