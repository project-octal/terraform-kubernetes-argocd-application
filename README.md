[![Maintained](https://img.shields.io/badge/Maintained%20by-XOAP-success)](https://xoap.io)
[![Terraform](https://img.shields.io/badge/Terraform-%3E%3D1.1.6-blue)](https://terraform.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# Table of Contents

- [Introduction](#introduction)
- [Guidelines](#guidelines)
- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules)
- [Resources](#resources)
- [Inputs](#inputs)
- [Outputs](#outputs)

---

## Introduction

This is a template for Terraform modules.

It is part of our XOAP Automation Forces Open Source community library to give you a quick start into Infrastructure as Code deployments with Terraform.

We have a lot of Terraform modules that are Open Source and maintained by the XOAP staff.

Please check the links for more info, including usage information and full documentation:

- [XOAP Website](https://xoap.io)
- [XOAP Documentation](https://docs.xoap.io)
- [Twitter](https://twitter.com/xoap_io)
- [LinkedIn](https://www.linkedin.com/company/xoap_io)

---

## Guidelines

We are using the following guidelines to write code and make it easier for everyone to follow a destinctive guideline. Please check these links before starting to work on changes.

[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)

Git Naming Conventions are an important part of the development process. They descrtibe how Branched, Commit Messages, Pull Requests and Tags should look like to make the easily understandebla for everybody in the development chain.

[Git Naming Conventions](https://namingconvention.org/git/)

he Conventional Commits specification is a lightweight convention on top of commit messages. It provides an easy set of rules for creating an explicit commit history; which makes it easier to write automated tools on top of.

[Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)

The better a Pull Request description is, the better a review can understand and decide on how to review the changes. This improves implementation speed and reduces communication between the requester and the reviewer resulting in much less overhead.

[Wiriting A Great Pull Request Description](https://www.pullrequest.com/blog/writing-a-great-pull-request-description/)

Versioning is a crucial part for Terraform Stacks and Modules. Without version tags you cannot clearly create a stable environment and be sure that your latest changes won't crash your production environment (sure it still can happen, but we are trying our best to implement everything that we can to reduce the risk)

[Semantic Versioning](https://semver.org)

Naming Conventions for Terraform resources must be used.

[Terraform Naming Conventions](https://www.terraform-best-practices.com/naming)

---

## Usage

### Installation

For the first ime using this template necessary tools need to be installed.
A script for PowerShell Core is provided under ./build/init.ps1

This script will install following dependencies:

- [pre-commit](https://github.com/pre-commit/pre-commit)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)
- [tflint](https://github.com/terraform-linters/tflint)
- [tfsec](https://github.com/aquasecurity/tfsec)
- [checkov](https://github.com/bridgecrewio/checkov)
- [terrascan](https://github.com/accurics/terrascan)
- [kics](https://github.com/Checkmarx/kics)

This script configures:

- global git template under ~/.git-template
- global pre-commit hooks for prepare-commit-msg and commit-msg under ~/.git-template/hooks
- github actions:
  - linting and checks for pull requests from dev to master/main
  - automatic tagging and release creation on pushes to master/main
  - dependabot updates

It currently supports the automated installation for macOS. Support for Windows and Linux will be available soon.

### Synchronisation

We provided a script under ./build/sync_template.ps1 to fetch the latest changes from this template repository.
Please be aware that this is mainly a copy operation which means all your current changes have to be committed first and after running the script you have to merge this changes into your codebase.

### Configuration

---

<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.11.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_deployment.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_horizontal_pod_autoscaler.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/horizontal_pod_autoscaler) | resource |
| [kubernetes_ingress_v1.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_pod_disruption_budget.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_disruption_budget) | resource |
| [kubernetes_service.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [kubernetes_service_account.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_hosts"></a> [additional\_hosts](#input\_additional\_hosts) | Map of additional hosts to be added to the ingress. | `map(string)` | `{}` | no |
| <a name="input_context"></a> [context](#input\_context) | Default environmental context | <pre>object({<br>    organization = string<br>    environment  = string<br>    account      = string<br>    product      = string<br>    tags         = map(string)<br>  })</pre> | n/a | yes |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Map with environment variables injected to the containers. | `map(any)` | n/a | yes |
| <a name="input_hpa"></a> [hpa](#input\_hpa) | Object with autoscaler limits and requests. | <pre>object({<br>    max_replicas                      = number<br>    min_replicas                      = number<br>    target_cpu_utilization_percentage = number<br>  })</pre> | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | Image name and tag to deploy. | `string` | n/a | yes |
| <a name="input_ingress"></a> [ingress](#input\_ingress) | n/a | <pre>object({<br>    host          = string<br>    ingress_class = optional(string, "kong")<br>    annotations   = optional(map(string), {})<br><br>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name used to identify deployed container and all related resources. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace where resources must be created. | `string` | n/a | yes |
| <a name="input_paths"></a> [paths](#input\_paths) | Object mapping local paths to container paths | `map(any)` | `{}` | no |
| <a name="input_resource_config"></a> [resource\_config](#input\_resource\_config) | Object with resource limits and requests. | <pre>object({<br>    limits = object({<br>      cpu    = string<br>      memory = string<br>    })<br><br>    requests = object({<br>      cpu    = string<br>      memory = string<br>    })<br>  })</pre> | <pre>{<br>  "limits": {<br>    "cpu": "0.5",<br>    "memory": "512Mi"<br>  },<br>  "requests": {<br>    "cpu": "250m",<br>    "memory": "50Mi"<br>  }<br>}</pre> | no |
| <a name="input_service"></a> [service](#input\_service) | n/a | <pre>object({<br>    container_port = number<br>    target_port    = number<br>    type           = string<br>    https_enabled  = bool<br>    annotations    = optional(map(string), {})<br>    healthcheck = object({<br>      path                  = string<br>      initial_delay_seconds = number<br>      timeout_seconds       = number<br>      success_threshold     = number<br>      failure_threshold     = number<br>      period_seconds        = number<br>    })<br>  })</pre> | `null` | no |
| <a name="input_service_account_annotations"></a> [service\_account\_annotations](#input\_service\_account\_annotations) | Annotations to be added to the service account resource. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_deployment"></a> [deployment](#output\_deployment) | n/a |
| <a name="output_ingress"></a> [ingress](#output\_ingress) | n/a |
| <a name="output_name"></a> [name](#output\_name) | The name of the resources |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The namespace where the resources will be created |
| <a name="output_service"></a> [service](#output\_service) | n/a |
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- markdownlint-disable -->
<!-- prettier-ignore-end -->
