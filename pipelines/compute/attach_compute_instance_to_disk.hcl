pipeline "attach_compute_instance_to_disk" {
  title       = "Attach a GCP compute instance to a disk."
  description = "This pipeline attaches a GCP compute instance to a disk."

  param "application_credentials_64" {
    type        = "string"
    default     = var.application_credentials_64
    description = "The GCP application credentials."
  }

  param "project_id" {
    type        = "string"
    default     = var.project_id
    description = "The GCP project ID."
  }

  param "intance_name" {
    type        = "string"
    description = "The GCP instance name."
  }

  param "disk_name" {
    type        = "string"
    description = "The GCP disk name."
  }

  param "zone" {
    type        = "string"
    description = "The GCP zone."
  }

  step "container" "attach_compute_instance_to_disk" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "instances", "attach-disk", param.intance_name, "--disk", param.disk_name, "--zone", param.zone]
    env = {
      GCP_CREDS : param.application_credentials_64,
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.attach_compute_instance_to_disk.stdout
  }
  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.attach_compute_instance_to_disk.stderr
  }
}