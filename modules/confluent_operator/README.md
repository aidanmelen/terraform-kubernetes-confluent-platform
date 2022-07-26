# terraform-kubernetes-confluent-platform/confluent_operator

Confluent Operator submodule.

## Example

```hcl
module "confluent_operator" {
  source           = "aidanmelen/kubernetes/conlfuent_platform//modules/confluent_operator"
  name             = "confluent-operator"
  namespace        = "confluent"
  create_namespace = true
  chart_version    = "0.517.12"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.confluent_operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart"></a> [chart](#input\_chart) | Chart name to be installed. The chart name can be local path, a URL to a chart, or the name of the chart if `repository` is specified. It is also possible to use the `<repository>/<chart>` format here if you are running Terraform on a system that the repository has been added to with `helm repo add` but this is not recommended. | `string` | `"confluent-for-kubernetes"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Specify the exact chart version to install. If this is not specified, the latest version is installed. | `string` | `null` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The name for the confluent operator. | `string` | `"confluent-operator"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to release the confluent operator into. | `string` | `"confluent"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Repository URL where to locate the requested chart. | `string` | `"https://packages.confluent.io/helm"` | no |
| <a name="input_wait_for_jobs"></a> [wait\_for\_jobs](#input\_wait\_for\_jobs) | If wait is enabled, will wait until all Jobs have been completed before marking the release as successful. It will wait for as long as `timeout`. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_confluent_platform_version_compatibilities"></a> [confluent\_platform\_version\_compatibilities](#output\_confluent\_platform\_version\_compatibilities) | The following describes the version compatibilities among Confluent Platform and Confluent for Kubernetes (CFK). |
| <a name="output_helm_release"></a> [helm\_release](#output\_helm\_release) | The helm release for the confluent operator. |
| <a name="output_latest_confluent_platform_version_compatibilities"></a> [latest\_confluent\_platform\_version\_compatibilities](#output\_latest\_confluent\_platform\_version\_compatibilities) | The following describes the latest version compatibile among Confluent Platform and Confluent for Kubernetes (CFK). |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See [LICENSE](./LICENSE) for full details.
