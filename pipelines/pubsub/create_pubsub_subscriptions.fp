pipeline "create_pubsub_subscriptions" {
  title       = "Create Pub/Sub Subscriptions"
  description = "This pipeline creates one or more Cloud Pub/Sub subscriptions for a given topic. The new subscription defaults to a PULL subscription unless a push endpoint is specified."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "subscription_names" {
    type        = list(string)
    description = "The names of the subscriptions to create."
  }

  param "topic_name" {
    type        = string
    description = "The name of the topic to subscribe to."
  }

  step "container" "create_pubsub_subscriptions" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = concat(["gcloud", "pubsub", "subscriptions", "create", "--format=json"], param.subscription_names, ["--topic", param.topic_name])
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "subscriptions" {
    description = "Information about the created subscriptions."
    value       = jsondecode(step.container.create_pubsub_subscriptions.stdout)
  }
}
