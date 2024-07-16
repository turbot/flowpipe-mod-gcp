pipeline "set_service_account_for_compute_instance" {
  title       = "Set Service Account for Instance"
  description = "This pipeline sets the service account and scopes for a Google Compute Engine instance."

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
    description = "The name of the compute instance."
  }

  param "service_account" {
    type        = string
    description = "The service account to set for the instance."
    optional    = true
  }

  param "scopes" {
    type        = list(string)
    description = "The list of scopes to set for the instance."
    optional    = true
  }

  step "container" "set_service_account_for_compute_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(
      ["gcloud", "compute", "instances", "set-service-account", param.instance_name, "--zone", param.zone, "--format=json"],
      param.service_account != null ? ["--service-account", param.service_account] : ["--no-service-account"],
      param.scopes != null ? ["--scopes", join(",", param.scopes)] : ["--no-scopes"]
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  // output "set_service_account_for_compute_instance" {
  //   description = "Information about the updated instance service account and scopes."
  //   value       = jsondecode(step.container.set_service_account_for_instance.stdout)
  // }
}
