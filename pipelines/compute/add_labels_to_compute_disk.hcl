pipeline "add_labels_to_compute_disk" {
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

  param "disk_name" {
    type        = "string"
    description = "The GCP disk name."
    default     = "integrated-disk-2023"
  }

  param "labels" {
    type        = "map(string)"
    description = "The GCP labels."
    default = { "owner" = "1234"
      "env" = "dev"
    }
  }

  step "container" "add_labels_to_compute_disk" {
    image = "my-gcloud-image-latest"
    cmd = concat(
      ["compute", "disks", "add-labels", param.disk_name, "--zone", param.zone, "--labels"],
      [join(",", [for key, value in param.labels : "${key}=${value}"])]
    )
    env = {
      GCP_CREDS : param.application_credentials_64,
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    value = step.container.add_labels_to_compute_disk.stdout
  }
  output "stderr" {
    value = step.container.add_labels_to_compute_disk.stderr
  }
}