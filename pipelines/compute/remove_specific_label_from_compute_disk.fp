pipeline "remove_specific_label_from_compute_disk" {
  title       = "Remove a specific label from a GCP compute disk"
  description = "This pipeline removes a specific label from a GCP compute disk."

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

  param "disk_name" {
    type        = string
    description = "The GCP disk name."
  }

  param "label_keys" {
    type        = "list(string)"
    description = "The GCP labels."
  }

  step "container" "remove_specific_label_from_compute_disk" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "disks", "remove-labels", param.disk_name, "--zone", param.zone, "--labels", join(",", param.label_keys)]
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "disk" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.remove_specific_label_from_compute_disk.stdout
  }
}