pipeline "create_pubsub_topics" {
  title       = "Create Pub/Sub Topics"
  description = "This pipeline creates Pub/Sub topics in a GCP project."

  param "application_credentials_path" {
    type        = string
    description = "The GCP application credentials file path."
    default     = var.application_credentials_path
  }

  param "project_id" {
    type        = string
    description = "The GCP project ID."
    default     = var.project_id
  }

  param "labels" {
    type        = "map(string)"
    description = "The GCP labels."
    optional    = true
  }

  param "topic_names" {
    type        = "list(string)"
    description = "The names of the topics to create."
  }

  step "container" "create_pubsub_topics" {
    image = "my-gcloud-image-latest"
    cmd = concat(["pubsub", "topics", "create"],
      param.topic_names,
      param.labels != null ? ["--labels", join(",", [for key, value in param.labels : "${key}=${value}"])] : []
    )
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = jsondecode(step.container.create_pubsub_topics.stdout)
  }

  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.create_pubsub_topics.stderr
  }
}