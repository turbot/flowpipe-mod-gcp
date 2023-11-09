pipeline "delete_compute_instance" {
  title       = "Delete a GCP compute instance"
  description = "This pipeline will delete a GCP compute instance."

  param "application_credentials_path" {
    type    = "string"
    default = var.application_credentials_path
  }

  param "project_id" {
    type    = "string"
    default = var.project_id
  }

  param "zone" {
    type        = string
    description = "The GCP zone."
  }

  param "intance_name" {
    type        = string
    description = "The GCP instance name."
  }

  step "container" "delete_compute_instance" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "instances", "delete", param.intance_name, "--zone", param.zone]
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.delete_compute_instance.stdout
  }

  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.delete_compute_instance.stderr
  }
}