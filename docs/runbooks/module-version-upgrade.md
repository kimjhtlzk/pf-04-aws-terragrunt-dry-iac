# Runbook: upgrade a module version without touching resources

**Goal:** move one unit to a new module version and prove that nothing changes.

Run these steps from the unit directory, for example `live/dev/ap-northeast-2/vpc`.

| Step | Command | Why |
|---|---|---|
| 1. Back up state | `terragrunt state pull > /backup/dev-ap-northeast-2-vpc.tfstate` | A remote backend does not make this copy for you |
| 2. Clear caches | `find . -name '.terragrunt-cache' -type d -prune -exec rm -rf {} +` and `find . -name '.terraform.lock.hcl' -delete` | Removes the old module copy and provider locks |
| 3. Change the source | Point `terraform.source` at the new version | This is the only code change |
| 4. Initialize | `terragrunt init` | Downloads the new module |
| 5. Restore state | `terragrunt state push /backup/dev-ap-northeast-2-vpc.tfstate` | Only needed if step 2 removed local state |
| 6. Verify | `terragrunt plan` | **The plan must say `No changes.`** |

The backup directory must exist before step 1.

If step 6 shows a change, stop. Read the diff, then either fix the module so the plan is empty or restore the backup and revert the source.
