pipeline "create_api_key" {
  title       = "Create API Key"
  description = "This pipeline creates an API key in Google Cloud."

  param "cred" {
    type        = string
    description = local.creds_param_description
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "key_name" {
    type        = string
    description = "The display name of the API key."
  }

  step "container" "create_api_key" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = [
      "gcloud", "alpha", "services", "api-keys", "create",
      "--display-name", param.key_name,
      "--format=json"
    ]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "api_key_info" {
    description = "Information about the created API key."
    value       = jsondecode(step.container.create_api_key.stdout)
  }
}
