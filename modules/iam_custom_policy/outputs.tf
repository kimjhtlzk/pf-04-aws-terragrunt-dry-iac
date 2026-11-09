output "policy_arn" {
  description = "Policy ARNs, keyed by policy name."
  value       = { for k, v in aws_iam_policy.policy : k => v.arn }
}
