pipeline "update_pubsub_topics" {
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

  param "remove_labels" {
    type        = "list(string)"
    description = "The GCP labels."
    default     = ["owner"]
  }

  param "update_labels" {
    type        = "map(string)"
    description = "The GCP labels."
    default     = { "env" = "prod" }
  }

  param "topic_name" {
    type        = "string"
    default     = "my-topic-1"
    description = "The names of the topic to update."
  }

  step "container" "update_pubsub_topics" {
    image = "my-gcloud-image-latest"
    cmd = concat(["pubsub", "topics", "update",param.topic_name,"--remove-labels",join(",", param.remove_labels), "--update-labels"],
      [join(",", [for key, value in param.update_labels : "${key}=${value}"])]
    )
    env = {
      GCP_CREDS : param.application_credentials_64,
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    value = step.container.update_pubsub_topics.stdout
  }
  output "stderr" {
    value = step.container.update_pubsub_topics.stderr
  }
}