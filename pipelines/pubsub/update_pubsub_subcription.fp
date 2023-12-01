pipeline "update_pubsub_subscription" {
  title       = "Update GCP Pub/Sub Subscriptions"
  description = "This pipeline updates the labels on a GCP Pub/Sub subscription."

  param "application_credentials_path" {
    type        = string
    description = local.application_credentials_path_param_description
    default     = var.application_credentials_path
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
    default     = var.project_id
  }

  param "subscription_name" {
    type        = string
    description = "The name of the subscription to update."
  }

  param "update_labels" {
    type        = map(string)
    description = "The GCP labels to update or add to the subscription."
    optional    = true
  }

  param "remove_labels" {
    type        = list(string)
    description = "The names of labels to remove from the subscription."
    optional    = true
  }

  step "container" "update_pubsub_subscription" {
    image = "my-gcloud-image-latest"
    cmd = concat(["pubsub", "subscriptions", "update", param.subscription_name],
      param.remove_labels != null ? ["--remove-labels", join(",", param.remove_labels)] : [],
      param.update_labels != null ? ["--update-labels", join(",", [for key, value in param.update_labels : "${key}=${value}"])] : []
    )
    env = {
      GCP_CREDS      = file(param.application_credentials_path),
      GCP_PROJECT_ID = param.project_id,
    }
  }

  output "subscription" {
    description = "The JSON output from the GCP CLI."
    value       = jsondecode(step.container.update_pubsub_subscription.stdout)
  }
}
