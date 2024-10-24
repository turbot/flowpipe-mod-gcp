pipeline "remove_specific_label_from_pubsub_topic" {
  title       = "Remove Labels from Pub/Sub Topic"
  description = "This pipeline removes specified labels from a Google Cloud Pub/Sub topic."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "topic_name" {
    type        = string
    description = "The name of the Pub/Sub topic."
  }

  param "label_keys" {
    type        = list(string)
    description = "The GCP label keys to remove."
  }

  step "container" "remove_specific_label_from_pubsub_topic" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "pubsub", "topics", "update", param.topic_name, "--remove-labels", join(",", param.label_keys), "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "topic" {
    description = "Information about the Pub/Sub topic."
    value       = jsondecode(step.container.remove_specific_label_from_pubsub_topic.stdout)
  }
}
