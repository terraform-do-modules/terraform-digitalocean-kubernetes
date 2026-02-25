# Security Policy

## Supported Versions

We actively maintain the latest major release of each module. Security fixes are applied to the latest release only.

| Version | Supported |
|---------|-----------|
| Latest  | Yes       |
| Older   | No        |

## Reporting a Vulnerability

**Please do not report security vulnerabilities through public GitHub issues.**

To report a security issue, email us at **support@clouddrove.com** with the subject line:
`[SECURITY] terraform-do-modules/<repo-name>`

Include as much of the following as possible:

- Type of issue (e.g. exposed secret, privilege escalation, insecure default)
- Affected module and version/git ref
- Steps to reproduce or proof-of-concept
- Potential impact assessment

We will acknowledge receipt within **48 hours** and aim to provide a fix or mitigation within **7 days** for critical issues.

## Scope

This policy covers:
- Terraform module code in this repository
- GitHub Actions workflow configurations
- Example configurations under `_examples/`

This policy does **not** cover:
- The DigitalOcean provider itself (report to [HashiCorp](https://www.hashicorp.com/security) or [DigitalOcean](https://www.digitalocean.com/security))
- Issues in third-party dependencies (report upstream)

## Preferred Languages

We accept reports in **English**.

