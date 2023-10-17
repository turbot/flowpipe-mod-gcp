pipeline "create_compute_instance" {
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

  param "zone" {
    type        = "string"
    description = "The GCP zone."
    default     = "us-central1-a"
  }

  param "machine_type" {
    type        = "string"
    description = "The GCP machine type."
    default     = "e2-micro"
  }

  param "intance_name" {
    type        = "string"
    description = "The GCP instance name."
    default     = "integrated-instance-2023"
  }

  param "boot_disk_size" {
    type        = "string"
    description = "The GCP boot disk size."
    default     = "10GB"
  }

  step "container" "create_compute_instance" {
    image = "my-gcloud-image"
    cmd   = ["compute", "instances", "create",param.intance_name,"--zone", param.zone,"--machine-type",param.machine_type,"--boot-disk-size",param.boot_disk_size]
    env = {
      GCP_CREDS : param.application_credentials_64,
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    value = step.container.create_compute_instance.stdout
  }
  output "stderr" {
    value = step.container.create_compute_instance.stderr
  }
}