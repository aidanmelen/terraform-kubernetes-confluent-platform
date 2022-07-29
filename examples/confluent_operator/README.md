# confluent_operator

Deploy the Confluent Operator. This Terraforms [Step 1,2 from the Confluent for Kubernetes Quickstart](https://docs.confluent.io/operator/current/co-quickstart.html).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

```hcl
module "confluent_operator" {
  source  = "aidanmelen/confluent-platform/kubernetes//modules/confluent_operator"
  version = ">= 0.3.0"

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
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_confluent_operator"></a> [confluent\_operator](#module\_confluent\_operator) | aidanmelen/confluent-platform/kubernetes//modules/confluent_operator | >= 0.3.0 |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_confluent_operator"></a> [confluent\_operator](#output\_confluent\_operator) | The Confluent Operator outputs. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
