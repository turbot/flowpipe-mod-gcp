pipeline "create_compute_disk" {
  title       = "Create a GCP compute disk"
  description = "This pipeline creates a GCP compute disk."

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

  param "disk_name" {
    type        = string
    description = "The GCP disk name."
  }

  param "zone" {
    type        = string
    description = "The GCP zone."
  }

  param "size" {
    type        = string
    description = "The GCP zone."
    optional    = true
  }

  step "container" "create_compute_disk" {
    image = "my-gcloud-image-latest"
    cmd   = concat(["compute", "disks", "create", param.disk_name, "--zone", param.zone], 
    param.size != null? ["--size", param.size]:[])
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "disk" {
    description = "Information about the created disk."
    value       = jsondecode(step.container.create_compute_disk.stdout)
  }
}