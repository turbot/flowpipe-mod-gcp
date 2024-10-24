pipeline "create_compute_snapshot" {
  title       = "Create Compute Engine Snapshot"
  description = "This pipeline creates snapshot of persistent disk. Snapshots are useful for backing up persistent disk data and for creating custom images."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
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
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "snapshot" {
    description = "Information about the GCP Compute Engine snapshot."
    value       = jsondecode(step.container.create_compute_snapshot.stdout)
  }
}
