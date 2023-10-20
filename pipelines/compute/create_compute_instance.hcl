pipeline "create_compute_instance" {
  title = "Create a GCP compute instance"
  param "application_credentials_64" {
    type        = "string"
    default     = var.application_credentials_64
    description = "The GCP application credentials."
  }

  param "project_id" {
    title       = "Project ID"
    type        = "string"
    default     = var.project_id
    description = "The GCP project ID."
  }

  param "zone" {
    type        = "string"
    description = "The GCP zone."
  }

  param "machine_type" {
    type        = "string"
    description = "The GCP machine type."
  }

  param "intance_name" {
    type        = "string"
    description = "The GCP instance name."
  }

  param "boot_disk_size" {
    type        = "string"
    description = "The GCP boot disk size."
  }

  step "container" "create_compute_instance" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "instances", "create", param.intance_name, "--zone", param.zone, "--machine-type", param.machine_type, "--boot-disk-size", param.boot_disk_size]
    env = {
      GCP_CREDS : param.application_credentials_64,
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.create_compute_instance.stdout
  }
  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.create_compute_instance.stderr
  }
}