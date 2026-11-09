output "instance_profile_arn" {
  description = "Instance profile ARNs, keyed by name."
  value       = { for k, v in aws_iam_instance_profile.instance_profile : k => v.arn }
}
