pipeline "update_storage_bucket" {
  title       = "Update Storage Bucket"
  description = "This pipeline updates the configuration of a storage bucket, including retention period."

  param "cred" {
    type        = string
    description = "The credential to use for authentication."
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = "The GCP project ID."
  }

  param "bucket_name" {
    type        = string
    description = "The name of the storage bucket to update."
  }

  param "retention_period" {
    type        = string
    description = "The retention period for the storage bucket in seconds. Optional."
    optional    = true
  }

  param "clear_retention_period" {
    type        = bool
    description = "If true, clears the retention period for the storage bucket. Optional."
    optional    = true
  }

  param "lifecycle_policy" {
    type        = string
    description = "The lifecycle policy for the storage bucket. Optional."
    optional    = true
  }

  step "container" "update_storage_bucket" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(["gcloud", "storage", "buckets", "update", "gs://${param.bucket_name}", "--format=json"],
      param.retention_period != null ? ["--retention-period", param.retention_period] : [],
      param.lifecycle_policy != null ? ["--lifecycle-file", param.lifecycle_policy] : [],
      param.clear_retention_period == true? ["--clear-retention-period"] : [])
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }
}
