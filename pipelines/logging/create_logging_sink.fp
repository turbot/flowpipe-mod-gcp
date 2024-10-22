pipeline "create_logging_sink" {
  title       = "Create Logging Sink"
  description = "This pipeline creates a logging sink in Google Cloud."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "sink_name" {
    type        = string
    description = "The name of the logging sink."
  }

  param "destination" {
    type        = string
    description = "The destination for the logging sink (e.g., storage.googleapis.com/DESTINATION_BUCKET_NAME)."
  }

  param "include_children" {
    type        = bool
    description = "Include children in the logging sink."
    optional    = true
  }

  param "folder_id" {
    type        = string
    description = "The folder ID for the logging sink."
    optional    = true
  }

  param "organization_id" {
    type        = string
    description = "The organization ID for the logging sink."
    optional    = true
  }

  step "container" "create_logging_sink" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(
      ["gcloud", "logging", "sinks", "create", param.sink_name, param.destination],
      param.include_children == true ? ["--include-children"] : [],
      param.folder_id != null ? ["--folder", param.folder_id] : [],
      param.organization_id != null ? ["--organization", param.organization_id] : [],
      ["--format=json"]
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "logging_sink_info" {
    description = "Information about the created logging sink."
    value       = jsondecode(step.container.create_logging_sink.stdout)
  }
}
