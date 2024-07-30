pipeline "remove_specific_labels_from_secret_manager_secret" {
  title       = "Remove Labels from Secret"
  description = "This pipeline removes specified labels from a Google Cloud Secret Manager secret."

  param "cred" {
    type        = string
    description = "GCP credentials to use"
  }

  param "project_id" {
    type        = string
    description = "The GCP project ID."
  }

  param "secret_name" {
    type        = string
    description = "The name of the Secret Manager secret."
  }

  param "label_keys" {
    type        = list(string)
    description = "The GCP label keys to remove."
  }

  step "container" "remove_specific_labels_from_secret_manager_secret" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "secrets", "update", param.secret_name, "--remove-labels", join(",", param.label_keys), "--quiet", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "secret" {
    description = "Information about the Secret Manager secret."
    value       = jsondecode(step.container.remove_specific_labels_from_secret_manager_secret.stdout)
  }
}