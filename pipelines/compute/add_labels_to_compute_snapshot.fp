pipeline "add_labels_to_compute_snapshot" {
  title       = "Add or Update Labels on Compute Snapshot"
  description = "This pipeline adds or updates labels on a Google Compute Engine snapshot."

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
    description = "The GCP snapshot name."
  }

  param "labels" {
    type        = map(string)
    description = "The GCP labels."
  }

  step "container" "add_labels_to_compute_snapshot" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "snapshots", "add-labels", param.snapshot_name, "--labels", join(",", [for k, v in param.labels : "${k}=${v}"]), "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "snapshot" {
    description = "Information about the GCP compute snapshot."
    value       = jsondecode(step.container.add_labels_to_compute_snapshot.stdout)
  }
}
