locals {

  labels = merge(var.labels, {

  })

  helm_parameters = [
    for parameter in var.helm_parameters :
    {
      name        = parameter["name"],
      value       = parameter["value"],
      forceString = parameter["force_string"]
    }
  ]

  helm_application = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = var.name
      namespace = var.argocd_namespace
      labels    = local.labels
    }
    finalizers = var.cascade_delete ? ["resources-finalizer.argocd.argoproj.io"] : []
    spec = {
      project = var.project
      source = {
        repoURL        = var.repo_url
        targetRevision = var.target_revision
        chart          = var.chart
        path           = var.path
        helm = {
          version     = var.helm_template_version
          releaseName = var.release_name
          parameters  = local.helm_parameters
          values      = yamlencode(merge(local.labels, var.helm_values))
        }
      }
      destination = {
        server    = var.destination_server
        namespace = var.namespace
      }
      syncPolicy = {
        automated = {
          prune    = var.automated_prune
          selfHeal = var.automated_self_heal
        }
        syncOptions = concat(var.sync_options, [
          var.sync_option_validate ? "Validate=true" : "Validate=false",
          var.sync_option_create_namespace ? "CreateNamespace=true" : "CreateNamespace=false",
        ])
        retry = {
          limit = var.retry_limit
          backoff = {
            duration    = var.retry_backoff_duration
            factor      = var.retry_backoff_factor
            maxDuration = var.retry_backoff_max_duration
          }
        }
      }
      ignoreDifferences = var.ignore_differences
    }
  }
}