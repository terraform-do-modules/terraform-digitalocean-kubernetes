##-----------------------------------------------------------------------------
## Labels module callled that will be used for naming and tags.
##-----------------------------------------------------------------------------
module "labels" {
  source      = "git::https://github.com/terraform-do-modules/terraform-digitalocean-labels.git?ref=internal-426m"
  name        = var.name
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
}

##---------------------------------------------------------------------------------------------------------------------------
#Description : Provides a DigitalOcean Kubernetes cluster resource. This can be used to create, delete, and modify clusters.
##---------------------------------------------------------------------------------------------------------------------------
#tfsec:ignore:digitalocean-compute-kubernetes-auto-upgrades-not-enabled  ### by default we disable auto-upgrades, if it enables auto-upgrades, maybe create an issue in the cluster.
#tfsec:ignore:digitalocean-compute-surge-upgrades-not-enabled ### by default we disable surge upgrades, if it enables surge upgrades, maybe create an issue in the cluster.
resource "digitalocean_kubernetes_cluster" "main" {
  count                = var.enabled ? 1 : 0
  name                 = format("%s-cluster", module.labels.id)
  region               = var.region
  version              = var.cluster_version
  vpc_uuid             = var.vpc_uuid
  auto_upgrade         = var.auto_upgrade
  surge_upgrade        = var.surge_upgrade
  ha                   = var.ha
  registry_integration = var.registry_integration

  dynamic "node_pool" {
    for_each = var.default_node_pool
    content {
      name       = lookup(node_pool.value, "name", "default-node-pool")
      size       = lookup(node_pool.value, "size", "s-1vcpu-2gb")
      node_count = lookup(node_pool.value, "node_count", 1)
      auto_scale = lookup(node_pool.value, "auto_scale", true)
      min_nodes  = lookup(node_pool.value, "min_nodes", 1)
      max_nodes  = lookup(node_pool.value, "max_nodes", 2)
      tags       = lookup(node_pool.value, "tags", null)
      labels     = lookup(node_pool.value, "labels", null)
    }
  }

  dynamic "maintenance_policy" {
    for_each = var.auto_upgrade ? [1] : []
    content {
      day        = var.maintenance_policy.day
      start_time = var.maintenance_policy.start_time
    }
  }

  tags = var.tags
}

##--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Description : Provides a DigitalOcean Kubernetes node pool resource. While the default node pool must be defined in the digitalocean_kubernetes_cluster resource, this resource can be used to add additional ones to a cluster.
##--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
resource "digitalocean_kubernetes_node_pool" "main" {
  for_each = var.enabled ? var.node_pools : {}

  cluster_id = join("", digitalocean_kubernetes_cluster.main[*].id)
  name       = lookup(each.value, "name", "node-pool")
  size       = lookup(each.value, "size", "s-1vcpu-2gb")
  node_count = lookup(each.value, "node_count", 1)
  auto_scale = lookup(each.value, "auto_scale", true)
  min_nodes  = lookup(each.value, "min_nodes", 1)
  max_nodes  = lookup(each.value, "max_nodes", 2)
  tags       = lookup(each.value, "tags", null)
  labels     = lookup(each.value, "labels", null)
}