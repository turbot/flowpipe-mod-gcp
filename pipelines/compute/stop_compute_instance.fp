pipeline "stop_compute_instance" {
  title       = "Stop a GCP compute instance"
  description = "This pipeline stops a GCP compute instance."

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

  param "intance_name" {
    type        = string
    description = "The GCP instance name."
  }

  step "container" "stop_compute_instance" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "instances", "stop", param.intance_name, "--zone", param.zone]
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.stop_compute_instance.stdout
  }
}