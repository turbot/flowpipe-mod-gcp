pipeline "start_compute_instance" {
  title       = "Start a GCP compute instance"
  description = "This pipeline starts a GCP compute instance."

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

  param "instance_name" {
    type        = string
    description = "The GCP instance name."
  }

  step "container" "start_compute_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "instances", "start", param.instance_name, "--zone", param.zone, "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "instance" {
    description = "Information about the started compute instance."
    value       = jsondecode(step.container.start_compute_instance.stdout)
  }
}