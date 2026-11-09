# Architecture

## Layers

| Layer | Path | Holds |
|---|---|---|
| Root | `live/root.hcl` | Backend, provider, and common inputs for every unit |
| Scope | `live/dev/account.hcl`, `<region>/region.hcl` | Values that differ per account or region |
| Common | `live/_envcommon/<module>.hcl` | Module source, dependencies, and mock outputs |
| Unit | `live/dev/<region>/<module>/terragrunt.hcl` | Only the inputs for this deployment |
| Module | `modules/<module>/` | Plain Terraform with no knowledge of Terragrunt |

## How a unit is built

1. `include "root"` brings in the generated `backend.tf` and `provider.tf`.
2. `include "envcommon"` brings in the source and `dependency` blocks.
3. The unit adds its own `inputs`.
4. Terragrunt reads the `dependency` blocks across all units and builds the graph.

## Dependency graph

There are 16 units on four levels. Units on the same level can run in parallel.

| Level | Units |
|---|---|
| 0 | `iam_custom_policy`, `vpc`, `elastic_ip`, `ebs` |
| 1 | `iam_user`, `iam_custom_role`, `internet_gateway`, `security_group`, `vpc_endpoint`, `vpc_peering`, `elasticache_subnet_group`, `nat_gateway` |
| 2 | `iam_group`, `instance_profile`, `route_table` |
| 3 | `ec2_instance` |

## Validation without a cloud account

`mock_outputs` are allowed for `init`, `validate`, and `plan`. They let `run-all validate` resolve every dependency before any resource exists.
