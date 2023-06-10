# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------
variable "label_order" {
  type        = list(string)
  default     = ["name", "environment"]
  description = "Label order, e.g. `name`,`environment`."
}

variable "kubeconfig_path" {
  description = "The path to save the kubeconfig to"
  default     = "./kubeconfig"
}