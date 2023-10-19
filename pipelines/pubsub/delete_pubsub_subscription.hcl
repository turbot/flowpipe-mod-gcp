pipeline "delete_pubsub_subscriptions" {
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

  param "subscription_names" {
    type        = "list(string)"
    default     = ["my-subscription-1", "my-subscription-2"]
    description = "The names of the subscriptions to delete."
  }

  step "container" "delete_pubsub_subscriptions" {
    image = "my-gcloud-image-latest"
    cmd   = concat(["pubsub", "subscriptions", "delete"], param.subscription_names)
    env = {
      GCP_CREDS : param.application_credentials_64,
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    value = step.container.delete_pubsub_subscriptions.stdout
  }
  output "stderr" {
    value = step.container.delete_pubsub_subscriptions.stderr
  }
}