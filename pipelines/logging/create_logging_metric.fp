pipeline "create_logging_metric" {
  title       = "Create Logging Metric"
  description = "This pipeline creates a logging metric in Google Cloud."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "metric_name" {
    type        = string
    description = "The name of the logging metric."
  }

  param "description" {
    type        = string
    description = "The description of the logging metric."
  }

  param "log_filter" {
    type        = string
    description = "The log filter for the logging metric."
  }

  step "container" "create_logging_metric" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = [
      "gcloud", "beta", "logging", "metrics", "create", param.metric_name,
      "--description", param.description,
      "--log-filter", param.log_filter,
      "--format=json"
    ]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "logging_metric_info" {
    description = "Information about the created logging metric."
    value       = jsondecode(step.container.create_logging_metric.stdout)
  }
}
