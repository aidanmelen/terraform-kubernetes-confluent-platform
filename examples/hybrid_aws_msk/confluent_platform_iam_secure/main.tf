resource "kubernetes_service_account_v1" "aws_msk_full_access" {
  metadata {
    name      = "aws-msk-full-access"
    namespace = module.confluent_platform.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = data.aws_iam_role.aws_msk_full_access.arn
    }
  }
}

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

  # TODO implement aws msk iam auth for the following components
  create_controlcenter  = var.create_controlcenter
  create_ksqldb         = false
  create_schemaregistry = false
  kafkarestproxy        = false

  connect = yamldecode(<<-EOF
    spec:
      image:
        application: aidanmelen/cp-server-connect-with-aws-msk-iam-auth:${var.confluent_platform_version}
      tls:
        autoGeneratedCerts: true
      configOverrides:
        server:
          - "security.protocol=SASL_SSL"
          - "sasl.mechanism=AWS_MSK_IAM"
          - "sasl.jaas.config=software.amazon.msk.auth.iam.IAMLoginModule required;"
          - "sasl.client.callback.handler.class=software.amazon.msk.auth.iam.IAMClientCallbackHandler"
      podTemplate:
        # envVars:
        #   - name: CLASSPATH
        #     value: /usr/share/java/aws-msk-iam-auth-1.1.4-all.jar
        securityContext:
          serviceAccountName: ${kubernetes_service_account_v1.aws_msk_full_access.metadata[0].name}
      dependencies:
        kafka:
          bootstrapEndpoint: ${data.aws_msk_cluster.msk.bootstrap_brokers_sasl_iam}
          tls:
            enabled: true
            ignoreTrustStoreConfig: true
    EOF
  )

  # ksqldb = yamldecode(<<-EOF
  #   spec:
  #     # https://docs.confluent.io/operator/current/co-troubleshooting.html#issue-ksqldb-cannot-use-auto-generated-certificates-for-ccloud
  #     # tls:
  #     #   autoGeneratedCerts: true
  #     configOverrides:
  #       server:
  #         - "security.protocol=SSL"
  #     dependencies:
  #       kafka:
  #         bootstrapEndpoint: ${data.aws_msk_cluster.msk.bootstrap_brokers_sasl_iam}
  #         tls:
  #           enabled: true
  #           ignoreTrustStoreConfig: true
  #   EOF
  # )

  # controlcenter = yamldecode(<<-EOF
  #   spec:
  #     tls:
  #       autoGeneratedCerts: true
  #     configOverrides:
  #       server:
  #         - "security.protocol=SSL"
  #     dependencies:
  #       kafka:
  #         bootstrapEndpoint: ${data.aws_msk_cluster.msk.bootstrap_brokers_sasl_iam}
  #         tls:
  #           enabled: true
  #           ignoreTrustStoreConfig: true
  #       schemaRegistry:
  #         url: https://schemaregistry.${var.namespace}.svc.cluster.local:8081
  #         tls:
  #           enabled: true
  #       ksqldb:
  #       - name: ksql-dev
  #         url: http://ksqldb.${var.namespace}.svc.cluster.local:8088
  #         tls:
  #           enabled: true
  #       connect:
  #       - name: connect-dev
  #         url:  https://connect.${var.namespace}.svc.cluster.local:8083
  #         tls:
  #           enabled: true
  #   EOF
  # )

  # schemaregistry = yamldecode(<<-EOF
  #   spec:
  #     configOverrides:
  #       server:
  #         - "security.protocol=SSL"
  #     tls:
  #       autoGeneratedCerts: true
  #     dependencies:
  #       kafka:
  #         bootstrapEndpoint: ${data.aws_msk_cluster.msk.bootstrap_brokers_sasl_iam}
  #         tls:
  #           enabled: true
  #           ignoreTrustStoreConfig: true
  #   EOF
  # )

  # kafkarestproxy = yamldecode(<<-EOF
  #   spec:
  #     configOverrides:
  #       server:
  #         - "security.protocol=SSL"
  #     tls:
  #       autoGeneratedCerts: true
  #     dependencies:
  #       kafka:
  #         bootstrapEndpoint: ${data.aws_msk_cluster.msk.bootstrap_brokers_sasl_iam}
  #         tls:
  #           enabled: true
  #           ignoreTrustStoreConfig: true
  #       schemaRegistry:
  #         url: https://schemaregistry.${var.namespace}.svc.cluster.local:8081
  #         tls:
  #           enabled: true
  #   EOF
  # )
}
