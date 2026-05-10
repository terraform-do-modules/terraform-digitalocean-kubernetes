provider "digitalocean" {}

locals {
  name        = "platform"
  environment = "prod"
  region      = "blr1"
}

module "vpc" {
  source      = "terraform-do-modules/vpc/digitalocean"
  version     = "1.0.0"
  name        = local.name
  environment = local.environment
  region      = local.region
  ip_range    = "10.30.0.0/16"
}

module "cluster" {
  source      = "./../../"
  name        = local.name
  environment = local.environment
  region      = local.region

  # Keep pinned and upgraded through controlled rollout waves.
  cluster_version = "1.31.1-do.5"

  vpc_uuid              = module.vpc.id
  ha                    = true
  auto_upgrade          = false
  surge_upgrade         = false
  registry_integration  = false
  maintenance_policy = {
    day        = "sunday"
    start_time = "03:00"
  }

  tags = [
    "env:prod",
    "control:soc2-baseline",
    "owner:platform",
    "evidence:required"
  ]

  critical_node_pool = {
    critical_node = {
      node_count = 3
      min_nodes  = 3
      max_nodes  = 6
      size       = "s-2vcpu-4gb"
      labels     = { tier = "critical" }
      tags       = ["critical", "soc2"]
      taint = [{
        key    = "tier"
        value  = "critical"
        effect = "NoSchedule"
      }]
    }
  }

  app_node_pools = {
    app_node = {
      node_count = 2
      min_nodes  = 2
      max_nodes  = 10
      size       = "s-2vcpu-4gb"
      labels     = { tier = "application" }
      tags       = ["application", "soc2"]
    }
  }
}
