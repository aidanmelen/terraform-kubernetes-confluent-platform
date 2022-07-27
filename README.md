[![Pre-Commit](https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/actions/workflows/pre-commit.yaml)
[![cookiecutter-tf-module](https://img.shields.io/badge/cookiecutter--tf--module-enabled-brightgreen)](https://github.com/aidanmelen/cookiecutter-tf-module)

# terraform-kubernetes-confluent-platform

A Terraform workspace for running [Confluent for Kubernetes (CFK)](https://docs.confluent.io/operator/current/overview.html).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Example

### Confluent Operator

```hcl
# https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/tree/main/examples/confluent_operator
module "confluent_operator" {
  source = "../../"


  # confluent for kubernetes helm chart
  create_namespace                 = true
  namespace                        = "confluent"
  create_confluent_operator        = true
  confluent_operator_name          = "confluent-operator"
  confluent_operator_chart_version = "0.517.12"

  # disable confluent platform components
  create_zookeeper      = false
  create_kafka          = false
  create_connect        = false
  create_ksqldb         = false
  create_controlcenter  = false
  create_schemaregistry = false
  create_kafkarestproxy = false
}
```

### Confluent Platform

```hcl
# https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/tree/main/examples/confluent_platform_singlenode
module "confluent_platform" {
  source    = "../../"
  namespace = "confluent"

  /*
  zookeeper      = { ... }
  kafka          = { ... }
  connect        = { ... }
  ksqldb         = { ... }
  controlcenter  = { ... }
  schemaregistry = { ... }
  kafkarestproxy = { ... }
  */
}
```

## Usage

The Confluent for Kubernetes (CFK) Custom Resource Definitions (CRDs) must be released on the kubernetes cluster before the `terraform-kubernetes-confluent-platform` module is run. The CFK CRDs can be released manually sing the `helm` commandline tool.

```
helm repo add confluentinc https://packages.confluent.io/helm
helm repo update
```

---

Otherwise, the Confluent Operator and Confluent Platform can be deployed using Terraform. This deployment will require two separate Terraform workspace runs similiar to the [Deploy Applications with the Helm Provider](https://learn.hashicorp.com/tutorials/terraform/helm-provider?in=terraform/use-case) tutorial. For example:

1. Apply the `confluent` namespace and release Confluent Operator into it:

```bash
cd examples/confluent_operator
terraform init
terraform apply
```

2. Apply the Confluent Platform:

```bash
cd examples/confluent_platform
terraform init
terraform apply
```

## Teardown

1. Destroy the Confluent Platform:

```bash
cd examples/confluent_platform
terraform destroy
```

2. Uninstall the Confluent Operator and destroy `confluent` namespace:

```bash
cd examples/confluent_operator
terraform destroy
```


## Tests

1. Install [Terraform](https://www.terraform.io/) and make sure it's on your `PATH`.
2. Install [Golang](https://golang.org/) and make sure this code is checked out into your `GOPATH`.
3. `go get github.com/gruntwork-io/terratest/modules/terraform
4. `go mod init test/terraform_confluent_operator_test.go`
5. `cd test`
6. `go test terraform_confluent_operator_test.go -v`
7. `go test terraform_confluent_platform_test.go -v`

Or with the [Makefile](./Makefile)
1. `make install`
2. `make tests`

## Makefile Targets

```
help                      This help.
build                     Build docker dev container
run                       Run docker dev container
install                   Install project
lint                      Lint with pre-commit
lint-all                  Lint with pre-commit
tests                     Test with Terratest
test-confluent-operator   Test confluent-operator Example
test-confluent-platform   Test confluent-platform Example
clean                     Clean project
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
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_connect"></a> [connect](#module\_connect) | Invicton-Labs/deepmerge/null | n/a |
| <a name="module_controlcenter"></a> [controlcenter](#module\_controlcenter) | Invicton-Labs/deepmerge/null | n/a |
| <a name="module_kafka"></a> [kafka](#module\_kafka) | Invicton-Labs/deepmerge/null | n/a |
| <a name="module_kafkarestproxy"></a> [kafkarestproxy](#module\_kafkarestproxy) | Invicton-Labs/deepmerge/null | n/a |
| <a name="module_ksqldb"></a> [ksqldb](#module\_ksqldb) | Invicton-Labs/deepmerge/null | n/a |
| <a name="module_schemaregistry"></a> [schemaregistry](#module\_schemaregistry) | Invicton-Labs/deepmerge/null | n/a |
| <a name="module_zookeeper"></a> [zookeeper](#module\_zookeeper) | Invicton-Labs/deepmerge/null | n/a |
## Resources

| Name | Type |
|------|------|
| [helm_release.confluent_operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_manifest.connect](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.controlcenter](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.kafka](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.kafkarestproxy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.ksqldb](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.schemaregistry](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.zookeeper](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace_v1.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_confluent_operator_chart"></a> [confluent\_operator\_chart](#input\_confluent\_operator\_chart) | Chart name to be installed. The chart name can be local path, a URL to a chart, or the name of the chart if `repository` is specified. It is also possible to use the `<repository>/<chart>` format here if you are running Terraform on a system that the repository has been added to with `helm repo add` but this is not recommended. | `string` | `"confluent-for-kubernetes"` | no |
| <a name="input_confluent_operator_chart_version"></a> [confluent\_operator\_chart\_version](#input\_confluent\_operator\_chart\_version) | Specify the exact chart version to install. If this is not specified, the latest version is installed. | `string` | `null` | no |
| <a name="input_confluent_operator_name"></a> [confluent\_operator\_name](#input\_confluent\_operator\_name) | The name for the confluent operator. | `string` | `"confluent-operator"` | no |
| <a name="input_confluent_operator_repository"></a> [confluent\_operator\_repository](#input\_confluent\_operator\_repository) | Repository URL where to locate the requested chart. | `string` | `"https://packages.confluent.io/helm"` | no |
| <a name="input_confluent_operator_wait_for_jobs"></a> [confluent\_operator\_wait\_for\_jobs](#input\_confluent\_operator\_wait\_for\_jobs) | If wait is enabled, will wait until all Jobs have been completed before marking the release as successful. It will wait for as long as `timeout`. | `bool` | `true` | no |
| <a name="input_connect"></a> [connect](#input\_connect) | The Connect mainfest overrides. | `any` | `null` | no |
| <a name="input_controlcenter"></a> [controlcenter](#input\_controlcenter) | The ControlCenter mainfest overrides. | `any` | `null` | no |
| <a name="input_create_confluent_operator"></a> [create\_confluent\_operator](#input\_create\_confluent\_operator) | Whether to create the Confluent Operator. | `bool` | `false` | no |
| <a name="input_create_connect"></a> [create\_connect](#input\_create\_connect) | Whether to create the Connect component of the Confluent Platform. | `bool` | `true` | no |
| <a name="input_create_controlcenter"></a> [create\_controlcenter](#input\_create\_controlcenter) | Whether to create the ControlCenter component of the Confluent Platform. | `bool` | `true` | no |
| <a name="input_create_kafka"></a> [create\_kafka](#input\_create\_kafka) | Whether to create the Kafka component of the Confluent Platform. | `bool` | `true` | no |
| <a name="input_create_kafkarestproxy"></a> [create\_kafkarestproxy](#input\_create\_kafkarestproxy) | Whether to create the KafkaRestProxy component of the Confluent Platform. | `bool` | `true` | no |
| <a name="input_create_ksqldb"></a> [create\_ksqldb](#input\_create\_ksqldb) | Whether to create the KsqlDB component of the Confluent Platform. | `bool` | `true` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist. | `bool` | `false` | no |
| <a name="input_create_schemaregistry"></a> [create\_schemaregistry](#input\_create\_schemaregistry) | Whether to create the SchemaRegistry component of the Confluent Platform. | `bool` | `true` | no |
| <a name="input_create_zookeeper"></a> [create\_zookeeper](#input\_create\_zookeeper) | Whether to create the Zookeeper component of the Confluent Platform. | `bool` | `true` | no |
| <a name="input_kafka"></a> [kafka](#input\_kafka) | The Kafka mainfest overrides. | `any` | `null` | no |
| <a name="input_kafkarestproxy"></a> [kafkarestproxy](#input\_kafkarestproxy) | The KafkaRestProxy mainfest overrides. | `any` | `null` | no |
| <a name="input_ksqldb"></a> [ksqldb](#input\_ksqldb) | The KsqlDB mainfest overrides. | `any` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to release the Confluent Operator and Confluent Platform into. | `string` | `"confluent"` | no |
| <a name="input_namespace_annotations"></a> [namespace\_annotations](#input\_namespace\_annotations) | The namespace annotations. | `any` | `null` | no |
| <a name="input_namespace_labels"></a> [namespace\_labels](#input\_namespace\_labels) | The namespace labels. | `any` | `null` | no |
| <a name="input_schemaregistry"></a> [schemaregistry](#input\_schemaregistry) | The SchemaRegistry mainfest overrides. | `any` | `null` | no |
| <a name="input_zookeeper"></a> [zookeeper](#input\_zookeeper) | The Zookeeper mainfest overrides. | `any` | `null` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_version"></a> [app\_version](#output\_app\_version) | The CFK version. |
| <a name="output_chart_version"></a> [chart\_version](#output\_chart\_version) | The CFK version. |
| <a name="output_confluent_platform_version_compatibilities"></a> [confluent\_platform\_version\_compatibilities](#output\_confluent\_platform\_version\_compatibilities) | The version compatibilities among Confluent Platform and Confluent for Kubernetes (CFK). |
| <a name="output_connect_manifest"></a> [connect\_manifest](#output\_connect\_manifest) | The Connect manifest. |
| <a name="output_controlcenter_manifest"></a> [controlcenter\_manifest](#output\_controlcenter\_manifest) | The ControlCenter manifest. |
| <a name="output_kafka_manifest"></a> [kafka\_manifest](#output\_kafka\_manifest) | The Kafka manifest. |
| <a name="output_kafkarestproxy_manifest"></a> [kafkarestproxy\_manifest](#output\_kafkarestproxy\_manifest) | The KafkaRestProxy manifest. |
| <a name="output_ksqldb_manifest"></a> [ksqldb\_manifest](#output\_ksqldb\_manifest) | The KsqlDB manifest. |
| <a name="output_latest_confluent_platform_version_compatibility"></a> [latest\_confluent\_platform\_version\_compatibility](#output\_latest\_confluent\_platform\_version\_compatibility) | The latest version compatibile among Confluent Platform and Confluent for Kubernetes (CFK). |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The namespace for the Confluent Platform. |
| <a name="output_schemaregistry_manifest"></a> [schemaregistry\_manifest](#output\_schemaregistry\_manifest) | The SchemaRegistry manifest. |
| <a name="output_zookeeper_manifest"></a> [zookeeper\_manifest](#output\_zookeeper\_manifest) | The Zookeeper manifest. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See [LICENSE](./LICENSE) for full details.
