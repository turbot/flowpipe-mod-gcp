pipeline "create_pubsub_subscriptions" {
  param "application_credentials_path" {
    type        = string
    default     = var.application_credentials_path
    description = "The GCP application credentials file path."
  }

  param "project_id" {
    type        = string
    default     = var.project_id
    description = "The GCP project ID."
  }

  param "subscription_names" {
    type        = "list(string)"
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

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.create_pubsub_subscriptions.stdout
  }
  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.create_pubsub_subscriptions.stderr
  }
}