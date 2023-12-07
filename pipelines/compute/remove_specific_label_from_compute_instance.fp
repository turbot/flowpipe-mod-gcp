pipeline "remove_specific_label_from_compute_instance" {
  title       = "Remove a specific label from a GCP compute instance"
  description = "This pipeline removes a specific label from a GCP compute instance."

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

  param "label_keys" {
    type        = list(string)
    description = "The GCP labels."
  }

  step "container" "remove_specific_label_from_compute_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "instances", "remove-labels", param.instance_name, "--zone", param.zone, "--labels", join(",", param.label_keys), "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "instance" {
    description = "Information about the GCP compute instance."
    value       = jsondecode(step.container.remove_specific_label_from_compute_instance.stdout)
  }
}