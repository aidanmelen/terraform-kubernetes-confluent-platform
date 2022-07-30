# The Confluent Platform defaults come from the CFK quickstart deploy example
# https://github.com/confluentinc/confluent-kubernetes-examples/blob/master/quickstart-deploy/confluent-platform.yaml

locals {
  default_zookeeper = yamldecode(
    <<EOF
apiVersion: platform.confluent.io/v1beta1
kind: Zookeeper
metadata:
  name: zookeeper
  namespace: ${var.namespace}
spec:
  replicas: 3
  image:
    application: confluentinc/cp-zookeeper:${var.confluent_platform_version}
    init: confluentinc/confluent-init-container:${var.confluent_operator_app_version}
  dataVolumeCapacity: 10Gi
  logVolumeCapacity: 10Gi
  EOF
  )

  default_kafka = yamldecode(
    <<EOF
apiVersion: platform.confluent.io/v1beta1
kind: Kafka
metadata:
  name: kafka
  namespace: ${var.namespace}
spec:
  replicas: 3
  image:
    application: confluentinc/cp-server:${var.confluent_platform_version}
    init: confluentinc/confluent-init-container:${var.confluent_operator_app_version}
  dataVolumeCapacity: 10Gi
  metricReporter:
    enabled: true
  EOF
  )

  default_connect = yamldecode(
    <<EOF
apiVersion: platform.confluent.io/v1beta1
kind: Connect
metadata:
  name: connect
  namespace: ${var.namespace}
spec:
  replicas: 1
  image:
    application: confluentinc/cp-server-connect:${var.confluent_platform_version}
    init: confluentinc/confluent-init-container:${var.confluent_operator_app_version}
  dependencies:
    kafka:
      bootstrapEndpoint: kafka:9071
  EOF
  )

  default_ksqldb = yamldecode(
    <<EOF
apiVersion: platform.confluent.io/v1beta1
kind: KsqlDB
metadata:
  name: ksqldb
  namespace: ${var.namespace}
spec:
  replicas: 1
  image:
    application: confluentinc/cp-ksqldb-server:${var.confluent_platform_version}
    init: confluentinc/confluent-init-container:${var.confluent_operator_app_version}
  dataVolumeCapacity: 10Gi
  EOF
  )

  default_controlcenter = yamldecode(
    <<EOF
apiVersion: platform.confluent.io/v1beta1
kind: ControlCenter
metadata:
  name: controlcenter
  namespace: ${var.namespace}
spec:
  replicas: 1
  image:
    application: confluentinc/cp-enterprise-control-center:${var.confluent_platform_version}
    init: confluentinc/confluent-init-container:${var.confluent_operator_app_version}
  dataVolumeCapacity: 10Gi
  dependencies:
    schemaRegistry:
      url: http://schemaregistry.confluent.svc.cluster.local:8081
    ksqldb:
    - name: ksqldb
      url: http://ksqldb.confluent.svc.cluster.local:8088
    connect:
    - name: connect
      url: http://connect.confluent.svc.cluster.local:8083
  EOF
  )

  default_schemaregistry = yamldecode(
    <<EOF
apiVersion: platform.confluent.io/v1beta1
kind: SchemaRegistry
metadata:
  name: schemaregistry
  namespace: ${var.namespace}
spec:
  replicas: 3
  image:
    application: confluentinc/cp-schema-registry:${var.confluent_platform_version}
    init: confluentinc/confluent-init-container:${var.confluent_operator_app_version}
  EOF
  )

  default_kafkarestproxy = yamldecode(
    <<EOF
apiVersion: platform.confluent.io/v1beta1
kind: KafkaRestProxy
metadata:
  name: kafkarestproxy
  namespace: ${var.namespace}
spec:
  replicas: 1
  image:
    application: confluentinc/cp-kafka-rest:${var.confluent_platform_version}
    init: confluentinc/confluent-init-container:${var.confluent_operator_app_version}
  dependencies:
    schemaRegistry:
      url: http://schemaregistry.confluent.svc.cluster.local:8081
  EOF
  )

  default_confluent_platform_values = {
    "zookeeper"      = local.default_zookeeper
    "kafka"          = local.default_kafka
    "connect"        = local.default_connect
    "ksqldb"         = local.default_ksqldb
    "controlcenter"  = local.default_controlcenter
    "schemaregistry" = local.default_schemaregistry
    "kafkarestproxy" = local.default_kafkarestproxy
  }

  override_confluent_platform_values = {
    "zookeeper"      = var.zookeeper
    "kafka"          = var.kafka
    "connect"        = var.connect
    "ksqldb"         = var.ksqldb
    "controlcenter"  = var.controlcenter
    "schemaregistry" = var.schemaregistry
    "kafkarestproxy" = var.kafkarestproxy
  }

  create_confluent_platform = {
    "zookeeper"      = var.create_zookeeper
    "kafka"          = var.create_kafka
    "connect"        = var.create_connect
    "ksqldb"         = var.create_ksqldb
    "controlcenter"  = var.create_controlcenter
    "schemaregistry" = var.create_schemaregistry
    "kafkarestproxy" = var.create_kafkarestproxy
  }
}
