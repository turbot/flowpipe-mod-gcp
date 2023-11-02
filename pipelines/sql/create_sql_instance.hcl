pipeline "create_sql_instance" {
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
    description = "The name of the Cloud SQL instance to create."
  }

  param "region" {
    type        = string
    description = "The GCP region for the Cloud SQL instance."
  }

  param "database_version" {
    type        = string
    description = "The version of the Cloud SQL database (e.g., MYSQL_8_0)."
  }

  step "container" "create_sql_instance" {
    image = "my-gcloud-image-latest"
    cmd = [
      "sql", "instances", "create", param.instance_name,
      "--region", param.region,
      "--database-version", param.database_version
    ]
    env = {
      GCP_CREDS      = file(param.application_credentials_path),
      GCP_PROJECT_ID = param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.create_sql_instance.stdout
  }

  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.create_sql_instance.stderr
  }
}
