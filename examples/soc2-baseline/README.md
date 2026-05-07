# SOC2 Baseline Example (DigitalOcean Kubernetes)

This example provides a **SOC2-oriented baseline** for the Kubernetes module.
It focuses on controlled operations, separation of critical/application pools,
and evidence-friendly tagging.

## Included baseline choices
- HA control plane enabled (`ha = true`)
- Manual, controlled upgrade posture (`auto_upgrade = false`, `surge_upgrade = false`)
- Defined maintenance window
- Dedicated critical + application node pools
- Evidence and ownership tags for audit traceability

## Important
This is a **technical baseline**, not SOC2 certification by itself.
You still need org controls and evidence for:
- Access reviews and least privilege
- Change management approvals
- Centralized audit-log retention and review
- Backup/restore testing cadence
- Incident response runbooks and drills

## Usage
```bash
cd _examples/soc2-baseline
terraform init
terraform plan
terraform apply
```
