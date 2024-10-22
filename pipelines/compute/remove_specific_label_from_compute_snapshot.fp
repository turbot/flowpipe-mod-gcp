pipeline "remove_specific_label_from_compute_snapshot" {
  title       = "Remove Labels from Compute Snapshot"
  description = "This pipeline removes specified labels from a Google Compute Engine snapshot."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "snapshot_name" {
    type        = string
    description = "The GCP snapshot name."
  }

  param "label_keys" {
    type        = list(string)
    description = "The GCP label keys to remove."
  }

  step "container" "remove_specific_label_from_compute_snapshot" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "snapshots", "remove-labels", param.snapshot_name, "--labels", join(",", param.label_keys), "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "snapshot" {
    description = "Information about the GCP compute snapshot."
    value       = jsondecode(step.container.remove_specific_label_from_compute_snapshot.stdout)
  }
}
