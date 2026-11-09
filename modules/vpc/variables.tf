variable "vpcs" {
  description = "VPCs to create, each with its subnets."
  type = list(object({
    name                = string
    cidr_block          = string
    use_ipv6_cidr_block = bool
    subnets = list(object({
      subnet_name       = string
      subnet_cidr       = string
      ipv6_cidr_block   = string
      availability_zone = string
      autoassign_public = bool
      tags              = map(string)
    }))
  }))
}

variable "flow_log_retention_days" {
  description = "How long to keep VPC Flow Logs in CloudWatch."
  type        = number
  default     = 365
}
