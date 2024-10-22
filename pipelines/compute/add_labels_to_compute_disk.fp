pipeline "add_labels_to_compute_disk" {
  title       = "Add Labels to Compute Disk"
  description = "This pipeline adds labels to a Google Compute Engine persistent disk."

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

  param "labels" {
    type        = map(string)
    description = "The GCP labels."
  }

  step "container" "add_labels_to_compute_disk" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(
      ["gcloud", "compute", "disks", "add-labels", param.disk_name, "--zone", param.zone, "--format=json", "--labels"],
      [join(",", [for key, value in param.labels : "${key}=${value}"])]
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "disk" {
    description = "Information about the created disk."
    value       = jsondecode(step.container.add_labels_to_compute_disk.stdout)
  }
}
