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