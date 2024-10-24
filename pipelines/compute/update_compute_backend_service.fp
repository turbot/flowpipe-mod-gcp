pipeline "update_compute_backend_service" {
  title       = "Update Compute Backend Service"
  description = "This pipeline updates a Google Compute Engine backend service to enable logging with a specified logging sample rate."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
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

  step "container" "update_compute_backend_service" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = concat(["gcloud", "compute", "backend-services", "update", param.service_name, "--region", param.region, "--format=json"],
    param.enable_logging == true ? ["--enable-logging"]: [],
    param.logging_sample_rate != null ? ["--logging-sample-rate", param.logging_sample_rate] : [],
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "backend_service" {
    value = jsondecode(step.container.update_compute_backend_service.output)
  }
}
