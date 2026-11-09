variable "ebs" {
  description = "EBS volumes to create. Set snapshot_id, iops, and throughput to null to use defaults."
  type = list(object({
    name              = string
    availability_zone = string
    type              = string
    size              = number
    snapshot_id       = string
    iops              = number
    throughput        = number
    device_name       = string
  }))
}
