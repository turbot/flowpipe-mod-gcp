pipeline "list_compute_disks" {
  title       = "List Compute Disks"
  description = "This pipeline lists all Compute Engine disks in a GCP project."

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

  step "container" "list_compute_disks" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "disks", "list", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "disks" {
    description = "Information about the created disks."
    value       = jsondecode(step.container.list_compute_disks.stdout)
  }
}
