resource "local_file" "kubeconfig" {
  content  = join("", digitalocean_kubernetes_cluster.main[*].kube_config[0].raw_config)
  filename = pathexpand(var.kubeconfig_path)
}