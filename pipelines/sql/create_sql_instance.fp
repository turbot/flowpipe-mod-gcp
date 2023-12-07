pipeline "create_sql_instance" {
  title       = "Create a Cloud SQL instance"
  description = "This pipeline creates a GCP Cloud SQL instance."

  tags = {
    type = "featured"
  }

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
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = [
      "gcloud", "sql", "instances", "create", param.instance_name,
      "--region", param.region,
      "--database-version", param.database_version,
      "--format=json"
    ]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "sql_instance" {
    description = "Information about the created Cloud SQL instance."
    value       = jsondecode(step.container.create_sql_instance.stdout)
  }
}
