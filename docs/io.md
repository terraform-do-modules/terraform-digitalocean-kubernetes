# Inputs and Outputs: terraform-digitalocean-kubernetes

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `name` | Name (e.g. `app` or `cluster`). | `string` | `""` | no |
| `environment` | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| `label_order` | Label order, e.g. `name`, `application`. | `list(any)` | `["name", "environment"]` | no |
| `managedby` | ManagedBy, eg `terraform-do-modules` or `hello@clouddrove.com`. | `string` | `"terraform-do-modules"` | no |
| `enabled` | Whether to create the resources. Set to `false` to prevent the module from creating any resources. | `bool` | `true` | no |
| `region` | K8s Cluster Region. | `string` | `"blr1"` | no |
| `cluster_version` | K8s Cluster Version (DOKS version slug, e.g. `1.31.1-do.5`). | `string` | `"1.31.1-do.5"` | no |
| `vpc_uuid` | The ID of the VPC where the Kubernetes cluster will be located. | `string` | `""` | no |
| `auto_upgrade` | Enable auto upgrade during maintenance window. | `bool` | `false` | no |
| `surge_upgrade` | Enable surge upgrade during maintenance window. | `bool` | `false` | no |
| `ha` | Enable high availability control plane. | `bool` | `true` | no |
| `registry_integration` | Enables or disables the DigitalOcean container registry integration for the cluster. Requires a container registry to exist in the account first. | `bool` | `false` | no |
| `critical_node_pool` | Cluster default node pool definition. Supports `name`, `size`, `node_count`, `auto_scale`, `min_nodes`, `max_nodes`, `tags`, `labels`, and `taint` keys. | `any` | `{}` | no |
| `app_node_pools` | Cluster additional node pools. Map of pool name to pool configuration objects. Supports the same keys as `critical_node_pool`. | `map(any)` | `{}` | no |
| `tags` | List of tags to apply to the cluster. | `list(string)` | `[]` | no |
| `maintenance_policy` | Define the window updates are applied when `auto_upgrade` is `true`. Requires `day` (e.g. `sunday`) and `start_time` (e.g. `03:00`). | `object({ day = string, start_time = string })` | `{ day = "any", start_time = "5:00" }` | no |
| `kubeconfig_path` | The path to save the kubeconfig to. | `string` | `"./kubeconfig"` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | A unique ID that can be used to identify and reference a Kubernetes cluster. |
| `cluster_subnet` | The range of IP addresses in the overlay network of the Kubernetes cluster. |
| `service_subnet` | The range of assignable IP addresses for services running in the Kubernetes cluster. |
| `ipv4_address` | The public IPv4 address of the Kubernetes master node. Not set when high availability is configured (v1.21+). |
| `endpoint` | The base URL of the API server on the Kubernetes master node. |
| `status` | A string indicating the current status of the cluster. Potential values include `running`, `provisioning`, and `errored`. |
| `created_at` | The date and time when the Kubernetes cluster was created. |
| `updated_at` | The date and time when the Kubernetes cluster was last updated. |
| `auto_upgrade` | A boolean value indicating whether the cluster will be automatically upgraded to new patch releases during its maintenance window. |
| `default_node_pool_id` | A unique ID that can be used to identify and reference the default node pool. |
| `urn` | The uniform resource name (URN) for the Kubernetes cluster. |
| `maintenance_policy_day` | A block representing the cluster's maintenance window. |
| `local_file` | The raw kubeconfig content for the cluster. Sensitive. |
| `token` | The token used to authenticate with the cluster. Sensitive. |
| `cluster_ca_certificate` | The certificate authority used to verify the cluster's API server. Sensitive. |
