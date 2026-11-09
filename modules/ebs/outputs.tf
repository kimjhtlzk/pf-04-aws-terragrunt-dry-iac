output "ebs_id" {
  description = "Volume IDs, keyed by volume name."
  value       = { for k, v in aws_ebs_volume.ebs_volume : k => v.id }
}

output "ebs_arn" {
  description = "Volume ARNs, keyed by volume name."
  value       = { for k, v in aws_ebs_volume.ebs_volume : k => v.arn }
}
