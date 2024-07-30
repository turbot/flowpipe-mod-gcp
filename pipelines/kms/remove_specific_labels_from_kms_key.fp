pipeline "remove_labels_from_kms_key" {
  title       = "Remove Labels from KMS Key"
  description = "This pipeline removes specified labels from a Google Cloud KMS key."

  param "cred" {
    type        = string
    description = "GCP credentials to use"
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = "The GCP project ID."
  }

  param "location" {
    type        = string
    description = "The location of the KMS key."
  }

  param "key_ring" {
    type        = string
    description = "The name of the key ring."
  }

  param "key_name" {
    type        = string
    description = "The name of the KMS key."
  }

  param "label_keys" {
    type        = list(string)
    description = "The GCP label keys to remove."
  }

  step "container" "remove_labels_from_kms_key" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "kms", "keys", "update", param.key_name, "--location", param.location, "--keyring", param.key_ring, "--remove-labels", join(",", param.label_keys), "--quiet", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "key" {
    description = "Information about the KMS key."
    value       = jsondecode(step.container.remove_labels_from_kms_key.stdout)
  }
}