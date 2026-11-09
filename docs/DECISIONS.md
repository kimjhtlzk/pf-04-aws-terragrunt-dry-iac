# Design decisions

## ADR-001: Terragrunt over plain Terraform

- **Context:** Each Terraform root repeated its backend and provider blocks. Dependencies between roots were tracked by hand.
- **Decision:** Keep plain Terraform modules and wrap them with Terragrunt.
- **Reason:** One root config replaces 16 copies, and `dependency` blocks make the order explicit.
- **Alternatives:** Terraform workspaces share one backend layout but do not model dependencies between roots.

## ADR-002: Terragrunt with Terraform, compared with OpenTofu

- **Context:** OpenTofu was evaluated as a Terraform alternative.
- **Decision:** Use Terragrunt on top of Terraform.
- **Reason:** Terragrunt's maturity, ecosystem, and DRY layout fit production better at the time.
- **Note:** The two solve different problems. OpenTofu replaces the engine and Terragrunt organizes the code, so using both together is a reasonable setup for large estates.

## ADR-003: Module versioning, folder pinning compared with git tags

- **Context:** The original code pinned modules with `ver_x.y.z` folders.

| | `ver_x.y.z` folders | Git tags with `?ref=` |
|---|---|---|
| See every version at once | Yes | No |
| Code duplication | High, one full copy per version | None |
| Review a change | Hard, a new folder looks like all new code | Easy, a normal diff |
| Works offline, no registry | Yes | Needs git access |
| Roll out one unit at a time | Yes | Yes |

- **Decision:** This repository keeps one copy of each module and consumes it through a local path. For production use, tag the modules and point `source` at `?ref=vX.Y.Z`.
- **Reason:** Folders add a full copy per version. Tags keep the same per-unit rollout and give reviewable diffs.

## ADR-004: `_envcommon` for source and dependencies

- **Context:** Every unit repeated its source and `dependency` blocks.
- **Decision:** Move them to `live/_envcommon/<module>.hcl` and include with `merge_strategy = "deep"`.
- **Reason:** A new environment then only writes inputs.
- **Trade-off:** One more file to open when tracing a unit.

## ADR-005: Secure defaults in the modules

- **Context:** A scanner found that encryption and metadata settings were left to each caller.
- **Decision:** IMDSv2, EBS encryption, VPC Flow Logs, and a closed default security group are fixed in the modules.
- **Reason:** A safe default cannot be forgotten.
- **Trade-off:** Each `#checkov:skip` in the code states why that check does not apply.
