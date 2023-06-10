##----------------------------------------------------------------------------------
## Download the kubeconfig file for the cluster
##----------------------------------------------------------------------------------

resource "local_file" "kubeconfig" {
  content  = digitalocean_kubernetes_cluster.cluster.kube_config[0].raw_config
  filename = pathexpand(var.kubeconfig_path)
}
