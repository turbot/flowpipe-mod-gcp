pipeline "list_pubsub_topics" {
  title       = "List Pub/Sub Topics"
  description = "List all Pub/Sub topics in a GCP project."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
    default     = var.project_id
  }

  step "container" "list_pubsub_topics" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "pubsub", "topics", "list", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "topics" {
    description = "Information about the Pub/Sub topics in the project."
    value       = jsondecode(step.container.list_pubsub_topics.stdout)
  }
}
