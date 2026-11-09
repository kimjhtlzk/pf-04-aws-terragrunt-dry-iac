output "route_table_ids" {
  description = "Route table IDs, keyed by name."
  value       = { for k, v in aws_route_table.route_table : k => v.id }
}
