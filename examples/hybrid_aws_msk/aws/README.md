# aws_msk

Deploy the AWS MSK cluster.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

```hcl
module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = var.name
  description = "Security group for ${var.name}"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = module.vpc.private_subnets_cidr_blocks
  ingress_rules       = ["kafka-broker-tcp", "kafka-broker-tls-tcp"]
}

module "msk_cluster" {
  source  = "clowdhaus/msk-kafka-cluster/aws"
  version = "1.2.0"

  name                   = var.name
  number_of_broker_nodes = 3

  # https://docs.confluent.io/platform/current/installation/versions-interoperability.html#cp-and-apache-ak-compatibility
  kafka_version = "3.2.0"

  broker_node_client_subnets  = module.vpc.private_subnets
  broker_node_ebs_volume_size = 20
  broker_node_instance_type   = "kafka.t3.small"
  broker_node_security_groups = [module.security_group.security_group_id]

  encryption_in_transit_client_broker = "TLS_PLAINTEXT"
  encryption_in_transit_in_cluster    = true

  cloudwatch_logs_enabled = true
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.72 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.0.0 |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | >= 18.0.0 |
| <a name="module_msk_cluster"></a> [msk\_cluster](#module\_msk\_cluster) | clowdhaus/msk-kafka-cluster/aws | 1.2.0 |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | ~> 4.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region name. | `string` | `"us-west-2"` | no |
| <a name="input_name"></a> [name](#input\_name) | The project name. | `string` | `"hybrid-aws-msk"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bootstrap_brokers"></a> [bootstrap\_brokers](#output\_bootstrap\_brokers) | Comma separated list of one or more hostname:port pairs of kafka brokers suitable to bootstrap connectivity to the kafka cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
