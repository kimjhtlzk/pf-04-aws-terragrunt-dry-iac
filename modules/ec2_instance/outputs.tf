output "instance_ids" {
  description = "Instance IDs, keyed by instance name."
  value       = { for k, v in aws_instance.ec2 : k => v.id }
}

output "private_ips" {
  description = "Private IPs, keyed by instance name."
  value       = { for k, v in aws_instance.ec2 : k => v.private_ip }
}
