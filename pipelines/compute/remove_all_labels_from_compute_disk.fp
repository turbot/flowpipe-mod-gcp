pipeline "remove_all_labels_from_compute_disk" {
  title       = "Remove all labels from a GCP compute disk"
  description = "This pipeline removes all labels from a GCP compute disk."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
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
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "disks", "remove-labels", param.disk_name, "--zone", param.zone, "--all", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "disk" {
    description = "Information about the disk."
    value       = jsondecode(step.container.remove_all_labels_from_compute_disk.stdout)
  }
}