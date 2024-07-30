pipeline "add_labels_to_artifact_repository" {
  title       = "Add Labels to Artifact Repository"
  description = "This pipeline adds labels to a Google Cloud Artifact Repository."

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

  param "labels" {
    type        = map(string)
    description = "The GCP labels to add."
  }

  step "container" "add_labels_to_artifact_repository" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "artifacts", "repositories", "update", param.repository_name, "--location", param.location, "--update-labels", join(",", [for k, v in param.labels : "${k}=${v}"]), "--quiet", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "repository" {
    description = "Information about the Artifact Repository."
    value       = jsondecode(step.container.add_labels_to_artifact_repository.stdout)
  }
}