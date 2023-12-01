pipeline "detach_compute_instance_from_disk" {
  title       = "Detach a GCP compute instance from a disk"
  description = "This pipeline detaches a GCP compute instance from a disk."

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

  param "instance_name" {
    type        = string
    description = "The GCP instance name."
  }

  param "disk_name" {
    type        = string
    description = "The GCP disk name."
  }

  param "zone" {
    type        = string
    description = "The GCP zone."
  }

  step "container" "detach_compute_instance_from_disk" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "instances", "detach-disk", param.instance_name, "--disk", param.disk_name, "--zone", param.zone]
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "instance" {
    description = "The JSON output from the GCP CLI."
    value       = jsondecode(step.container.detach_compute_instance_from_disk.stdout)
  }
}