pipeline "delete_access_config_from_instance" {
  title       = "Delete Access Config from Instance"
  description = "This pipeline deletes an access configuration from a Google Compute Engine instance."

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
    description = "The name of the instance."
  }

  param "access_config_name" {
    type        = string
    description = "The name of the access configuration to delete."
    optional    = true
  }

  step "container" "delete_access_config_from_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(
      ["gcloud", "compute", "instances", "delete-access-config", param.instance_name, "--zone", param.zone,"--format=json"],
      param.access_config_name != null ? ["--access-config-name", param.access_config_name] : []
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "instance_access_config" {
    description = "Information about the updated instance access configuration."
    value       = jsondecode(step.container.delete_access_config_from_instance.stdout)
  }
}
