#!/usr/bin/env bash
# Validates every unit in dependency order and prints one line per unit.
# Needs no cloud credentials: dependency outputs come from mock_outputs.
set -euo pipefail
cd "$(dirname "$0")/../live/dev"

order=(
  global/iam_custom_policy global/iam_user global/iam_custom_role global/iam_group
  ap-northeast-2/vpc ap-northeast-2/elastic_ip ap-northeast-2/ebs
  ap-northeast-2/internet_gateway ap-northeast-2/security_group ap-northeast-2/vpc_endpoint
  ap-northeast-2/vpc_peering ap-northeast-2/elasticache_subnet_group ap-northeast-2/nat_gateway
  ap-northeast-2/instance_profile ap-northeast-2/route_table ap-northeast-2/ec2_instance
)

for unit in "${order[@]}"; do
  terragrunt validate --terragrunt-non-interactive --terragrunt-working-dir "$unit" >/dev/null 2>&1
  printf '  ok  %s\n' "$unit"
done
printf '\n%d units valid\n' "${#order[@]}"
