output "eip_id" {
  description = "Allocation IDs, keyed by name."
  value       = { for k, v in aws_eip.eip : k => v.id }
}
