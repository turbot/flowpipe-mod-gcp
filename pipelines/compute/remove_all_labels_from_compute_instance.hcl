pipeline "remove_labels_from_compute_instance" {
  param "application_credentials_path" {
    type        = string
    default     = var.application_credentials_path
    description = "The GCP application credentials file path."
  }

  param "project_id" {
    type        = string
    default     = var.project_id
    description = "The GCP project ID."
  }

  param "zone" {
    type        = string
    description = "The GCP zone."
  }

  param "intance_name" {
    type        = string
    description = "The GCP instance name."
  }

  param "labels" {
    type        = "map(string)"
    description = "The GCP labels."
  }

  step "container" "remove_labels_from_compute_instance" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "instances", "remove-labels", param.intance_name, "--zone", param.zone, "--all"]
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.remove_labels_from_compute_instance.stdout
  }
  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.remove_labels_from_compute_instance.stderr
  }
}