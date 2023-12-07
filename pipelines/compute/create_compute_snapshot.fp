pipeline "create_compute_snapshot" {
  title       = "Create GCP Compute Engine Snapshot"
  description = "This pipeline creates a snapshot of a GCP Compute Engine instance."

  tags = {
    type = "featured"
  }

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

  param "source_disk_zone" {
    type        = string
    description = "The GCP zone."
  }

  param "source_disk_name" {
    type        = string
    description = "The GCP instance name."
  }

  param "snapshot_name" {
    type        = string
    description = "The name of the snapshot to be created."
  }

  step "container" "create_compute_snapshot" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "snapshots", "create", param.snapshot_name, "--source-disk-zone", param.source_disk_zone, "--source-disk", param.source_disk_name, "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "snapshot" {
    description = "Information about the GCP Compute Engine snapshot."
    value       = jsondecode(step.container.create_compute_snapshot.stdout)
  }
}
