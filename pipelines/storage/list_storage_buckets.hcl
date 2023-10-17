pipeline "list_storage_buckets" {
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

  step "container" "list_storage_buckets" {
    image = "my-gcloud-image"
    cmd   = ["storage", "buckets", "list"]
    env = {
      GCP_CREDS : param.application_credentials_64,
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    value = step.container.list_storage_buckets.stdout
  }
  output "stderr" {
    value = step.container.list_storage_buckets.stderr
  }
}
