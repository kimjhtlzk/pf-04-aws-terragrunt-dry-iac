locals {
  ec2_add_ebs = flatten([
    for ec2_instance in var.ec2_instance : [
      for add_ebs_key, add_ebs_value in ec2_instance.add_ebs : {
        name              = ec2_instance.name
        availability_zone = ec2_instance.availability_zone
        add_ebs_path      = add_ebs_value.add_ebs_path
        ebs_id            = add_ebs_value.ebs_id
        ebs_key           = add_ebs_key
        ebs_value         = add_ebs_value
      }
    ]
  ])
}

resource "aws_instance" "ec2" {
  #checkov:skip=CKV2_AWS_41:The instance profile is an input. The live example always sets one.
  for_each = { for ec2_instance in var.ec2_instance : ec2_instance.name => ec2_instance }

  ami                     = each.value.ami
  instance_type           = each.value.instance_type
  availability_zone       = each.value.availability_zone
  iam_instance_profile    = each.value.iam_instance_profile
  monitoring              = true
  ebs_optimized           = true
  hibernation             = false
  disable_api_stop        = false
  disable_api_termination = each.value.disable_api_termination
  user_data               = null

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  network_interface {
    network_interface_id = aws_network_interface.nic[each.key].id
    device_index         = 0
  }

  root_block_device {
    volume_type           = each.value.root_ebs.root_ebs_type
    volume_size           = each.value.root_ebs.root_ebs_size
    delete_on_termination = each.value.root_ebs.delete_on_termination
    encrypted             = true

    tags = {
      Name = each.value.name
    }
  }

  maintenance_options {
    auto_recovery = "default"
  }

  dynamic "instance_market_options" {
    for_each = each.value.spot_options.use_spot ? [1] : []

    content {
      market_type = "spot"

      spot_options {
        instance_interruption_behavior = each.value.spot_options.instance_interruption_behavior
        spot_instance_type             = each.value.spot_options.spot_instance_type
        max_price                      = each.value.spot_options.max_price
      }
    }
  }

  tags = {
    Name = each.value.name
  }
}

resource "aws_network_interface" "nic" {
  for_each = { for ec2_instance in var.ec2_instance : ec2_instance.name => ec2_instance }

  subnet_id       = each.value.subnet
  private_ips     = [each.value.private_ip]
  security_groups = each.value.security_groups

  tags = {
    Name = "nic-${each.value.name}"
  }
}

resource "aws_eip_association" "eip_att" {
  for_each = {
    for ec2_instance in var.ec2_instance : ec2_instance.name => ec2_instance
    if ec2_instance.associate_public_ip_address != null
  }

  network_interface_id = aws_network_interface.nic[each.key].id
  allocation_id        = each.value.associate_public_ip_address
}

resource "aws_ebs_volume" "ebs" {
  #checkov:skip=CKV_AWS_189:Encrypted with the AWS managed key so the demo has no KMS dependency. Add kms_key_id in production.
  for_each = {
    for ebs in local.ec2_add_ebs : "${ebs.name}-${ebs.ebs_key}" => ebs
    if ebs.ebs_id == null
  }

  availability_zone = each.value.availability_zone
  size              = each.value.ebs_value.add_ebs_size
  type              = each.value.ebs_value.add_ebs_type
  iops              = each.value.ebs_value.iops
  throughput        = each.value.ebs_value.throughput
  snapshot_id       = each.value.ebs_value.snapshot_id
  encrypted         = true

  tags = {
    Name = each.key
  }
}

resource "aws_volume_attachment" "ebs_att" {
  for_each = { for ebs in local.ec2_add_ebs : "${ebs.name}-${ebs.ebs_key}" => ebs }

  device_name = each.value.add_ebs_path
  volume_id   = each.value.ebs_id != null ? each.value.ebs_id : aws_ebs_volume.ebs[each.key].id
  instance_id = aws_instance.ec2[each.value.name].id
}
