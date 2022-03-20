output "s3_bucket" {
  description = "value of the s3_bucket"
  value       = aws_s3_bucket.s3_bucket.id
}

output "dynamodb_table" {
  description = "value of the dynamodb_table"
  value       = aws_dynamodb_table.terraform_state_lock.id
}
