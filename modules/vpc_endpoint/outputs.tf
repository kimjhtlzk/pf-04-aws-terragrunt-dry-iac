output "endpoint_ids" {
  description = "Endpoint IDs, keyed by VPC ID."
  value       = { for k, v in aws_vpc_endpoint.ep : k => v.id }
}
