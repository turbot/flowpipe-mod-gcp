pipeline "create_pubsub_topics" {
  param "application_credentials_64" {
    type        = "string"
    default     = var.application_credentials_64
    description = "The GCP application credentials."
  }

  param "project_id" {
    type        = "string"
    default     = var.project_id
    description = "The GCP project ID."
  }

  param "labels" {
    type        = "map(string)"
    optional    = true
    description = "The GCP labels."
    // default = { "owner" = "1234"
    //   "env" = "dev"
    // }
  }

  param "topic_names" {
    type        = "list(string)"
    default     = ["my-topic-1", "my-topic-2"]
    description = "The names of the topics to create."
  }

  step "container" "create_pubsub_topics" {
    image = "my-gcloud-image-latest"
    cmd = concat(["pubsub", "topics", "create"],
      param.topic_names,
      param.labels != null ? ["--labels", join(",", [for key, value in param.labels : "${key}=${value}"])] : []
    )
    env = {
      GCP_CREDS : param.application_credentials_64,
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    value = jsondecode(step.container.create_pubsub_topics.stdout)
  }
  output "stderr" {
    value = step.container.create_pubsub_topics.stderr
  }
}