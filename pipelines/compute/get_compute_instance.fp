pipeline "get_compute_instance" {
  title       = "Get GCP Compute Instance Details"
  description = "This pipeline retrieves details about a GCP compute instance."

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

  step "container" "get_compute_instance" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "instances", "describe", param.instance_name, "--zone", param.zone]
    env = {
      GCP_CREDS      = file(param.application_credentials_path),
      GCP_PROJECT_ID = param.project_id,
    }
  }

  output "instance" {
    description = "Information about the instance."
    value       = jsondecode(step.container.get_compute_instance.stdout)
  }
}