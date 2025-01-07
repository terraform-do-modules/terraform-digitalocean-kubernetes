# ------------------------------------------------------------------------------
# Outputs
# ------------------------------------------------------------------------------
output "id" {
  value       = digitalocean_kubernetes_cluster.main[*].id
  description = "A unique ID that can be used to identify and reference a Kubernetes cluster."
}
output "cluster_subnet" {
  value       = digitalocean_kubernetes_cluster.main[*].cluster_subnet
  description = "The range of IP addresses in the overlay network of the Kubernetes cluster."
}
output "service_subnet" {
  value       = digitalocean_kubernetes_cluster.main[*].service_subnet
  description = " The range of assignable IP addresses for services running in the Kubernetes cluster."
}
output "ipv4_address" {
  value       = digitalocean_kubernetes_cluster.main[*].ipv4_address
  description = "The public IPv4 address of the Kubernetes master node. This will not be set if high availability is configured on the cluster (v1.21+)"
}
output "endpoint" {
  value       = digitalocean_kubernetes_cluster.main[*].endpoint
  description = "The base URL of the API server on the Kubernetes master node."
}
output "status" {
  value       = digitalocean_kubernetes_cluster.main[*].status
  description = "A string indicating the current status of the cluster. Potential values include running, provisioning, and errored."
}
output "created_at" {
  value       = digitalocean_kubernetes_cluster.main[*].created_at
  description = "The date and time when the Kubernetes cluster was created."
}
output "updated_at" {
  value       = digitalocean_kubernetes_cluster.main[*].updated_at
  description = "The date and time when the Kubernetes cluster was last updated."
}
output "auto_upgrade" {
  value       = digitalocean_kubernetes_cluster.main[*].auto_upgrade
  description = "A boolean value indicating whether the cluster will be automatically upgraded to new patch releases during its maintenance window."
}
output "default_node_pool_id" {
  value       = digitalocean_kubernetes_cluster.main[*].node_pool
  description = "A unique ID that can be used to identify and reference the node pool."
}
output "urn" {
  value       = digitalocean_kubernetes_cluster.main[*].urn
  description = "The uniform resource name (URN) for the Kubernetes cluster."
}
output "maintenance_policy_day" {
  value       = digitalocean_kubernetes_cluster.main[*].maintenance_policy
  description = "A block representing the cluster's maintenance window. Updates will be applied within this window."
}
output "local_file" {
  value = join("", digitalocean_kubernetes_cluster.main[*].kube_config[0].raw_config)
}

output "token" {
  value       = digitalocean_kubernetes_cluster.main[*].kube_config[0].token
  description = "The token used to authenticate with the cluster."
}

output "cluster_ca_certificate" {
  value       = digitalocean_kubernetes_cluster.main[*].kube_config[0].cluster_ca_certificate
  description = "The certificate authority used to verify the cluster's API server."
}
