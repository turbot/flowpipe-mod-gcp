pipeline "list_compute_disks" {
  param "application_credentials_64" {
    type        = "string"
    default     = var.application_credentials_64
    description = "The GCP application credentials encoded in Base64."
  }

  param "project_id" {
    type        = "string"
    default     = var.project_id
    description = "The GCP project ID."
  }

  step "container" "list_compute_disks" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "disks", "list"]
    env = {
      GCP_CREDS : param.application_credentials_64,
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    value = step.container.list_compute_disks.stdout
  }
  output "stderr" {
    value = step.container.list_compute_disks.stderr
  }
}
