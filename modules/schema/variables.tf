variable "name" {
  description = "The Schema name."
  type        = string
}

variable "namespace" {
  description = "The namespace of the Confluent Platform."
  type        = string
  default     = "confluent"
}

variable "values" {
  description = "The Schema override values."
  type        = any
  default     = {}
}

variable "schema" {
  description = "The Schema data."
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
