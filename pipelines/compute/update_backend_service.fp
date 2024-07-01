pipeline "update_backend_service" {
  title       = "Update Backend Service"
  description = "This pipeline updates a Google Compute Engine backend service to enable logging with a specified logging sample rate."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "region" {
    type        = string
    description = "The GCP region."
  }

  param "service_name" {
    type        = string
    description = "The name of the backend service."
  }

  param "enable_logging" {
    type        = bool
    description = "Whether to enable logging for the backend service."
    default     = true
  }

  param "logging_sample_rate" {
    type        = string
    description = "The logging sample rate as a decimal."
    optional    = true
  }

  step "container" "update_backend_service" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = concat(["gcloud", "compute", "backend-services", "update", param.service_name, "--region", param.region, "--format=json"], 
    param.enable_logging == true ? ["--enable-logging"]: [],
    param.logging_sample_rate != null ? ["--logging-sample-rate", param.logging_sample_rate] : [],
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "backend_service" {
    value = jsondecode(step.container.update_backend_service.output)
  }
}
