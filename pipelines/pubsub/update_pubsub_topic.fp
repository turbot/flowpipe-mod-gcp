pipeline "update_pubsub_topics" {
  title       = "Update GCP Pub/Sub Topics"
  description = "This pipeline updates GCP Pub/Sub Topics."

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

  param "remove_labels" {
    type        = "list(string)"
    description = "The GCP labels."
    optional    = true
  }

  param "update_labels" {
    type        = "map(string)"
    description = "The GCP labels."
    optional    = true
  }

  param "topic_name" {
    type        = string
    description = "The names of the topic to update."
  }

  param "message_retention_duration" {
    type        = string
    description = "The duration to retain messages."
    optional    = true
  }

  step "container" "update_pubsub_topics" {
    image = "my-gcloud-image-latest"
    cmd = concat(["pubsub", "topics", "update", param.topic_name],
      param.message_retention_duration != null ? ["--message-retention-duration", param.message_retention_duration] : [],
      param.remove_labels != null ? ["--remove-labels", join(",", param.remove_labels)] : [],
      param.update_labels != null ? ["--update-labels", join(",", [for key, value in param.update_labels : "${key}=${value}"])] : []
    )
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.update_pubsub_topics.stdout
  }
}