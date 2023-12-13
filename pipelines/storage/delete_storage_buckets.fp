pipeline "delete_storage_buckets" {
  title       = "Delete Storage Buckets"
  description = "This pipeline deletes one or more Cloud Storage buckets."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "bucket_urls" {
    type        = list(string)
    description = "The GCP bucket URLs."
  }

  step "container" "delete_storage_buckets" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = concat(["gcloud", "storage", "buckets", "delete", "--format=json"], param.bucket_urls)
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }
}
