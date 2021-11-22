terraform {
  required_version = ">= 0.13, < 2.0.0"
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}
