pipeline "create_sql_instance" {
  param "application_credentials_64" {
    type        = "string"
    default     = var.application_credentials_64
    description = "The GCP application credentials."
  }

  param "project_id" {
    type        = "string"
    default     = var.project_id
    description = "The GCP project ID."
  }

  param "instance_name" {
    type        = "string"
    description = "The name of the Cloud SQL instance to create."
    default     = "my-sql-instance"
  }

  param "region" {
    type        = "string"
    description = "The GCP region for the Cloud SQL instance."
    default     = "us-central1"
  }

  param "database_version" {
    type        = "string"
    description = "The version of the Cloud SQL database (e.g., MYSQL_8_0)."
    default     = "MYSQL_8_0"
  }

  step "container" "create_sql_instance" {
    image = "my-gcloud-image-latest"
    cmd = [
      "sql", "instances", "create", param.instance_name,
      "--region", param.region,
      "--database-version", param.database_version
    ]
    env = {
      GCP_CREDS      = param.application_credentials_64,
      GCP_PROJECT_ID = param.project_id,
    }
  }

  output "stdout" {
    value = step.container.create_sql_instance.stdout
  }

  output "stderr" {
    value = step.container.create_sql_instance.stderr
  }
}
