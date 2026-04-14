output "s3_bucket_name" {
  value = module.s3_bucket.bucket_name
}

output "rds_endpoint" {
  value = module.rds.endpoint
}

output "asg_name" {
  value = module.asg.asg_name
}