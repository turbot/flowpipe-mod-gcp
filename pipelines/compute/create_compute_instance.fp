pipeline "create_compute_instance" {
  title       = "Create a GCP compute instance"
  description = "This pipeline creates a GCP compute instance."

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

  param "zone" {
    type        = string
    description = "The GCP zone."
  }

  param "machine_type" {
    type        = string
    description = "The GCP machine type."
  }

  param "instance_name" {
    type        = string
    description = "The GCP instance name."
  }

  param "boot_disk_size" {
    type        = string
    description = "The GCP boot disk size."
  }

  step "container" "create_compute_instance" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "instances", "create", param.instance_name, "--zone", param.zone, "--machine-type", param.machine_type, "--boot-disk-size", param.boot_disk_size]
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "instance" {
    description = "Information about the created instance."
    value       = jsondecode(step.container.create_compute_instance.stdout)
  }
}