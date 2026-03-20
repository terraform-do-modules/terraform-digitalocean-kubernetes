# Terraform version
terraform {
  required_version = ">= 1.10.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.70.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.3"
    }
  }

  provider_meta "digitalocean" {
    module_name = "terraform-do-modules/terraform-digitalocean-kubernetes"
  }
}
