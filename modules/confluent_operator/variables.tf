variable "create" {
  description = "Controls if the Confluent Operator resources should be created (affects all resources)"
  type        = bool
  default     = true
}

variable "create_namespace" {
  description = "Create the namespace if it does not yet exist."
  type        = bool
  default     = false
}

variable "namespace" {
  description = "The namespace to release the Confluent Operator and Confluent Platform into."
  type        = string
  default     = "confluent"
}

variable "namespace_annotations" {
  description = "The namespace annotations."
  type        = any
  default     = null
}

variable "namespace_labels" {
  description = "The namespace labels."
  type        = any
  default     = null
}

variable "name" {
  description = "The name for the Confluent Operator."
  type        = string
  default     = "confluent-operator"
}

variable "repository" {
  description = "Repository URL where to locate the requested chart."
  type        = string
  default     = "https://packages.confluent.io/helm"
}

variable "chart" {
  description = "Chart name to be installed. The chart name can be local path, a URL to a chart, or the name of the chart if `repository` is specified. It is also possible to use the `<repository>/<chart>` format here if you are running Terraform on a system that the repository has been added to with `helm repo add` but this is not recommended."
  type        = string
  default     = "confluent-for-kubernetes"
}

variable "chart_version" {
  description = "Specify the exact chart version to install. If this is not specified, the latest version is installed."
  type        = string
  default     = null
}

variable "wait_for_jobs" {
  description = "If wait is enabled, will wait until all Jobs have been completed before marking the release as successful. It will wait for as long as `timeout`."
  type        = bool
  default     = true
}
