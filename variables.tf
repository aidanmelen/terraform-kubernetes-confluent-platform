variable "namespace" {
  type        = string
  description = "The namespace to release Confluent Platform into. Must be the same namespace running the Confluent Operator."
  default     = "confluent"
}

variable "confluent_operator_app_version" {
  type        = string
  description = "The default Confluent Operator app version. This version may be overriden by component override values. This version must be compatible with the confluent operator app version. For more information, please visit: https://docs.confluent.io/platform/current/installation/versions-interoperability.html#confluent-operator"
  default     = "2.4.0"
}

variable "confluent_platform_version" {
  type        = string
  description = "The default Confluent Platform app version. This version may be overriden by component override values. This version must be compatible with the confluent operator app version. For more information, please visit: https://docs.confluent.io/platform/current/installation/versions-interoperability.html#confluent-operator"
  default     = "7.2.0"
}

variable "create_zookeeper" {
  type        = bool
  description = "Whether to create the Zookeeper component of the Confluent Platform."
  default     = true
}

variable "zookeeper" {
  type        = any
  description = "The Zookeeper override values."
  default     = null
}

variable "create_kafka" {
  type        = bool
  description = "Whether to create the Kafka component of the Confluent Platform."
  default     = true
}

variable "kafka" {
  type        = any
  description = "The Kafka override values."
  default     = null
}

variable "create_connect" {
  type        = bool
  description = "Whether to create the Connect component of the Confluent Platform."
  default     = true
}

variable "connect" {
  type        = any
  description = "The Connect override values."
  default     = null
}

variable "create_ksqldb" {
  type        = bool
  description = "Whether to create the KsqlDB component of the Confluent Platform."
  default     = true
}

variable "ksqldb" {
  type        = any
  description = "The KsqlDB override values."
  default     = null
}

variable "create_controlcenter" {
  type        = bool
  description = "Whether to create the ControlCenter component of the Confluent Platform."
  default     = true
}

variable "controlcenter" {
  type        = any
  description = "The ControlCenter override values."
  default     = null
}

variable "create_schemaregistry" {
  type        = bool
  description = "Whether to create the SchemaRegistry component of the Confluent Platform."
  default     = true
}

variable "schemaregistry" {
  type        = any
  description = "The SchemaRegistry override values."
  default     = null
}

variable "create_kafkarestproxy" {
  type        = bool
  description = "Whether to create the KafkaRestProxy component of the Confluent Platform."
  default     = true
}

variable "kafkarestproxy" {
  type        = any
  description = "The KafkaRestProxy override values."
  default     = null
}
