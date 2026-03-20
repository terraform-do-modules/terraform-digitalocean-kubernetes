# Wrapper Module

This module provides a wrapper around the parent module using `for_each` to create multiple instances.

## Usage with Terragrunt

```hcl
terraform {
  source = "git::https://github.com/terraform-do-modules/terraform-digitalocean-kubernetes//wrappers?ref=master"
}

inputs = {
  items = {
    instance1 = {
      name        = "first"
      environment = "production"
    }
    instance2 = {
      name        = "second"
      environment = "staging"
    }
  }
}
```
