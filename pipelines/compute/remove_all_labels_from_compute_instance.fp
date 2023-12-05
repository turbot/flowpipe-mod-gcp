pipeline "remove_labels_from_compute_instance" {
  title       = "Remove labels from a GCP compute instance"
  description = "This pipeline removes all labels from a GCP compute instance."

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

  param "zone" {
    type        = string
    description = "The GCP zone."
  }

  param "instance_name" {
    type        = string
    description = "The GCP instance name."
  }

  step "container" "remove_labels_from_compute_instance" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "instances", "remove-labels", param.instance_name, "--zone", param.zone, "--all"]
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "instance" {
    description = "Information about the GCP compute instance."
    value       = jsondecode(step.container.remove_labels_from_compute_instance.stdout)
  }
}