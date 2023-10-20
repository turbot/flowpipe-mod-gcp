pipeline "create_storage_buckets" {
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

  param "bucket_urls" {
    type        = "list(string)"
    description = "The GCP bucket URLs."
    default     = ["gs://integrated-test-2023", "gs://integrated-test-pri"]
  }

  step "container" "create_storage_buckets" {
    image = "my-gcloud-image-latest"
    cmd   = concat(["storage", "buckets", "create"], param.bucket_urls)
    env = {
      GCP_CREDS : param.application_credentials_64,
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.create_storage_buckets.stdout
  }
  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.create_storage_buckets.stderr
  }
}