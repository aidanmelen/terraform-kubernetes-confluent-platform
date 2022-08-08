# confluent_platform

Deploy the Confluent Platform components connected with an AWS MSK cluster over PLAINTEXT. The Confluent Components are configured with TSL.

## Assumptions

This example assumes you have a Kubernetes cluster running locally on Docker Desktop. Please see [Docker's official documentation](https://docs.docker.com/desktop/kubernetes/) for more information.

## Prerequisites

Release the [Confluent Operator example](https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/tree/main/examples/confluent_operator). This will ensure the CFK CRDs are created and the Confluent Operator pod is running in the `confluent` namespace before releasing the Confluent Platform.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

```hcl
module "confluent_platform" {
  source  = "aidanmelen/confluent-platform/kubernetes"
  version = ">= 0.9.0"

  namespace = var.namespace

  # assumes the confluent operator was deployed in another terraform run
  confluent_operator = {
    create = false
  }

  # uncomment to override the modules default local values
  /*
  zookeeper      = yamldecode(file("${path.module}/values/zookeeper.yaml"))
  kafka          = yamldecode(file("${path.module}/values/kafka.yaml"))
  connect        = yamldecode(file("${path.module}/values/connect.yaml"))
  ksqldb         = yamldecode(file("${path.module}/values/ksqldb.yaml"))
  controlcenter  = yamldecode(file("${path.module}/values/controlcenter.yaml"))
  schemaregistry = yamldecode(file("${path.module}/values/schemaregistry.yaml"))
  kafkarestproxy = yamldecode(file("${path.module}/values/kafkarestproxy.yaml"))
  */

  create_controlcenter = var.create_controlcenter
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.72 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.12.1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0.1 |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_confluent_platform"></a> [confluent\_platform](#module\_confluent\_platform) | ../../../ | n/a |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region name. | `string` | `"us-west-2"` | no |
| <a name="input_create_controlcenter"></a> [create\_controlcenter](#input\_create\_controlcenter) | Controls if the ControlCenter component of the Confluent Platform should be created. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The project name. | `string` | `"hybrid-aws-msk"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to release the Confluent Operator and Confluent Platform into. | `string` | `"confluent"` | no |
## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
