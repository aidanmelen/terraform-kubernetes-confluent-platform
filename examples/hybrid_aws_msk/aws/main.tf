module "msk_cluster_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = var.name
  description = "Security group for ${var.name}"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = module.vpc.private_subnets_cidr_blocks
  ingress_rules       = ["kafka-broker-tcp", "kafka-broker-tls-tcp"]

  # https://github.com/terraform-aws-modules/terraform-aws-security-group/pull/248
  ingress_with_cidr_blocks = [
    {
      from_port   = 9098
      to_port     = 9098
      protocol    = "tcp"
      description = "kafka-broker-sasl-iam-tcp"
      cidr_blocks = join(",", module.vpc.private_subnets_cidr_blocks)
    }
  ]
}

module "msk_cluster" {
  source = "github.com/aidanmelen/terraform-aws-msk-kafka-cluster?ref=v1.3.0"

  # https://github.com/clowdhaus/terraform-aws-msk-kafka-cluster/pull/4
  # source  = "clowdhaus/msk-kafka-cluster/aws"
  # version = "1.3.0"

  name                   = var.name
  number_of_broker_nodes = 3

  # https://docs.confluent.io/platform/current/installation/versions-interoperability.html#cp-and-apache-ak-compatibility
  kafka_version = "3.2.0"

  broker_node_client_subnets  = module.vpc.private_subnets
  broker_node_ebs_volume_size = 20
  broker_node_instance_type   = "kafka.t3.small"
  broker_node_security_groups = [module.msk_cluster_security_group.security_group_id]

  encryption_in_transit_client_broker = "TLS_PLAINTEXT"
  encryption_in_transit_in_cluster    = true

  client_unauthenticated_access_enabled = true
  client_authentication_sasl_iam        = true
  client_authentication_sasl_scram      = false

  cloudwatch_logs_enabled = true
}
