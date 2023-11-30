pipeline "delete_storage_buckets" {
  title       = "Delete GCP storage buckets"
  description = "This pipeline deletes GCP storage buckets."

  param "application_credentials_path" {
    type        = string
    description = local.application_credentials_path_param_description
    default     = var.application_credentials_path
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
    default     = var.project_id
  }

  param "bucket_urls" {
    type        = "list(string)"
    description = "The GCP bucket URLs."
  }

  step "container" "delete_storage_buckets" {
    image = "my-gcloud-image-latest"
    cmd   = concat(["storage", "buckets", "delete"], param.bucket_urls)
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.delete_storage_buckets.stdout
  }
}