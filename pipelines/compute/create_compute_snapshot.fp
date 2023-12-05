pipeline "create_compute_snapshot" {
  title       = "Create GCP Compute Engine Snapshot"
  description = "This pipeline creates a snapshot of a GCP Compute Engine instance."

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
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "snapshots", "create", param.snapshot_name, "--source-disk-zone", param.source_disk_zone, "--source-disk", param.source_disk_name]
    env = {
      GCP_CREDS      = file(param.application_credentials_path),
      GCP_PROJECT_ID = param.project_id,
    }
  }

  output "snapshot" {
    description = "Information about the GCP Compute Engine snapshot."
    value       = jsondecode(step.container.create_compute_snapshot.stdout)
  }
}
