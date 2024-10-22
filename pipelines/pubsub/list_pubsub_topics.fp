pipeline "list_pubsub_topics" {
  title       = "List Pub/Sub Topics"
  description = "Lists all of the Cloud Pub/Sub topics that exist in a given project that match the given topic name filter."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  step "container" "list_pubsub_topics" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "pubsub", "topics", "list", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "topics" {
    description = "Information about the Pub/Sub topics in the project."
    value       = jsondecode(step.container.list_pubsub_topics.stdout)
  }
}
