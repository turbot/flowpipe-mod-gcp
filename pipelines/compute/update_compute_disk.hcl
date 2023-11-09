pipeline "update_compute_disk" {
  title       = "Update a GCP compute disk"
  description = "This pipeline updates a GCP compute disk."

  param "application_credentials_path" {
    type        = string
    default     = var.application_credentials_path
    description = "The GCP application credentials file path."
  }

  param "project_id" {
    type        = string
    default     = var.project_id
    description = "The GCP project ID."
  }

  param "zone" {
    type        = string
    description = "The GCP zone."
  }

  param "update_labels" {
    type        = "map(string)"
    optional    = true
    description = "The GCP labels."
  }

  param "remove_labels" {
    type        = "list(string)"
    optional    = true
    description = "The GCP labels."
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

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.update_compute_disk.stdout
  }

  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.update_compute_disk.stderr
  }
}