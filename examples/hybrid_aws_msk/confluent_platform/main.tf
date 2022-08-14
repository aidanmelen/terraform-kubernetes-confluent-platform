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
