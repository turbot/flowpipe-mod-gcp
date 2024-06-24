pipeline "update_kms_key" {
  title       = "Update KMS Key"
  description = "This pipeline updates the rotation settings of a KMS key."

  param "cred" {
    type        = string
    description = "The credential to use for authentication."
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = "The GCP project ID."
  }

  param "key_ring" {
    type        = string
    description = "The ID of the KMS Key Ring."
  }

  param "location" {
    type        = string
    description = "The location of the KMS Key Ring."
  }

  param "key_id" {
    type        = string
    description = "The ID of the KMS Key."
  }

  param "rotation_period" {
    type        = string
    description = "The rotation period for the KMS key."
  }

  step "container" "update_kms_key" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = [
      "gcloud", "kms", "keys", "update", param.key_id, 
      "--keyring", param.key_ring, 
      "--location", param.location,
      "--rotation-period", param.rotation_period, 
      "--project", param.project_id,
    ]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "result" {
    description = "Result of the KMS key update command."
    value       = step.container.update_kms_key.stdout
  }
}
