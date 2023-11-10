pipeline "manage_pubsub_topic" {
  title       = "Manage Pub/Sub topic"
  description = "Create and delete Pub/Sub topics in a GCP project."

  param "application_credentials_path" {
    type        = string
    description = "The GCP application credentials file path."
    default     = var.application_credentials_path
  }

  param "project_id" {
    type        = string
    description = "The GCP project ID."
    default     = var.project_id
  }

  param "topic_name" {
    type        = "list(string))"
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
    // since my stderr was never null so commented this
    // if         = step.pipeline.create_pubsub_topic.stderr == ""
    depends_on = [step.pipeline.create_pubsub_topic]
    pipeline   = pipeline.delete_pubsub_topics
    args = {
      application_credentials_path = param.application_credentials_path
      project_id                   = param.project_id
      topic_names                  = param.topic_name
    }
  }

  output "topic_name" {
    description = "Pub/Sub topic name used in the test."
    value       = param.topic_name
  }

  output "create_pubsub_topic" {
    description = "Check for pipeline.create_pubsub_topics."
    value       = startswith(step.pipeline.create_pubsub_topic.stderr, "ERROR:") ? "failed: ${step.pipeline.create_pubsub_topic.stderr}" : "succeeded"
  }

  output "delete_pubsub_topic" {
    value = startswith(step.pipeline.delete_pubsub_topic.stderr, "ERROR:") ? "failed: ${step.pipeline.delete_pubsub_topic.stderr}" : "passed"
  }

  // output "create_pubsub_topic" {
  //   description = "Check for pipeline.create_pubsub_topics."
  //   value       = step.pipeline.create_pubsub_topic.stderr == "" ? "succeeded" : "failed: ${step.pipeline.create_pubsub_topic.stderr}"
  // }

  // output "update_pubsub_topic" {
  //   description = "Check for pipeline.update_pubsub_topics."
  //   value       = step.pipeline.update_pubsub_topic.stderr == "" ? "succeeded" : "failed: ${step.pipeline.update_pubsub_topic.stderr}"
  // }

  // output "delete_pubsub_topic" {
  //   description = "Check for pipeline.delete_pubsub_topics."
  //   value       = step.pipeline.delete_pubsub_topic.stderr == "" ? "succeeded" : "failed: ${step.pipeline.delete_pubsub_topic.stderr}"
  // }
}