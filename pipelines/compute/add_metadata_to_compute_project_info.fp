pipeline "add_metadata_to_compute_project_info" {
  title       = "Add Metadata to Compute Project Info"
  description = "This pipeline adds metadata to a Google Cloud project."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "metadata" {
    type        = string
    description = "The metadata to add to the project. This should be a key=value string."
    optional    = true
  }

  step "container" "add_metadata_to_compute_project_info" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(["gcloud", "compute", "project-info", "add-metadata"],
    param.metadata != null ? ["--metadata", param.metadata] : [])
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "project_metadata" {
    description = "Information about the updated project metadata."
    value       = step.container.add_metadata_to_compute_project_info.stdout
  }
}
