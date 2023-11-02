pipeline "detach_compute_instance_from_disk" {
  title       = "Detach a GCP compute instance from a disk"
  description = "This pipeline detaches a GCP compute instance from a disk."

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

  param "intance_name" {
    type        = string
    description = "The GCP instance name."
  }

  param "disk_name" {
    type        = string
    description = "The GCP disk name."
  }

  param "zone" {
    type        = string
    description = "The GCP zone."
  }

  step "container" "detach_compute_instance_from_disk" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "instances", "detach-disk", param.intance_name, "--disk", param.disk_name, "--zone", param.zone]
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.detach_compute_instance_from_disk.stdout
  }
  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.detach_compute_instance_from_disk.stderr
  }
}