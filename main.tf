module "vpc" {
  source      = "./modules/vpc"
  environment = var.environment
  owner       = var.owner
  cost_center = var.cost_center
  project     = var.project
}

module "sns" {
  source      = "./modules/sns"
  email       = var.email
  environment = var.environment
  owner       = var.owner
  cost_center = var.cost_center
  project     = var.project
}

module "secrets" {
  source      = "./modules/secrets"
  db_username = var.db_username
  environment = var.environment
  owner       = var.owner
  cost_center = var.cost_center
  project     = var.project
}

module "s3_bucket" {
  source      = "./modules/s3_bucket"
  environment = var.environment
  owner       = var.owner
  cost_center = var.cost_center
  project     = var.project
}

module "asg" {
  source      = "./modules/asg"
  environment = var.environment
  owner       = var.owner
  cost_center = var.cost_center
  project     = var.project
  subnet_ids  = module.vpc.subnet_ids
  vpc_id      = module.vpc.vpc_id
}

module "cloudwatch_alarm" {
  source        = "./modules/cloudwatch_alarm"
  environment   = var.environment
  owner         = var.owner
  cost_center   = var.cost_center
  project       = var.project
  asg_name      = module.asg.asg_name
  sns_topic_arn = module.sns.topic_arn
}

module "budget" {
  source        = "./modules/budget"
  budget_amount = var.budget_amount
  environment   = var.environment
  owner         = var.owner
  cost_center   = var.cost_center
  project       = var.project
  sns_topic_arn = module.sns.topic_arn
}

module "rds" {
  source        = "./modules/rds"
  db_username   = var.db_username
  environment   = var.environment
  owner         = var.owner
  cost_center   = var.cost_center
  project       = var.project
  db_secret_arn = module.secrets.db_secret_arn
  subnet_ids    = module.vpc.subnet_ids
  vpc_id        = module.vpc.vpc_id

  depends_on = [module.secrets]
}

module "iam" {
  source      = "./modules/iam"
  environment = var.environment
  owner       = var.owner
  cost_center = var.cost_center
  project     = var.project
}