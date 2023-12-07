pipeline "create_compute_instance" {
  title       = "Create a GCP compute instance"
  description = "This pipeline creates a GCP compute instance."

  tags = {
    type = "featured"
  }

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

  param "zone" {
    type        = string
    description = "The GCP zone."
  }

  param "machine_type" {
    type        = string
    description = "The GCP machine type."
  }

  param "instance_name" {
    type        = string
    description = "The GCP instance name."
  }

  param "boot_disk_size" {
    type        = string
    description = "The GCP boot disk size."
  }

  step "container" "create_compute_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "instances", "create", param.instance_name, "--zone", param.zone, "--machine-type", param.machine_type, "--boot-disk-size", param.boot_disk_size, "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "instance" {
    description = "Information about the created instance."
    value       = jsondecode(step.container.create_compute_instance.stdout)
  }
}