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
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["storage", "buckets", "list", "--format=json"]
    env = {
      CLOUDSDK_AUTH_ACCESS_TOKEN: "..."
      #GCP_CREDS : file(param.application_credentials_path),
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
