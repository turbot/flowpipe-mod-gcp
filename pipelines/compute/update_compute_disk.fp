pipeline "update_compute_disk" {
  title       = "Update a GCP compute disk"
  description = "This pipeline updates a GCP compute disk."

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

  param "update_labels" {
    type        = map(string)
    description = "The GCP labels."
    optional    = true
  }

  param "remove_labels" {
    type        = list(string)
    description = "The GCP labels."
    optional    = true
  }

  param "disk_name" {
    type        = string
    description = "The GCP disk name."
  }

  step "container" "update_compute_disk" {
    image = "my-gcloud-image-latest"
    cmd = concat(["compute", "disks", "update", param.disk_name, "--zone", param.zone],
      param.remove_labels != null ? ["--remove-labels", join(",", param.remove_labels)] : [],
      param.update_labels != null ? ["--update-labels", join(",", [for key, value in param.update_labels : "${key}=${value}"])] : []
    )
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "disk" {
    description = "Information about the updated GCP disk."
    value       = jsondecode(step.container.update_compute_disk.stdout)
  }
}