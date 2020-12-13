output "rds_instance_arn" {
  value = aws_db_instance.moodle.arn
}
output "rds_endoint" {
  value = aws_db_instance.moodle.endpoint
}
output "database_name" {
  value = aws_db_instance.moodle.name
}
output "db_password" {
  value = aws_db_instance.moodle.password
}
output "db_username" {
  value = aws_db_instance.moodle.username
}
