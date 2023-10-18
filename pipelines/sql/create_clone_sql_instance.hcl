pipeline "clone_sql_instance" {
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

  param "source_instance_name" {
    type        = "string"
    description = "The name of the source Cloud SQL instance to clone."
    default     = "my-sql-instance"
  }

  param "clone_instance_name" {
    type        = "string"
    description = "The name of the cloned Cloud SQL instance."
    default     = "cloned-sql-instance"
  }

  step "container" "clone_sql_instance" {
    image = "my-gcloud-image-latest"
    cmd = [
      "sql", "instances", "clone", param.source_instance_name,
      param.clone_instance_name
    ]
    env = {
      GCP_CREDS      = param.application_credentials_64,
      GCP_PROJECT_ID = param.project_id,
    }
  }

  output "stdout" {
    value = step.container.clone_sql_instance.stdout
  }

  output "stderr" {
    value = step.container.clone_sql_instance.stderr
  }
}
