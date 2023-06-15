variable "argocd_namespace" {
  type        = string
  description = "The name of the target ArgoCD Namespace"
}
variable "repo_url" {
  type        = string
  description = "Source of the Helm application manifests"
}
variable "target_revision" {
  type        = string
  description = "Revision of the Helm application manifests to use"
  default     = ""
}
variable "chart" {
  type        = string
  description = "The name of the Helm chart"
}
variable "path" {
  type        = string
  description = ""
  default     = ""
}
variable "release_name" {
  type        = string
  description = "Release name override (defaults to application name)"
  default     = null
}
variable "helm_parameters" {
  type = list(object({
    name : string,
    value : any,
    force_string : bool,
  }))
  description = "Parameters that will override helm_values"
  default     = []
}
variable "helm_values" {
  type        = any
  description = "Helm values as a block of yaml"
  default     = {}
}
variable "name" {
  type        = string
  description = "The name of this application"
}
variable "project" {
  type        = string
  description = "The project that this ArgoCD application will be placed into."
}
variable "cascade_delete" {
  type        = bool
  description = "Set to true if this application should cascade delete"
  default     = false
}
variable "destination_server" {
  type        = string
  description = ""
  default     = "https://kubernetes.default.svc"
}
variable "namespace" {
  type        = string
  description = ""
}
variable "automated_prune" {
  type        = bool
  description = "Specifies if resources should be pruned during auto-syncing"
  default     = false
}
variable "automated_self_heal" {
  type        = bool
  description = "Specifies if partial app sync should be executed when resources are changed only in target Kubernetes cluster and no git change detected"
  default     = false
}
variable "sync_options" {
  type        = list(string)
  description = "A list of sync options to apply to the application"
  default     = []
}
variable "sync_option_validate" {
  type        = bool
  description = "disables resource validation (equivalent to 'kubectl apply --validate=true')"
  default     = false
}
variable "sync_option_create_namespace" {
  type        = bool
  description = "Namespace Auto-Creation ensures that namespace specified as the application destination exists in the destination cluster."
  default     = true
}
variable "retry_limit" {
  type        = number
  description = "Number of failed sync attempt retries; unlimited number of attempts if less than 0"
  default     = 5
}
variable "retry_backoff_duration" {
  type        = string
  description = "The amount to back off. Default unit is seconds, but could also be a duration (e.g. `2m`, `1h`)"
  default     = "5s"
}
variable "retry_backoff_factor" {
  type        = number
  description = "A factor to multiply the base duration after each failed retry"
  default     = 2
}
variable "retry_backoff_max_duration" {
  type        = string
  description = "The maximum amount of time allowed for the backoff strategy"
  default     = "3m"
}
variable "ignore_differences" {
  type        = list(object({ kind : string, group : string, name : string, jsonPointers : list(string) }))
  description = "Ignore differences at the specified json pointers"
  default     = []
}
variable "labels" {
  type        = map(string)
  description = ""
  default     = {}
}

locals {

  labels = merge({
    # Other labels can go here.
  }, var.labels)

  helm_parameters = [
    for parameter in var.helm_parameters :
    {
      name        = parameter["name"],
      value       = parameter["value"],
      forceString = parameter["force_string"]
    }
  ]
}
