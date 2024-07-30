pipeline "remove_labels_from_artifact_repository" {
  title       = "Remove Labels from Artifact Repository"
  description = "This pipeline removes specified labels from a Google Cloud Artifact Repository."

  param "cred" {
    type        = string
    description = "GCP credentials to use"
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = "The GCP project ID."
  }

  param "repository_name" {
    type        = string
    description = "The name of the Artifact Repository."
  }

  param "location" {
    type        = string
    description = "The location of the Artifact Repository."
  }

  param "label_keys" {
    type        = list(string)
    description = "The GCP label keys to remove."
  }

  step "container" "remove_labels_from_artifact_repository" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "artifacts", "repositories", "update", param.repository_name, "--location", param.location, "--remove-labels", join(",", param.label_keys), "--quiet", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "repository" {
    description = "Information about the Artifact Repository."
    value       = jsondecode(step.container.remove_labels_from_artifact_repository.stdout)
  }
}