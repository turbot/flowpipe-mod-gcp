pipeline "clone_sql_instance" {
  title       = "Clone a Cloud SQL instance"
  description = "This pipeline clones a GCP Cloud SQL instance."

  param "application_credentials_path" {
    type        = string
    description = local.application_credentials_path_param_description
    default     = var.application_credentials_path
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
    image = "my-gcloud-image-latest"
    cmd = [
      "sql", "instances", "clone", param.source_instance_name,
      param.clone_instance_name
    ]
    env = {
      GCP_CREDS      = file(param.application_credentials_path),
      GCP_PROJECT_ID = param.project_id,
    }
  }

  output "clone_sql_instance" {
    description = "Information about the cloned Cloud SQL instance."
    value       = jsondecode(step.container.clone_sql_instance.stdout)
  }
}
