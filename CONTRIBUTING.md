# Contributing to Terraform DigitalOcean Modules

Thank you for your interest in contributing! 🎉

## Table of Contents
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Process](#development-process)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Testing Guidelines](#testing-guidelines)

## Code of Conduct

We are committed to providing a welcoming and inspiring community for all. Please read and follow our [Code of Conduct](CODE_OF_CONDUCT.md).

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR-USERNAME/REPO-NAME.git
   cd REPO-NAME
   ```
3. **Add upstream remote**:
   ```bash
   git remote add upstream https://github.com/terraform-do-modules/REPO-NAME.git
   ```

## Development Process

### Prerequisites
- Terraform >= 1.5.4
- pre-commit hooks installed
- DigitalOcean API token for testing

### Setting up pre-commit hooks
```bash
pip install pre-commit
pre-commit install
```

### Making Changes

1. **Create a feature branch**:
   ```bash
   git checkout -b feature/my-awesome-feature
   ```

2. **Make your changes** following our coding standards

3. **Test your changes**:
   ```bash
   terraform init
   terraform validate
   terraform fmt -check
   ```

4. **Commit with conventional commits**:
   ```bash
   git commit -m "✨ feat: add awesome new feature"
   ```

### Commit Message Format

We use [Conventional Commits](https://www.conventionalcommits.org/):

- ✨ `feat:` - New features
- 🐛 `fix:` - Bug fixes
- 📝 `docs:` - Documentation changes
- 🎨 `style:` - Code style changes (formatting, etc.)
- ♻️ `refactor:` - Code refactoring
- ⚡ `perf:` - Performance improvements
- ✅ `test:` - Adding/updating tests
- 👷 `ci:` - CI/CD changes
- 🔧 `chore:` - Maintenance tasks
- ⬆️ `upgrade:` - Dependency upgrades

## Pull Request Process

1. **Update documentation** if needed (README.md, variables, outputs)

2. **Update CHANGELOG.md** with your changes

3. **Ensure all tests pass**:
   ```bash
   terraform validate
   terraform fmt -check -recursive
   ```

4. **Create Pull Request** with:
   - Clear title following conventional commit format
   - Detailed description of changes
   - Link to related issues
   - Screenshots/examples if applicable

5. **Address review feedback** promptly

### PR Requirements

- ✅ All CI checks must pass
- ✅ Code must be formatted (`terraform fmt`)
- ✅ Documentation must be updated
- ✅ CHANGELOG must be updated
- ✅ At least one approval from maintainers

## Coding Standards

### Terraform Best Practices

1. **Use variables** for all configurable values
2. **Add descriptions** to all variables and outputs
3. **Use meaningful names** for resources
4. **Follow naming conventions**:
   - Resources: `snake_case`
   - Variables: `snake_case`
   - Outputs: `snake_case`

### File Structure
```
.
├── _examples/
│   ├── basic/
│   └── complete/
├── .github/
│   └── workflows/
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── README.md
├── CHANGELOG.md
└── LICENSE
```

### Code Style

- Use `terraform fmt` before committing
- Keep line length under 120 characters
- Add comments for complex logic
- Group related resources together

### Example Structure

```hcl
# Resource type
resource "digitalocean_droplet" "this" {
  count = var.enabled ? 1 : 0

  name   = var.name
  image  = var.image
  region = var.region
  size   = var.size

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}
```

## Testing Guidelines

### Manual Testing

1. Create a test directory:
   ```bash
   mkdir test-run
   cd test-run
   ```

2. Create a test configuration:
   ```hcl
   module "test" {
     source = "../"
     # Add test variables
   }
   ```

3. Run terraform:
   ```bash
   terraform init
   terraform plan
   terraform apply -auto-approve
   terraform destroy -auto-approve
   ```

### Validation Checks

Before submitting, ensure:
- ✅ `terraform init` succeeds
- ✅ `terraform validate` passes
- ✅ `terraform fmt -check` passes
- ✅ No sensitive data in code
- ✅ Examples work correctly

## Questions?

- 💬 **Slack**: [Join our community](https://slack.clouddrove.com)
- 📧 **Email**: opensource@clouddrove.com
- 🐛 **Issues**: Use GitHub Issues for bugs and feature requests

## License

By contributing, you agree that your contributions will be licensed under the Apache License 2.0.

---

Thank you for contributing! 🚀
