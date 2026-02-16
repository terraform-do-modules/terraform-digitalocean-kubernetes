output "cluster_id" {
  description = "Kubernetes cluster ID"
  value       = module.cluster.id
}

output "cluster_endpoint" {
  description = "Kubernetes API endpoint"
  value       = module.cluster.endpoint
}
