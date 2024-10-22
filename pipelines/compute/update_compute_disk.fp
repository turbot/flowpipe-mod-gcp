pipeline "update_compute_disk" {
  title       = "Update Compute Disk"
  description = "This pipeline updates a Compute Engine persistent disk."

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
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(["gcloud", "compute", "disks", "update", param.disk_name, "--zone", param.zone, "--format=json"],
      param.remove_labels != null ? ["--remove-labels", join(",", param.remove_labels)] : [],
      param.update_labels != null ? ["--update-labels", join(",", [for key, value in param.update_labels : "${key}=${value}"])] : []
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "disk" {
    description = "Information about the updated GCP disk."
    value       = jsondecode(step.container.update_compute_disk.stdout)
  }
}
