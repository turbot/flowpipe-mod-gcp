pipeline "list_storage_buckets" {
  title       = "List Storage Buckets"
  description = "This pipeline list Cloud Storage buckets."

  tags = {
    type = "featured"
  }

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
    default     = var.project_id
  }

  step "container" "list_storage_buckets" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "storage", "buckets", "list", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "buckets" {
    description = "Information about the GCP Storage buckets in the project."
    value       = jsondecode(step.container.list_storage_buckets.stdout)
  }
}
