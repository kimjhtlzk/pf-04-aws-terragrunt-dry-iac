output "subnet_group_name" {
  description = "Subnet group names."
  value       = { for g in aws_elasticache_subnet_group.subnet_group : g.name => g.name }
}
