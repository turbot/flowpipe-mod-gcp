pipeline "detach_compute_instance_from_disk" {
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

  param "intance_name" {
    type        = "string"
    description = "The GCP instance name."
    default     = "integrated-instance-2023"
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

  step "container" "detach_compute_instance_from_disk" {
    image = "my-gcloud-image"
    cmd   = ["compute", "instances", "detach-disk",param.intance_name, "--disk", param.disk_name, "--zone", param.zone]
    env = {
      GCP_CREDS : param.application_credentials_64,
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    value = step.container.detach_compute_instance_from_disk.stdout
  }
  output "stderr" {
    value = step.container.detach_compute_instance_from_disk.stderr
  }
}