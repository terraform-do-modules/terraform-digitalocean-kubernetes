output "cluster_name" {
  description = "Kubernetes cluster name"
  value       = module.cluster.cluster_name
}

output "cluster_endpoint" {
  description = "Kubernetes API endpoint"
  value       = module.cluster.cluster_endpoint
}

output "cluster_id" {
  description = "Kubernetes cluster ID"
  value       = module.cluster.cluster_id
}
