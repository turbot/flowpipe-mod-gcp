pipeline "delete_pubsub_topics" {
  title       = "Delete Pub/Sub Topics"
  description = "This pipeline deletes one or more Cloud Pub/Sub topics."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "topic_names" {
    type        = list(string)
    description = "The names of the topics to delete."
  }

  step "container" "delete_pubsub_topics" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = concat(["gcloud", "pubsub", "topics", "delete", "--format=json"], param.topic_names)
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }
}
