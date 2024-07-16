pipeline "delete_service_account_key" {
  title       = "Delete Service Account Key"
  description = "This pipeline deletes a key from a Google Cloud IAM service account."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "iam_account" {
    type        = string
    description = "The email of the IAM service account."
  }

  param "key_id" {
    type        = string
    description = "The ID of the key to delete."
  }

  step "container" "delete_service_account_key" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "iam", "service-accounts", "keys", "delete", param.key_id, "--iam-account", param.iam_account, "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "service_account_key_deletion_info" {
    description = "Information about the deleted service account key."
    value       = jsondecode(step.container.delete_service_account_key.stdout)
  }
}
