# confluent_platform

Deploy the Confluent Platform components connected with an AWS MSK cluster over PLAINTEXT. The Confluent Components are also configured with PLAINTEXT.

## Prerequisites

Run Terraform in the `../aws` directory.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

```hcl
module "confluent_platform" {
  source    = "../../../"
  namespace = var.namespace

  # The Confluent Operator was release in ../aws/confluent_operator.tf
  confluent_operator = {
    create = false
  }

  # Both Kafka and Zookeeper were created with AWS MSK in ../aws/main.tf
  create_zookeeper = false
  create_kafka     = false

  create_controlcenter = var.create_controlcenter

  connect = yamldecode(<<-EOF
    spec:
      dependencies:
        kafka:
          bootstrapEndpoint: ${data.aws_msk_cluster.msk.bootstrap_brokers}
    EOF
  )

  ksqldb = yamldecode(<<-EOF
    spec:
      dependencies:
        kafka:
          bootstrapEndpoint: ${data.aws_msk_cluster.msk.bootstrap_brokers}
    EOF
  )

  controlcenter = yamldecode(<<-EOF
    spec:
      dependencies:
        kafka:
          bootstrapEndpoint: ${data.aws_msk_cluster.msk.bootstrap_brokers}
        schemaRegistry:
          url: http://schemaregistry.${var.namespace}.svc.cluster.local:8081
        ksqldb:
        - name: ksql-dev
          url: http://ksqldb.${var.namespace}.svc.cluster.local:8088
        connect:
        - name: connect-dev
          url:  http://connect.${var.namespace}.svc.cluster.local:8083
    EOF
  )

  schemaregistry = yamldecode(<<-EOF
    spec:
      dependencies:
        kafka:
          bootstrapEndpoint: ${data.aws_msk_cluster.msk.bootstrap_brokers}
    EOF
  )

  kafkarestproxy = yamldecode(<<-EOF
    spec:
      dependencies:
        kafka:
          bootstrapEndpoint: ${data.aws_msk_cluster.msk.bootstrap_brokers}
        schemaRegistry:
          url: http://schemaregistry.${var.namespace}.svc.cluster.local:8081
    EOF
  )
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.72 |
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
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to release the Confluent Platform into. | `string` | `"confluent"` | no |
## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
