pipeline "delete_sql_instance" {
  title       = "Delete a Cloud SQL instance"
  description = "Delete a GCP Cloud SQL instance."

  param "application_credentials_path" {
    type        = string
    default     = var.application_credentials_path
    description = "The GCP application credentials file path."
  }

  param "project_id" {
    type        = string
    default     = var.project_id
    description = "The GCP project ID."
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

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.delete_sql_instance.stdout
  }

  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.delete_sql_instance.stderr
  }
}