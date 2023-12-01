pipeline "create_pubsub_subscriptions" {
  title       = "Create Pub/Sub Subscriptions"
  description = "This pipeline creates Pub/Sub subscriptions in a GCP project."

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
    type        = list(string)
    description = "The names of the subscriptions to create."
  }

  param "topic_name" {
    type        = string
    description = "The name of the topic to subscribe to."
  }

  step "container" "create_pubsub_subscriptions" {
    image = "my-gcloud-image-latest"
    cmd   = concat(["pubsub", "subscriptions", "create"], param.subscription_names, ["--topic", param.topic_name])
    env = {
      GCP_CREDS      = file(param.application_credentials_path),
      GCP_PROJECT_ID = param.project_id,
    }
  }

  output "subscriptions" {
    description = "The JSON output from the GCP CLI."
    value       = jsondecode(step.container.create_pubsub_subscriptions.stdout)
  }
}