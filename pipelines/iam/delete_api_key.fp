pipeline "delete_api_key" {
  title       = "Delete API Key"
  description = "This pipeline deletes an API key in Google Cloud."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "api_key_uid" {
    type        = string
    description = "The UID of the API key to delete."
  }

  step "container" "delete_api_key" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = [
      "gcloud", "alpha", "services", "api-keys", "delete", param.api_key_uid,
      "--format=json"
    ]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "api_key_deletion_info" {
    description = "Information about the deleted API key."
    value       = jsondecode(step.container.delete_api_key.stdout)
  }
}
