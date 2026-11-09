resource "aws_ebs_volume" "ebs_volume" {
  #checkov:skip=CKV_AWS_189:Encrypted with the AWS managed key so the demo has no KMS dependency. Add kms_key_id in production.
  for_each = { for ebs in var.ebs : ebs.name => ebs }

  availability_zone = each.value.availability_zone
  type              = each.value.type
  size              = each.value.size
  snapshot_id       = each.value.snapshot_id
  iops              = each.value.iops
  throughput        = each.value.throughput
  encrypted         = true

  tags = {
    Name = each.value.name
  }
}
