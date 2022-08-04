# confluent_operator

Deploy the Confluent Operator.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

```hcl
module "confluent_operator" {
  source  = "aidanmelen/confluent-platform/kubernetes//modules/confluent_operator"
  version = ">= 0.8.0"

  create_namespace = true
  namespace        = "confluent"
  name             = "confluent-operator"
  chart_version    = "0.517.12"
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.8 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.12.1 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.0.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.12.1 |
## Resources

| Name | Type |
|------|------|
| [helm_release.confluent_operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace_v1.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart"></a> [chart](#input\_chart) | Chart name to be installed. The chart name can be local path, a URL to a chart, or the name of the chart if `repository` is specified. It is also possible to use the `<repository>/<chart>` format here if you are running Terraform on a system that the repository has been added to with `helm repo add` but this is not recommended. | `string` | `"confluent-for-kubernetes"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Specify the exact chart version to install. If this is not specified, the latest version is installed. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls if the Confluent Operator resources should be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The name for the Confluent Operator. | `string` | `"confluent-operator"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to release the Confluent Operator and Confluent Platform into. | `string` | `"confluent"` | no |
| <a name="input_namespace_annotations"></a> [namespace\_annotations](#input\_namespace\_annotations) | The namespace annotations. | `any` | `null` | no |
| <a name="input_namespace_labels"></a> [namespace\_labels](#input\_namespace\_labels) | The namespace labels. | `any` | `null` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Repository URL where to locate the requested chart. | `string` | `"https://packages.confluent.io/helm"` | no |
| <a name="input_set"></a> [set](#input\_set) | List of value blocks with custom values to be merged with the values yaml. | <pre>list(object({<br>    name  = string<br>    value = any<br>    type  = string<br>  }))</pre> | `[]` | no |
| <a name="input_set_sensitive"></a> [set\_sensitive](#input\_set\_sensitive) | List of value blocks with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff.ye | <pre>list(object({<br>    name  = string<br>    value = any<br>    type  = string<br>  }))</pre> | `[]` | no |
| <a name="input_values"></a> [values](#input\_values) | List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. | `list(string)` | `[]` | no |
| <a name="input_wait_for_jobs"></a> [wait\_for\_jobs](#input\_wait\_for\_jobs) | If wait is enabled, will wait until all Jobs have been completed before marking the release as successful. It will wait for as long as `timeout`. | `bool` | `true` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_version"></a> [app\_version](#output\_app\_version) | The Confluent Operator app version. |
| <a name="output_chart_version"></a> [chart\_version](#output\_chart\_version) | The Confluent Operator chart version. |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The namespace for the Confluent Operator. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
