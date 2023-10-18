pipeline "update_pubsub_subscriptions" {
  param "application_credentials_64" {
    type        = "string"
    default     = var.application_credentials_64
    description = "The GCP application credentials."
  }

  param "project_id" {
    type        = "string"
    default     = var.project_id
    description = "The GCP project ID."
  }

  param "subscription_name" {
    type        = "string"
    default     = "my-subscription-1"
    description = "The name of the subscription to update."
  }

  param "update_labels" {
    type        = "map(string)"
    description = "The GCP labels to update or add to the subscription."
    default     = { "env" = "prod" }
  }

  param "remove_labels" {
    type        = "list(string)"
    description = "The names of labels to remove from the subscription."
    default     = ["owner"]
  }

  step "container" "update_pubsub_subscriptions" {
    image = "my-gcloud-image-latest"
    cmd = concat(["pubsub", "subscriptions", "update", param.subscription_name,"--remove-labels", join(",", param.remove_labels), "--update-labels"], 
      [join(",", [for key, value in param.update_labels : "${key}=${value}"])]
    )
    env = {
      GCP_CREDS      = param.application_credentials_64,
      GCP_PROJECT_ID = param.project_id,
    }
  }

  output "stdout" {
    value = step.container.update_pubsub_subscriptions.stdout
  }

  output "stderr" {
    value = step.container.update_pubsub_subscriptions.stderr
  }
}
