pipeline "clone_sql_instance" {
  title       = "Clone Cloud SQL Instance"
  description = "This pipeline creates a clone of a Cloud SQL instance. The clone is an independent copy of the source instance with the same data and settings. Source and destination instances must be in the same project. An instance can be cloned from its current state, or from an earlier point in time."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
    default     = var.project_id
  }

  param "source_instance_name" {
    type        = string
    description = "The name of the source Cloud SQL instance to clone."
  }

  param "clone_instance_name" {
    type        = string
    description = "The name of the cloned Cloud SQL instance."
  }

  step "container" "clone_sql_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = [
      "gcloud", "sql", "instances", "clone", param.source_instance_name, param.clone_instance_name, "--format=json"
    ]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "clone_sql_instance" {
    description = "Information about the cloned Cloud SQL instance."
    value       = jsondecode(step.container.clone_sql_instance.stdout)
  }
}
