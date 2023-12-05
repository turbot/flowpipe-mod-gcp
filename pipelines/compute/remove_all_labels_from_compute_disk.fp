pipeline "remove_all_labels_from_compute_disk" {
  title       = "Remove all labels from a GCP compute disk"
  description = "This pipeline removes all labels from a GCP compute disk."

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

  step "container" "remove_all_labels_from_compute_disk" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "disks", "remove-labels", param.disk_name, "--zone", param.zone, "--all"]
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "disk" {
    description = "Information about the disk."
    value       = jsondecode(step.container.remove_all_labels_from_compute_disk.stdout)
  }
}