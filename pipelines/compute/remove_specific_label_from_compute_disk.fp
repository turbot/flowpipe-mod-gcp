pipeline "remove_specific_label_from_compute_disk" {
  title       = "Remove Specific Label from Compute Disk"
  description = "This pipeline removes specific labels from a Google Compute Engine persistent disk."

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

  param "label_keys" {
    type        = list(string)
    description = "The GCP labels."
  }

  step "container" "remove_specific_label_from_compute_disk" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "disks", "remove-labels", param.disk_name, "--zone", param.zone, "--labels", join(",", param.label_keys), "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "disk" {
    description = "Information about the disk."
    value       = jsondecode(step.container.remove_specific_label_from_compute_disk.stdout)
  }
}
