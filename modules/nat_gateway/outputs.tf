output "ngw_id" {
  description = "NAT gateway IDs, keyed by name."
  value       = { for k, v in aws_nat_gateway.ngw : k => v.id }
}
