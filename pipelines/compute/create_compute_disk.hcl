pipeline "create_compute_disk" {
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

  param "disk_name" {
    type        = "string"
    description = "The GCP disk name."
    default     = "integrated-disk-2023"
  }

  param "zone" {
    type        = "string"
    description = "The GCP zone."
    default     = "us-central1-a"
  }

  param "size" {
    type        = "string"
    description = "The GCP zone."
    default     = "10GB"
  }

  step "container" "create_compute_disk" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "disks", "create", param.disk_name, "--zone", param.zone, "--size", param.size]
    env = {
      GCP_CREDS : param.application_credentials_64,
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    value = step.container.create_compute_disk.stdout
  }
  output "stderr" {
    value = step.container.create_compute_disk.stderr
  }
}