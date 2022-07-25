[![Pre-Commit](https://github.com/aidanmelen/terraform-kubernetes-confluent/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/aidanmelen/terraform-kubernetes-confluent/actions/workflows/pre-commit.yaml)
[![cookiecutter-tf-module](https://img.shields.io/badge/cookiecutter--tf--module-enabled-brightgreen)](https://github.com/aidanmelen/cookiecutter-tf-module)
[![StandWithUkraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

# terraform-confluent-for-kubernetes

A Terraform workspace for running [Confluent for Kubernetes (CFK)](https://docs.confluent.io/operator/current/overview.html).

Please see [confluent-kubernetes-examples](https://github.com/confluentinc/confluent-kubernetes-examples) Github repository for more CFK examples.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Usage

Recreate the Kubernetes RBAC examples from the [Using RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) documentation.

```hcl
locals {
  labels = {
    "terraform-example"            = "ex-${replace(basename(path.cwd), "_", "-")}"
    "app.kubernetes.io/managed-by" = "Terraform"
    "terraform.io/module"          = "terraform-kubernetes-rbac"
  }
}

resource "kubernetes_namespace" "development" {
  metadata {
    name   = "development"
    labels = local.labels
  }
}

module "rbac" {
  # source = "aidan-melen/rbac/kubernetes"
  source = "../../"

  labels = local.labels

  roles = {
    # https://kubernetes.io/docs/reference/access-authn-authz/rbac/#role-example
    # https://kubernetes.io/docs/reference/access-authn-authz/rbac/#rolebinding-example
    "pod-reader" = {
      role_namespace = "default"
      role_rules = [
        {
          api_groups = [""]
          resources  = ["pods"]
          verbs      = ["get", "watch", "list"]
        },
      ]

      # This role binding allows "jane" to read pods in the "default" namespace.
      # You need to already have a Role named "pod-reader" in that namespace.
      role_binding_name = "read-pods"
      role_binding_subjects = [
        {
          kind     = "User"
          name     = "jane" # Name is case sensitive
          apiGroup = "rbac.authorization.k8s.io"
        }
      ]
    },
  }

  cluster_roles = {
    # https://kubernetes.io/docs/reference/access-authn-authz/rbac/#clusterrole-example
    # https://kubernetes.io/docs/reference/access-authn-authz/rbac/#rolebinding-example
    "secret-reader" = {
      # at the HTTP level, the name of the resource for accessing Secret
      # objects is "secrets"
      # "namespace" omitted since ClusterRoles are not namespaced
      cluster_role_rules = [
        {
          api_groups = [""]
          resources  = ["secrets"]
          verbs      = ["get", "watch", "list"]
        },
      ]

      role_binding_name = "read-secret"
      # The namespace of the RoleBinding determines where the permissions are granted.
      # This only grants permissions within the "development" namespace.
      role_binding_namespace = kubernetes_namespace.development.metadata[0].name
      role_binding_subjects = [
        {
          kind     = "User"
          name     = "dave" # Name is case sensitive
          apiGroup = "rbac.authorization.k8s.io"
        }
      ]
    },

    # https://kubernetes.io/docs/reference/access-authn-authz/rbac/#clusterrole-example
    # https://kubernetes.io/docs/reference/access-authn-authz/rbac/#clusterrolebinding-example
    "secret-reader-global" = {
      # "namespace" omitted since ClusterRoles are not namespaced
      cluster_role_rules = [
        {
          api_groups = [""]
          resources  = ["secrets"]
          verbs      = ["get", "watch", "list"]
        },
      ]

      # This cluster role binding allows anyone in the "manager" group to read secrets in any namespace.
      cluster_role_binding_name = "read-secrets-global"
      cluster_role_binding_subjects = [
        {
          kind     = "Group"
          name     = "manager" # Name is case sensitive
          apiGroup = "rbac.authorization.k8s.io"
        }
      ]
    }
  }
}

module "pre_existing" {
  # source = "aidan-melen/rbac/kubernetes"
  source = "../../"

  cluster_roles = {
    "cluster-admin" = {
      create_cluster_role       = false
      cluster_role_binding_name = "cluster-admin-global"
      cluster_role_binding_subjects = [
        {
          kind = "User"
          name = "bob"
        }
      ]
    }
  }
}
```

Please see the [rbac example](examples/rbac) for more information.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.7.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cluster_roles"></a> [cluster\_roles](#module\_cluster\_roles) | ./modules/rbac | n/a |
| <a name="module_roles"></a> [roles](#module\_roles) | ./modules/rbac | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_annotations"></a> [annotations](#input\_annotations) | The global annotations. Applied to all resources. | `map(string)` | `{}` | no |
| <a name="input_cluster_roles"></a> [cluster\_roles](#input\_cluster\_roles) | Map of cluster role and cluster/role binding definitions to create. | `any` | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether the Authorization and RBAC resources should be created (affects all resources). | `bool` | `true` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | The global labels. Applied to all resources. | `map(string)` | `{}` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | Map of role and role binding definitions to create. | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_roles"></a> [cluster\_roles](#output\_cluster\_roles) | The cluster roles. |
| <a name="output_roles"></a> [roles](#output\_roles) | The roles. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See [LICENSE](https://github.com/aidanmelen/terraform-aws-eks-auth/tree/master/LICENSE) for full details.
