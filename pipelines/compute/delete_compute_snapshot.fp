pipeline "delete_compute_snapshot" {
  title       = "Delete Compute Engine Snapshot"
  description = "This pipeline deletes a snapshot of a persistent disk in Google Cloud Compute Engine."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "snapshot_name" {
    type        = string
    description = "The name of the snapshot to be deleted."
  }

  step "container" "delete_compute_snapshot" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "snapshots", "delete", param.snapshot_name, "--quiet", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }
}
