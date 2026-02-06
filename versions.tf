# Terraform version
terraform {
  required_version = ">= 1.5.4"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.28.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.3"
    }
  }
}
