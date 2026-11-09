# Refactor notes

## Feature map

| Original feature | Location in this repository |
|---|---|
| Root backend and provider generation | `live/root.hcl` |
| Region inheritance through `region.hcl` | `live/dev/*/region.hcl` |
| 16 versioned modules | `modules/` (one copy each) |
| `dependency` blocks with `mock_outputs` | `live/_envcommon/*.hcl` |
| Global IAM and regional units | `live/dev/global`, `live/dev/ap-northeast-2` |
| Module upgrade runbook | `docs/runbooks/module-version-upgrade.md` |
| Cache cleanup commands | Step 2 of the runbook |

## What changed and why

| Change | Reason |
|---|---|
| `ver_x.y.z` folders became one copy per module | See ADR-003 |
| `output.tf` renamed to `outputs.tf`, `versions.tf` added | Standard module layout |
| Descriptions added to all variables and outputs | Generated module docs |
| Dated backup folders removed | Not source code |
| Route table subnet association implemented | The input existed but was not used |
| `iam_user` output renamed to `user_names` | The old name did not match its value |
| Attachment keys changed from ARN to index | ARNs can be unknown at plan time |
| Secure defaults added | See ADR-005 |
| MFA condition added to human role trust policies | Security hardening |
| All identifiers replaced with placeholders | See `SECURITY.md` |
