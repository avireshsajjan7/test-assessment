variable "region" {
  default = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "test"
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
  default     = "testuser"
}

variable "cost_center" {
  description = "Cost center"
  type        = string
  default     = "test"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "assessment"
}

variable "db_username" {
  description = "Username for RDS"
  type        = string
  default     = "dbadmin"
}

variable "budget_amount" {
  description = "Budget amount in USD"
  type        = number
  default     = 50
}

variable "email" {
  description = "Email for notifications"
  type        = string
}