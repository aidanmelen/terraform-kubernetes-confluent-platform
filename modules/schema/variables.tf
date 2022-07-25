variable "name" {
  type        = string
  description = "The name for the CFK component."
  default     = "schema"
}

variable "namespace" {
  type        = string
  description = "The kubernetes namespace for the CFK component."
  default     = "confluent"
}

variable "additional_metadata" {
  type        = any
  description = "The additional kubernetes metadata for the CFK component."
  default     = {}
}

variable "computed_fields" {
  type        = list(string)
  description = "The `computed_fields` block for the kubernetes_manifest resource."
  default = [
    "metadata.finalizers"
  ]
}

variable "schema" {
  type        = any
  description = "The schema data."
  default = {
    "namespace" = "io.confluent.examples.clients.basicavro",
    "type"      = "record",
    "name"      = "Payment",
    "fields" = [
      { "name" = "id", "type" = "string" },
      { "name" = "amount", "type" = "double" },
      { "name" = "email", "type" = "string" }
    ]
  }
}

variable "format" {
  type        = string
  description = "The schema format."
  default     = "avro"
}

variable "create_timeout" {
  type        = string
  description = "The create timeout."
  default     = "10m"
}

variable "update_timeout" {
  type        = string
  description = "The update timeout."
  default     = "10m"
}

variable "delete_timeout" {
  type        = string
  description = "The delete timeout."
  default     = "10m"
}
