output "security_group_ids" {
  description = "Security group IDs, keyed by name."
  value       = { for sg in aws_security_group.sg : sg.tags["Name"] => sg.id }
}
