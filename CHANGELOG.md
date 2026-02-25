## [1.1.6] - 2026-02-25

### 📚 Documentation
- Added `docs/architecture.md` — architecture guidance and operational checklist
- Added `docs/io.md` — full inputs/outputs reference table

### 💡 Examples
- Added `_examples/terragrunt/` — Terragrunt example with DO Spaces remote state and OpenTofu support

### 👷 CI/CD & GitHub
- Added `.github/ISSUE_TEMPLATE/` — bug report, feature request, and config templates
- Added `SECURITY.md` — vulnerability reporting policy
- Standardized all workflow SHA pins and removed `workflows.old/`
- Upgraded `.pre-commit-config.yaml` to gruntwork-io/pre-commit v0.1.23 and pre-commit-hooks v4.5.0

## [1.1.3] - 2026-02-06

### Changes
- ⬆️ upgrade: update examples to use provider >= 2.70.0
- 📚 Add comprehensive CONTRIBUTING.md
- ⬆️ Upgrade provider & standardize workflows
- 📝 Update CHANGELOG for v1.1.2
- chore: update Terraform version requirement to >= 1.5.4
- fix: updated workflow files & versions.tf (#29)
- chore: standardize GitHub Actions workflows and fix code issues
- Merge pull request #22 from nicolas-laduguie/fix-sensitive-outputs
- Merge pull request #19 from terraform-do-modules/dependabot/github_actions/clouddrove/github-shared-workflows-1.2.8
- Merge branch 'master' into dependabot/github_actions/clouddrove/github-shared-workflows-1.2.8

# Changelog
All notable changes to this project will be documented in this file.


## [1.1.2] - 2026-02-06

### ⬆️ Dependencies
- Updated Terraform version requirement to >= 1.5.4

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
