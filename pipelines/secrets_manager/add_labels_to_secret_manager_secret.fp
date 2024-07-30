pipeline "add_labels_to_secret_manager_secret" {
  title       = "Add Labels to Secret"
  description = "This pipeline adds labels to a Google Cloud Secret Manager secret."

  param "cred" {
    type        = string
    description = "GCP credentials to use"
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = "The GCP project ID."
  }

  param "secret_name" {
    type        = string
    description = "The name of the Secret Manager secret."
  }

  param "labels" {
    type        = map(string)
    description = "The GCP labels to add."
  }

  step "container" "add_labels_to_secret_manager_secret" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "secrets", "update", param.secret_name, "--update-labels", join(",", [for k, v in param.labels : "${k}=${v}"]), "--quiet", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "secret" {
    description = "Information about the Secret Manager secret."
    value       = jsondecode(step.container.add_labels_to_secret_manager_secret.stdout)
  }
}