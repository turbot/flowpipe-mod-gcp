pipeline "update_api_key" {
  title       = "Update API Key"
  description = "This pipeline updates an API key in Google Cloud."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "api_key_uid" {
    type        = string
    description = "The UID of the API key to update."
  }

  step "container" "update_api_key" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = [
      "gcloud", "alpha", "services", "api-keys", "update", param.api_key_uid,
      "--format=json"
    ]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "api_key_update_info" {
    description = "Information about the updated API key."
    value       = jsondecode(step.container.update_api_key.stdout)
  }
}
