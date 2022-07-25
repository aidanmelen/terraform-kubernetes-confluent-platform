variable "name" {
  type        = string
  description = "The name for the confluent operator."
  default     = "confluent-operator"
}

variable "namespace" {
  type        = string
  description = "The namespace to install the release into."
  default     = "confluent"
}

variable "create_namespace" {
  type        = bool
  description = "Create the namespace if it does not yet exist."
  default     = false
}

variable "repository" {
  type        = string
  description = "Repository URL where to locate the requested chart."
  default     = "https://packages.confluent.io/helm"
}

variable "chart" {
  type        = string
  description = "Chart name to be installed. The chart name can be local path, a URL to a chart, or the name of the chart if `repository` is specified. It is also possible to use the `<repository>/<chart>` format here if you are running Terraform on a system that the repository has been added to with `helm repo add` but this is not recommended."
  default     = "confluent-for-kubernetes"
}

variable "chart_version" {
  type        = string
  description = "Specify the exact chart version to install. If this is not specified, the latest version is installed."
  default     = "0.517.12"
}

variable "wait_for_jobs" {
  type        = bool
  description = "If wait is enabled, will wait until all Jobs have been completed before marking the release as successful. It will wait for as long as `timeout`."
  default     = true
}
