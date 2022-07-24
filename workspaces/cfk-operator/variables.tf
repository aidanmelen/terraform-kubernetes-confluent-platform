variable "kubernetes_namespace" {
    description = "The kubernetes namespace name."
    default     = "confluent"
    type        = string
}

variable "should_create_namespace" {
    description = "Whether or not to create a kubernetes namespace."
    default     = true
    type        = bool
}