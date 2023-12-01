pipeline "delete_sql_instance" {
  title       = "Delete a Cloud SQL instance"
  description = "Delete a GCP Cloud SQL instance."

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

  param "instance_name" {
    type        = string
    description = "The name of the Cloud SQL instance to delete."
  }

  step "container" "delete_sql_instance" {
    image = "my-gcloud-image-latest"
    cmd   = ["sql", "instances", "delete", param.instance_name]
    env = {
      GCP_CREDS      = file(param.application_credentials_path),
      GCP_PROJECT_ID = param.project_id,
    }
  }
}