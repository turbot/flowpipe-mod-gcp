pipeline "list_storage_buckets" {
  title       = "List GCP Storage Buckets"
  description = "List all GCP Storage buckets in a project."

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

  step "container" "list_storage_buckets" {
    image = "my-gcloud-image-latest"
    cmd   = ["storage", "buckets", "list"]
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.list_storage_buckets.stdout
  }
  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.list_storage_buckets.stderr
  }
}
