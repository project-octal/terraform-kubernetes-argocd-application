terraform {
  required_version = ">= 0.14.8, < 2.0.0"
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}
