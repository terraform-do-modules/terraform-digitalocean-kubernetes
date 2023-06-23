#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. `name`,`application`."
}

variable "managedby" {
  type        = string
  default     = "terraform-do-modules"
  description = "ManagedBy, eg 'terraform-do-modules' or 'hello@clouddrove.com'"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Whether to create the resources. Set to `false` to prevent the module from creating any resources."
}

variable "region" {
  type        = string
  default     = "blr1"
  description = "K8s Cluster Region."
}

variable "cluster_version" {
  type        = string
  default     = "1.27.2"
  description = "K8s Cluster Version."
}

variable "vpc_uuid" {
  type        = string
  default     = ""
  description = "The ID of the VPC where the Kubernetes cluster will be located."
}

variable "auto_upgrade" {
  type        = bool
  default     = false
  description = "Enable auto upgrade during maintenance window."
}

variable "surge_upgrade" {
  type        = bool
  default     = false
  description = "Enable surge upgrade during maintenance window."
}

variable "ha" {
  type        = bool
  default     = true
  description = "Enable high availability control plane."
}

variable "registry_integration" {
  type        = bool
  default     = false
  description = "Enables or disables the DigitalOcean container registry integration for the cluster. This requires that a container registry has first been created for the account."
}

variable "critical_node_pool" {
  type        = any
  default     = {}
  description = "Cluster default node pool."
}

variable "app_node_pools" {
  type        = map(any)
  default     = {}
  description = "Cluster additional node pools."
}

variable "tags" {
  type        = list(string)
  default     = []
  description = "List of tags to apply to the cluster."
}

variable "maintenance_policy" {
  type = object({
    day        = string
    start_time = string
  })
  default = {
    day        = "any"
    start_time = "5:00"
  }
  description = "Define the window updates are to be applied when auto upgrade is set to true."
}
//variable "taint" {
//  type = any
//  default = {}
//}

variable "kubeconfig_path" {
  description = "The path to save the kubeconfig to"
  default     = "./kubeonfig"
}
