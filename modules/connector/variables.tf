variable "name" {
  description = "The Connector name."
  type        = string
}

variable "namespace" {
  description = "The namespace of the Confluent Platform."
  type        = string
  default     = "confluent"
}

variable "class" {
  description = "class specifies the class name of the connector. The Connect cluster displays the supported class names in its status. Required when not overriden by `values`."
  type        = string
  default     = ""
}

variable "config" {
  description = "configs is a map of string key and value pairs. It specifies the additional configurations for the connector. Required when not overriden by `values`."
  type        = any
  default     = {}
}

variable "values" {
  description = "The Connector override values."
  type        = any
  default     = {}
}

variable "create_timeout" {
  description = "The create timeout for each Confluent Platform component."
  type        = string
  default     = "5m"
}

variable "update_timeout" {
  description = "The update timeout for each Confluent Platform component."
  type        = string
  default     = "5m"
}

variable "delete_timeout" {
  description = "The delete timeout for each Confluent Platform component."
  type        = string
  default     = "5m"
}
