output "role_arn" {
  description = "Role ARNs, keyed by role name."
  value       = { for k, v in aws_iam_role.role : k => v.arn }
}
