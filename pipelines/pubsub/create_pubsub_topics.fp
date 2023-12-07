pipeline "create_pubsub_topics" {
  title       = "Create Pub/Sub Topics"
  description = "This pipeline creates Pub/Sub topics in a GCP project."

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

  param "labels" {
    type        = map(string)
    description = "The GCP labels."
    optional    = true
  }

  param "topic_names" {
    type        = list(string)
    description = "The names of the topics to create."
  }

  step "container" "create_pubsub_topics" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(["gcloud", "pubsub", "topics", "create", "--format=json"],
      param.topic_names,
      param.labels != null ? ["--labels", join(",", [for key, value in param.labels : "${key}=${value}"])] : []
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }
}