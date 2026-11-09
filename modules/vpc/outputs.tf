output "vpc_id" {
  description = "VPC ID and CIDR, keyed by VPC name."
  value = {
    for k, vpc in aws_vpc.vpc : vpc.tags["Name"] => {
      vpc_cidr = k
      vpc_id   = vpc.id
    }
  }
}

output "subnets" {
  description = "Subnet objects, keyed by availability zone and CIDR."
  value       = aws_subnet.subnet
}

output "subnets_ids" {
  description = "Subnet IDs, keyed by subnet name."
  value       = { for s in aws_subnet.subnet : s.tags["Name"] => s.id }
}

output "vpc_ipv6_cidr_block" {
  description = "IPv6 CIDR of each VPC, keyed by VPC name."
  value = {
    for k, vpc in aws_vpc.vpc : vpc.tags["Name"] => {
      vpc_cidr  = k
      ipv6_cidr = vpc.ipv6_cidr_block
    }
  }
}
