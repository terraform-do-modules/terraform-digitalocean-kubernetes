##------------------------------------------------
## Terragrunt configuration for DigitalOcean Kubernetes
##
## Prerequisites:
##   - Terragrunt >= 0.55.0  (https://terragrunt.gruntwork.io)
##   - OpenTofu >= 1.6.0     (https://opentofu.org)
##     OR Terraform >= 1.6.0 (https://terraform.io)
##   - DIGITALOCEAN_TOKEN env var set
##   - SPACES_ACCESS_KEY_ID and SPACES_SECRET_ACCESS_KEY set (for remote state)
##   - VPC must exist before applying this module;
##     set vpc_uuid in inputs below to the VPC id output
##
## Deploy:
##   terragrunt init
##   terragrunt plan
##   terragrunt apply
##
## Destroy:
##   terragrunt destroy
##------------------------------------------------

locals {
  name        = "app"
  environment = "test"
  region      = "blr1"
  project     = "myapp"
}

##------------------------------------------------
## Remote state stored in DigitalOcean Spaces (S3-compatible)
## Create the Spaces bucket before running terragrunt init
##------------------------------------------------
remote_state {
  backend = "s3"

  config = {
    endpoint = "https://${local.region}.digitaloceanspaces.com"
    # DO Spaces requires a dummy AWS region value
    region = "us-east-1"
    bucket = "${local.project}-terraform-state"
    key    = "${path_relative_to_include()}/terraform.tfstate"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

##------------------------------------------------
## Source module from GitHub
## Pin to a specific tag for production stability
##
## Terraform:
##   Uses the source block below as-is.
##
## OpenTofu:
##   Set TERRAGRUNT_TFPATH=tofu in your shell, or configure
##   terraform_binary in your root terragrunt.hcl:
##     terraform_binary = "tofu"
##------------------------------------------------
terraform {
  source = "git::https://github.com/terraform-do-modules/terraform-digitalocean-kubernetes.git//?ref=v1.0.0"

  ##------------------------------------------------
  ## Use OpenTofu instead of Terraform (optional)
  ## Uncomment the block below and set TERRAGRUNT_TFPATH or
  ## set the terraform_binary in your root terragrunt.hcl
  ##------------------------------------------------
  # extra_arguments "use_opentofu" {
  #   commands = get_terraform_commands_that_need_vars()
  # }
}

##------------------------------------------------
## Provider generation — avoids repeating provider
## blocks in every child module
##------------------------------------------------
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    provider "digitalocean" {}
  EOF
}

##------------------------------------------------
## Module inputs
## Replace vpc_uuid with the actual VPC id output
## from the terraform-digitalocean-vpc module.
##------------------------------------------------
inputs = {
  name            = local.name
  environment     = local.environment
  region          = local.region
  cluster_version = "1.31.1-do.5"
  vpc_uuid        = "" # replace with module.vpc.id or a data source reference

  critical_node_pool = {
    critical_node = {
      node_count = 1
      min_nodes  = 1
      max_nodes  = 3
      size       = "s-2vcpu-4gb"
      labels     = { tier = "critical" }
      taint = [{
        key    = "tier"
        value  = "critical"
        effect = "NoSchedule"
      }]
    }
  }
}
