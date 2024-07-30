pipeline "add_labels_to_kms_key" {
  title       = "Add Labels to KMS Key"
  description = "This pipeline adds labels to a Google Cloud KMS key."

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

  param "labels" {
    type        = map(string)
    description = "The GCP labels to add."
  }

  step "container" "add_labels_to_kms_key" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "kms", "keys", "update", param.key_name, "--location", param.location, "--keyring", param.key_ring, "--update-labels", join(",", [for k, v in param.labels : "${k}=${v}"]), "--quiet", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "key" {
    description = "Information about the KMS key."
    value       = jsondecode(step.container.add_labels_to_kms_key.stdout)
  }
}