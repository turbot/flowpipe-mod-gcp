pipeline "update_pubsub_subscription" {
  title       = "Update Pub/Sub Subscriptions"
  description = "This pipeline updates an existing Cloud Pub/Sub subscription."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "subscription_name" {
    type        = string
    description = "The name of the subscription to update."
  }

  param "update_labels" {
    type        = map(string)
    description = "The GCP labels to update or add to the subscription."
    optional    = true
  }

  param "remove_labels" {
    type        = list(string)
    description = "The names of labels to remove from the subscription."
    optional    = true
  }

  step "container" "update_pubsub_subscription" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(["gcloud", "pubsub", "subscriptions", "update", param.subscription_name, "--format=json"],
      param.remove_labels != null ? ["--remove-labels", join(",", param.remove_labels)] : [],
      param.update_labels != null ? ["--update-labels", join(",", [for key, value in param.update_labels : "${key}=${value}"])] : []
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "subscription" {
    description = "Information about the updated subscription."
    value       = jsondecode(step.container.update_pubsub_subscription.stdout)
  }
}
