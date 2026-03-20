# Terraform version
terraform {
  required_version = ">= 1.10.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.70.0"
    }
  }
}