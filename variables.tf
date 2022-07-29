variable "create" {
  description = "Controls if the Confluent Platform resources should be created (affects all resources)."
  type        = bool
  default     = true
}

variable "namespace" {
  description = "The namespace to release Confluent Platform into. Must be the same namespace running the Confluent Operator."
  type        = string
  default     = "confluent"
}

variable "confluent_operator_app_version" {
  description = "The default Confluent Operator app version. This version may be overriden by component override values. This version must be compatible with the confluent operator app version. For more information, please visit: https://docs.confluent.io/platform/current/installation/versions-interoperability.html#confluent-operator"
  type        = string
  default     = "2.4.0"
}

variable "confluent_platform_version" {
  description = "The default Confluent Platform app version. This version may be overriden by component override values. This version must be compatible with the confluent operator app version. For more information, please visit: https://docs.confluent.io/platform/current/installation/versions-interoperability.html#confluent-operator"
  type        = string
  default     = "7.2.0"
}

variable "create_zookeeper" {
  description = "Whether to create the Zookeeper component of the Confluent Platform."
  type        = bool
  default     = true
}

variable "zookeeper" {
  description = "The Zookeeper override values."
  type        = any
  default     = null
}

variable "create_kafka" {
  description = "Whether to create the Kafka component of the Confluent Platform."
  type        = bool
  default     = true
}

variable "kafka" {
  description = "The Kafka override values."
  type        = any
  default     = null
}

variable "create_connect" {
  description = "Whether to create the Connect component of the Confluent Platform."
  type        = bool
  default     = true
}

variable "connect" {
  description = "The Connect override values."
  type        = any
  default     = null
}

variable "create_ksqldb" {
  description = "Whether to create the KsqlDB component of the Confluent Platform."
  type        = bool
  default     = true
}

variable "ksqldb" {
  description = "The KsqlDB override values."
  type        = any
  default     = null
}

variable "create_controlcenter" {
  description = "Whether to create the ControlCenter component of the Confluent Platform."
  type        = bool
  default     = true
}

variable "controlcenter" {
  description = "The ControlCenter override values."
  type        = any
  default     = null
}

variable "create_schemaregistry" {
  description = "Whether to create the SchemaRegistry component of the Confluent Platform."
  type        = bool
  default     = true
}

variable "schemaregistry" {
  description = "The SchemaRegistry override values."
  type        = any
  default     = null
}

variable "create_kafkarestproxy" {
  description = "Whether to create the KafkaRestProxy component of the Confluent Platform."
  type        = bool
  default     = true
}

variable "kafkarestproxy" {
  description = "The KafkaRestProxy override values."
  type        = any
  default     = null
}
