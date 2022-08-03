variable "create" {
  description = "Controls if the Confluent Platform and Operator resources should be created (affects all resources)."
  type        = bool
  default     = true
}

variable "namespace" {
  description = "The namespace to release Confluent Platform into. When `confluent_operator` is specified, this will also ensure the Confluent Operator is released into the same namespace."
  type        = string
  default     = "confluent"
}

################################################################################
# Confluent Operator
################################################################################
variable "confluent_operator" {
  description = "Controls if the Confluent Operator resources should be created. This is required when the Confluent Operator is not already running on the kubernetes cluster."
  type        = any
  default     = { create = true }
}

################################################################################
# Confluent Platform
################################################################################
variable "confluent_operator_app_version" {
  description = "The default Confluent Operator app version. This may be overriden by component override values. This version must be compatible with the `confluent_platform_version`. Please see confluent docs for more information: https://docs.confluent.io/platform/current/installation/versions-interoperability.html#confluent-operator"
  type        = string
  default     = "2.4.0"
}

variable "confluent_platform_version" {
  description = "The default Confluent Platform app version. This may be overriden by component override values. This version must be compatible with the `confluent_operator_app_version`. Please see confluent docs for more information: https://docs.confluent.io/platform/current/installation/versions-interoperability.html#confluent-operator"
  type        = string
  default     = "7.2.0"
}

variable "create_zookeeper" {
  description = "Controls if the Zookeeper component of the Confluent Platform should be created."
  type        = bool
  default     = true
}

variable "zookeeper" {
  description = "The Zookeeper override values."
  type        = any
  default     = {}
}

variable "create_kafka" {
  description = "Controls if the Kafka component of the Confluent Platform should be created."
  type        = bool
  default     = true
}

variable "kafka" {
  description = "The Kafka override values."
  type        = any
  default     = {}
}

variable "create_connect" {
  description = "Controls if the Connect component of the Confluent Platform should be created."
  type        = bool
  default     = true
}

variable "connect" {
  description = "The Connect override values."
  type        = any
  default     = {}
}

variable "create_ksqldb" {
  description = "Controls if the KsqlDB component of the Confluent Platform should be created."
  type        = bool
  default     = true
}

variable "ksqldb" {
  description = "The KsqlDB override values."
  type        = any
  default     = {}
}

variable "create_controlcenter" {
  description = "Controls if the ControlCenter component of the Confluent Platform should be created."
  type        = bool
  default     = true
}

variable "controlcenter" {
  description = "The ControlCenter override values."
  type        = any
  default     = {}
}

variable "create_schemaregistry" {
  description = "Controls if the SchemaRegistry component of the Confluent Platform should be created."
  type        = bool
  default     = true
}

variable "schemaregistry" {
  description = "The SchemaRegistry override values."
  type        = any
  default     = {}
}

variable "create_kafkarestproxy" {
  description = "Controls if the KafkaRestProxy component of the Confluent Platform should be created."
  type        = bool
  default     = true
}

variable "kafkarestproxy" {
  description = "The KafkaRestProxy override values."
  type        = any
  default     = {}
}

variable "kafka_topics" {
  description = "A map of Kafka Topics to create. The key is the topic name and the value are the override values."
  type        = any
  default     = {}
}

variable "connectors" {
  description = "A map of Connectors to create. The key is the connector name and the value are the override values."
  type        = any
  default     = {}
}

variable "create_timeout" {
  description = "The create timeout for each Confluent Platform component."
  type        = string
  default     = "1h"
}

variable "update_timeout" {
  description = "The update timeout for each Confluent Platform component."
  type        = string
  default     = "1h"
}

variable "delete_timeout" {
  description = "The delete timeout for each Confluent Platform component."
  type        = string
  default     = "10m"
}
