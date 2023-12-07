pipeline "test_create_pubsub_topic" {
  title       = "Manage Pub/Sub topic"
  description = "Create and delete Pub/Sub topics in a GCP project."

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

  param "topic_name" {
    type        = list(string)
    description = "The name of the Pub/Sub topic."
  }

  step "pipeline" "create_pubsub_topic" {
    pipeline = pipeline.create_pubsub_topics
    args = {
      application_credentials_path = param.application_credentials_path
      project_id                   = param.project_id
      topic_names                  = param.topic_name
    }
  }

  step "pipeline" "delete_pubsub_topic" {
    depends_on = [step.pipeline.create_pubsub_topic]
    pipeline   = pipeline.delete_pubsub_topics
    args = {
      application_credentials_path = param.application_credentials_path
      project_id                   = param.project_id
      topic_names                  = param.topic_name
    }
  }

  output "create_pubsub_topic" {
    value = !is_error(step.pipeline.create_pubsub_topic) ? "failed" : "succeeded"
  }

  output "delete_pubsub_topic" {
    value = !is_error(step.pipeline.delete_pubsub_topic) ? "failed" : "succeeded"
  }
}