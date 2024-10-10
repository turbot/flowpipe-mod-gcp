pipeline "delete_pubsub_subscriptions" {
  title       = "Delete Pub/Sub Subscriptions"
  description = "This pipeline deletes one or more Cloud Pub/Sub subscriptions."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "subscription_names" {
    type        = list(string)
    description = "The names of the subscriptions to delete."
  }

  step "container" "delete_pubsub_subscriptions" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = concat(["gcloud", "pubsub", "subscriptions", "delete", "--format=json"], param.subscription_names)
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }
}
