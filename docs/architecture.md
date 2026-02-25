# Architecture: terraform-digitalocean-kubernetes

## Overview

This module provisions a DigitalOcean Kubernetes Service (DOKS) cluster along with its default (critical) node pool and any additional application node pools. It also writes the cluster kubeconfig to a local file via `kubeconfig.tf`. The module is designed to be composed with the VPC module and optionally the firewall module to form a complete, network-isolated Kubernetes environment.

## DOKS Overview

DigitalOcean Kubernetes Service is a managed Kubernetes offering where DigitalOcean manages the control plane (API server, etcd, scheduler, controller manager). Users are responsible for node pool sizing, version selection, and workload deployment. Key DOKS characteristics:

- Control plane is fully managed and not billed as compute.
- Node pools are regular droplets visible in the account.
- High-availability control plane (`ha = true`) distributes the API server across multiple nodes and is recommended for production.
- The cluster version (`cluster_version`) must be a valid DOKS slug (e.g., `1.31.1-do.5`); patch upgrades are available through auto-upgrade or manual rollout.

## Node Pool Architecture

This module uses a two-tier node pool design:

### Critical Node Pool (`critical_node_pool`)

The critical node pool is the default node pool required by every DOKS cluster. It is defined inside the `digitalocean_kubernetes_cluster` resource and cannot be removed without destroying the cluster. Intended use:

- Run system-level workloads (CoreDNS, metrics-server, CSI drivers).
- Apply a `NoSchedule` taint so application workloads are not scheduled here.
- Size conservatively (`s-2vcpu-4gb` or larger in production).

Example configuration:

```hcl
critical_node_pool = {
  critical_node = {
    node_count = 3
    min_nodes  = 3
    max_nodes  = 6
    size       = "s-2vcpu-4gb"
    labels     = { tier = "critical" }
    taint = [{
      key    = "tier"
      value  = "critical"
      effect = "NoSchedule"
    }]
  }
}
```

### Application Node Pools (`app_node_pools`)

Application node pools are created as separate `digitalocean_kubernetes_node_pool` resources and can be added, resized, or removed independently of the cluster. Define one pool per workload tier (e.g., `web`, `workers`, `gpu`).

```hcl
app_node_pools = {
  app_node = {
    node_count = 2
    min_nodes  = 2
    max_nodes  = 10
    size       = "s-2vcpu-4gb"
    labels     = { tier = "application" }
  }
}
```

## Auto-Scaling Configuration

Both pool types support DOKS built-in auto-scaling:

| Variable | Effect |
|----------|--------|
| `auto_scale = true` | Enables horizontal node auto-scaling. `node_count` is ignored; DOKS manages it. |
| `min_nodes` | Minimum number of nodes the auto-scaler will maintain. |
| `max_nodes` | Maximum number of nodes the auto-scaler will provision. |

When `auto_scale = true`, do not set `node_count` — the module passes `null` for that field to let DOKS control the current count.

## VPC-Isolated Cluster Networking

Passing `vpc_uuid` places all cluster nodes on the private VPC network. Nodes receive private IP addresses from the VPC CIDR and communicate with each other without traversing the public internet. The control plane endpoint remains public (protected by Kubernetes RBAC and the kubeconfig token) unless a private endpoint is configured separately.

Dependency wiring:

```hcl
module "vpc" {
  source      = "terraform-do-modules/vpc/digitalocean"
  version     = "1.0.0"
  region      = "blr1"
  ip_range    = "10.10.0.0/16"
}

module "cluster" {
  source   = "terraform-do-modules/kubernetes/digitalocean"
  version  = "1.0.0"
  vpc_uuid = module.vpc.id
  # ...
}
```

The VPC CIDR must not overlap with the cluster overlay network (`cluster_subnet`) or service CIDR (`service_subnet`), which DOKS assigns automatically.

## kubeconfig Output

`kubeconfig.tf` writes the raw kubeconfig to the local filesystem at the path set by `kubeconfig_path` (default `./kubeconfig`). Use this file with `kubectl`:

```sh
export KUBECONFIG=./kubeconfig
kubectl get nodes
```

The `local_file`, `token`, and `cluster_ca_certificate` outputs are marked sensitive and will not appear in `terraform output` without the `-raw` or `-json` flag. Store the kubeconfig in a secrets manager rather than committing it to version control.

## SOC 2 Baseline Example

The `_examples/soc2-baseline` example demonstrates a production-grade configuration suitable as a starting point for SOC 2 audit evidence:

- High-availability control plane (`ha = true`)
- Auto-upgrade disabled for controlled rollout waves
- Maintenance window restricted to off-peak hours (`sunday 03:00`)
- Tags including `control:soc2-baseline` and `evidence:required` for audit trail
- Critical pool with a `NoSchedule` taint to isolate system workloads
- Application pool with minimum 2 nodes and autoscaling up to 10

Reference: `_examples/soc2-baseline/main.tf`

## Operational Checklist

- Pin `cluster_version` to a specific DOKS slug and upgrade through a tested rollout process; do not rely on auto-upgrade in production.
- Enable `ha = true` for all production clusters to avoid a single control plane failure impacting API availability.
- Set a taint on the critical node pool so application pods are not accidentally scheduled on system nodes.
- Do not commit the generated `./kubeconfig` file to version control; add it to `.gitignore`.
- Rotate kubeconfig tokens regularly or use short-lived credentials via the DigitalOcean API.
- Scale node pools through Terraform rather than the DigitalOcean console to avoid state drift.
- Define `maintenance_policy` explicitly when `auto_upgrade = true` to control when node replacements occur.
- Use separate `app_node_pools` entries per workload tier so pools can be resized or deleted independently.
- Pass `registry_integration = true` only after creating a DigitalOcean Container Registry in the same account.
