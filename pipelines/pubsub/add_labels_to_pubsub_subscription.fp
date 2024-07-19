pipeline "add_labels_to_pubsub_subscription" {
  title       = "Update Labels on Pub/Sub Subscription"
  description = "This pipeline updates labels on a Google Cloud Pub/Sub subscription."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "subscription_name" {
    type        = string
    description = "The name of the Pub/Sub subscription."
  }

  param "labels" {
    type        = map(string)
    description = "The GCP labels to add or update."
  }

  step "container" "add_labels_to_pubsub_subscription" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "pubsub", "subscriptions", "update", param.subscription_name, "--update-labels", join(",", [for k, v in param.labels : "${k}=${v}"]), "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "subscription" {
    description = "Information about the Pub/Sub subscription."
    value       = jsondecode(step.container.add_labels_to_pubsub_subscription.stdout)
  }
}
