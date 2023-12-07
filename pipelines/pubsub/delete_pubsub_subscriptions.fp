pipeline "delete_pubsub_subscriptions" {
  title       = "Delete Pub/Sub Subscriptions"
  description = "This pipeline deletes Pub/Sub subscriptions in a GCP project."

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

  param "subscription_names" {
    type        = list(string)
    description = "The names of the subscriptions to delete."
  }

  step "container" "delete_pubsub_subscriptions" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = concat(["gcloud", "pubsub", "subscriptions", "delete", "--format=json"], param.subscription_names)
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }
}