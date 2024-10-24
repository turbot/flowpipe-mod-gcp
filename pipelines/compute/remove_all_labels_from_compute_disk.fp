pipeline "remove_all_labels_from_compute_disk" {
  title       = "Remove all Labels from Compute Disk"
  description = "This pipeline removes all labels from a Google Compute Engine persistent disk."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
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
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "disks", "remove-labels", param.disk_name, "--zone", param.zone, "--all", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "disk" {
    description = "Information about the disk."
    value       = jsondecode(step.container.remove_all_labels_from_compute_disk.stdout)
  }
}
