pipeline "list_compute_disks" {
  title       = "List Compute Disks"
  description = "This pipeline lists all Compute Engine disks in a GCP project."

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

  step "container" "list_compute_disks" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "disks", "list"]
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.list_compute_disks.stdout
  }

  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.list_compute_disks.stderr
  }
}