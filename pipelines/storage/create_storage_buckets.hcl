pipeline "create_storage_buckets" {
  title       = "Create GCP storage buckets"
  description = "This pipeline creates GCP storage buckets."

  param "application_credentials_path" {
    type        = string
    default     = var.application_credentials_path
    description = "The GCP application credentials file path."
  }

  param "project_id" {
    type        = string
    default     = var.project_id
    description = "The GCP project ID."
  }

  param "bucket_urls" {
    type        = "list(string)"
    description = "The GCP bucket URLs."
  }

  step "container" "create_storage_buckets" {
    image = "my-gcloud-image-latest"
    cmd   = concat(["storage", "buckets", "create"], param.bucket_urls)
    env = {
      GCP_CREDS : file(param.application_credentials_path),
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