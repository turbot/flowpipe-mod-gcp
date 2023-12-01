pipeline "list_storage_buckets" {
  title       = "List GCP Storage Buckets"
  description = "List all GCP Storage buckets in a project."

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

  step "container" "list_storage_buckets" {
    image = "my-gcloud-image-latest"
    cmd   = ["storage", "buckets", "list"]
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "buckets" {
    description = "The JSON output from the GCP CLI."
    value       = jsondecode(step.container.list_storage_buckets.stdout)
  }
}
