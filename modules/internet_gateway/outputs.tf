output "igw_id" {
  description = "Gateway IDs, keyed by name."
  value       = { for k, v in aws_internet_gateway.igw : k => v.id }
}
