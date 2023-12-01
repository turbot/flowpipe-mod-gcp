pipeline "list_pubsub_topics" {
  title       = "List Pub/Sub Topics"
  description = "List all Pub/Sub topics in a GCP project."

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

  step "container" "list_pubsub_topics" {
    image = "my-gcloud-image-latest"
    cmd   = ["pubsub", "topics", "list"]
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "topics" {
    description = "The JSON output from the GCP CLI."
    value       = jsondecode(step.container.list_pubsub_topics.stdout)
  }
}
