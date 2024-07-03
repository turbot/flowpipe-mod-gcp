pipeline "enable_cloud_service" {
  title       = "Enable Cloud Service"
  description = "This pipeline enables a Google Cloud service."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "service_name" {
    type        = string
    description = "The name of the service to enable."
  }

  step "container" "enable_cloud_service" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "services", "enable", param.service_name, "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "service_enable_info" {
    description = "Information about the enabled service."
    value       = jsondecode(step.container.enable_cloud_service.stdout)
  }
}
