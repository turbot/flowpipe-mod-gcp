pipeline "delete_pubsub_topics" {
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

  param "topic_names" {
    type        = "list(string)"
    description = "The names of the topics to delete."
  }

  step "container" "delete_pubsub_topics" {
    image = "my-gcloud-image-latest"
    cmd   = concat(["pubsub", "topics", "delete"], param.topic_names)
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.delete_pubsub_topics.stdout
  }
  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.delete_pubsub_topics.stderr
  }
}