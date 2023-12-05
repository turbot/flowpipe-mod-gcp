pipeline "add_labels_to_compute_disk" {
  title       = "Add labels to a GCP compute disk"
  description = "This pipeline adds labels to a GCP compute disk."

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

  param "labels" {
    type        = map(string)
    description = "The GCP labels."
  }

  step "container" "add_labels_to_compute_disk" {
    image = "my-gcloud-image-latest"
    cmd = concat(
      ["compute", "disks", "add-labels", param.disk_name, "--zone", param.zone, "--labels"],
      [join(",", [for key, value in param.labels : "${key}=${value}"])]
    )
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "disk" {
    description = "Information about the created disk."
    value       = jsondecode(step.container.add_labels_to_compute_disk.stdout)
  }
}