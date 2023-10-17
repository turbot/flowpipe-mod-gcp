pipeline "update_compute_disk" {
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

  param "update_labels" {
    type        = "map(string)"
    description = "The GCP labels."
    default = {"owner123" = "44444"}
  }

  param "remove_labels" {
    type        = "list(string)"
    description = "The GCP labels."
    default     = ["env"]
  }

  param "disk_name" {
    type        = "string"
    description = "The GCP disk name."
    default     = "integrated-disk-2023"
  }

  step "container" "update_compute_disk" {
    image = "my-gcloud-image"
    cmd = concat(["compute", "disks", "update", param.disk_name, "--zone", param.zone, "--remove-labels", join(",", param.remove_labels), "--update-labels"],
      [join(",", [for key, value in param.update_labels : "${key}=${value}"])]
    )
    env = {
      GCP_CREDS : param.application_credentials_64,
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    value = step.container.update_compute_disk.stdout
  }
  output "stderr" {
    value = step.container.update_compute_disk.stderr
  }
}