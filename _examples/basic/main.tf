provider "digitalocean" {}

locals {
  name        = "app3"
  environment = "test"
  region      = "blr1"
}

##------------------------------------------------
## VPC module call
##------------------------------------------------
module "vpc" {
  source      = "git::https://github.com/terraform-do-modules/terraform-digitalocean-vpc.git?ref=internal-423"
  name        = local.name
  environment = local.environment
  region      = local.region
  ip_range    = "10.10.0.0/16"
}

##------------------------------------------------
## Kubernetes module call
##------------------------------------------------
module "cluster" {
  source          = "./../../"
  name            = local.name
  environment     = local.environment
  region          = local.region
  cluster_version = "1.27.2-do.0"
  vpc_uuid        = module.vpc.id

  default_node_pool = {
    default_node = {
      node_count = 1
      min_nodes  = 1
      max_nodes  = 2
      size       = "s-1vcpu-2gb"
    }
  }

  node_pools = {
    node = {
      size       = "s-1vcpu-2gb"
      node_count = 1
      min_nodes  = 1
      max_nodes  = 2
    }
  }
}

