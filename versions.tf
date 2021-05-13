terraform {
  required_version = ">= 0.13"
  required_providers {
    # This should be replaced by https://github.com/hashicorp/terraform-provider-kubernetes-alpha eventually...
    k8s = {
      version = ">= 0.8.0"
      source  = "banzaicloud/k8s"
    }
  }
}
