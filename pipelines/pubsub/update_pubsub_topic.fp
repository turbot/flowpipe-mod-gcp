pipeline "update_pubsub_topic" {
  title       = "Update Pub/Sub Topics"
  description = "This pipeline updates an existing Cloud Pub/Sub topic."

  tags = {
    recommended = "true"
  }

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "remove_labels" {
    type        = list(string)
    description = "The GCP labels."
    optional    = true
  }

  param "update_labels" {
    type        = map(string)
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

  step "container" "update_pubsub_topic" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(["gcloud", "pubsub", "topics", "update", param.topic_name, "--format=json"],
      param.message_retention_duration != null ? ["--message-retention-duration", param.message_retention_duration] : [],
      param.remove_labels != null ? ["--remove-labels", join(",", param.remove_labels)] : [],
      param.update_labels != null ? ["--update-labels", join(",", [for key, value in param.update_labels : "${key}=${value}"])] : []
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "topic" {
    description = "Information about the updated topic."
    value       = jsondecode(step.container.update_pubsub_topic.stdout)
  }
}
