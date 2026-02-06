# Terraform version
terraform {
  required_version = ">= 1.5.4"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.70.0"
    }
  }
}