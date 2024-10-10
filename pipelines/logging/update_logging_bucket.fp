pipeline "update_logging_bucket" {
  title       = "Update Logging Bucket"
  description = "This pipeline updates the retention period of a Logging Bucket."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = "The GCP project ID."
  }

  param "bucket_id" {
    type        = string
    description = "The ID of the Logging Bucket."
  }

  param "location" {
    type        = string
    description = "The location of the Logging Bucket."
  }

  param "retention_days" {
    type        = string
    description = "Retention period for the logging bucket in days. Optional."
    optional    = true
  }

  step "container" "update_logging_bucket" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = concat(
      ["gcloud", "logging", "buckets", "update", param.bucket_id, "--project", param.project_id, "--location", param.location, "--format=json"],
      param.retention_days != null ? ["--retention-days", param.retention_days] : []
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "result" {
    description = "Result of the logging bucket update command."
    value       = step.container.update_logging_bucket.stdout
  }
}
