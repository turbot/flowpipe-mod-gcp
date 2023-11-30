pipeline "delete_pubsub_subscriptions" {
  title       = "Delete Pub/Sub Subscriptions"
  description = "This pipeline deletes Pub/Sub subscriptions in a GCP project."

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

  param "subscription_names" {
    type        = "list(string)"
    description = "The names of the subscriptions to delete."
  }

  step "container" "delete_pubsub_subscriptions" {
    image = "my-gcloud-image-latest"
    cmd   = concat(["pubsub", "subscriptions", "delete"], param.subscription_names)
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.delete_pubsub_subscriptions.stdout
  }
}