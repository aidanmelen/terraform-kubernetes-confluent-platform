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
