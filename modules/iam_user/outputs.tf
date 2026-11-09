output "user_names" {
  description = "User names."
  value       = { for k, v in aws_iam_user.iam_user : k => v.name }
}
