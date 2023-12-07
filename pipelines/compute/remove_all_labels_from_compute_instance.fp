pipeline "remove_labels_from_compute_instance" {
  title       = "Remove labels from a GCP compute instance"
  description = "This pipeline removes all labels from a GCP compute instance."

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

  step "container" "remove_labels_from_compute_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "instances", "remove-labels", param.instance_name, "--zone", param.zone, "--all", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "instance" {
    description = "Information about the GCP compute instance."
    value       = jsondecode(step.container.remove_labels_from_compute_instance.stdout)
  }
}