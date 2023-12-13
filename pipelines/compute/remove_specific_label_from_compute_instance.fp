pipeline "remove_specific_label_from_compute_instance" {
  title       = "Remove Specific Label from Compute Instance"
  description = "This pipeline removes specific labels from a Google Compute Engine virtual machine instance."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
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
