pipeline "add_labels_to_pubsub_topic" {
  title       = "Add Labels to Pub/Sub Topic"
  description = "This pipeline adds labels to a Google Cloud Pub/Sub topic."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "topic_name" {
    type        = string
    description = "The name of the Pub/Sub topic."
  }

  param "labels" {
    type        = map(string)
    description = "The GCP labels to add."
  }

  step "container" "add_labels_to_pubsub_topic" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "pubsub", "topics", "update", param.topic_name, "--update-labels", join(",", [for k, v in param.labels : "${k}=${v}"]), "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "topic" {
    description = "Information about the Pub/Sub topic."
    value       = jsondecode(step.container.add_labels_to_pubsub_topic.stdout)
  }
}
