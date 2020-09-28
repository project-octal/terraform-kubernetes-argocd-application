resource "k8s_manifest" "argo_application" {
  content = yamlencode(local.helm_application)
}