include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/ec2_instance.hcl"
  merge_strategy = "deep"
}

locals {
  aws_region = read_terragrunt_config(find_in_parent_folders("region.hcl")).locals.aws_region
}

inputs = {
  ec2_instance = [
    {
      name                        = "demo-ec2-1"
      ami                         = "ami-00000000000000000"
      instance_type               = "t3.small"
      availability_zone           = "${local.aws_region}a"
      subnet                      = dependency.vpc.outputs.subnets_ids["demo-vpc-1-subnet-1"]
      private_ip                  = "10.0.11.11"
      associate_public_ip_address = dependency.elastic_ip.outputs.eip_id["demo-eip-1"]
      security_groups             = [dependency.security_group.outputs.security_group_ids["demo-sg-1"]]

      spot_options = {
        use_spot                       = false
        instance_interruption_behavior = "terminate"
        spot_instance_type             = "one-time"
        max_price                      = 0.05
      }

      root_ebs = {
        root_ebs_type         = "gp3"
        root_ebs_size         = 50
        delete_on_termination = true
      }

      add_ebs = {
        1 = {
          add_ebs_type = "gp3"
          add_ebs_size = 50
          add_ebs_path = "/dev/xvdb"
          iops         = 5000
          throughput   = 200
          snapshot_id  = null
          ebs_id       = null
        }
        2 = {
          add_ebs_type = "gp3"
          add_ebs_size = 40
          add_ebs_path = "/dev/xvdc"
          iops         = null
          throughput   = null
          snapshot_id  = null
          ebs_id       = dependency.ebs.outputs.ebs_id["demo-ebs-1"]
        }
      }

      iam_instance_profile    = keys(dependency.instance_profile.outputs.instance_profile_arn)[0]
      disable_api_termination = false
    },
  ]
}
