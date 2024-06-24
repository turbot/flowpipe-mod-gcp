pipeline "update_sql_instance" {
  title       = "Update SQL Instance"
  description = "This pipeline updates the database flags for a Google Cloud SQL instance."

  param "cred" {
    type        = string
    description = "The credential to use for authentication."
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = "The GCP project ID."
  }

  param "instance_name" {
    type        = string
    description = "The name of the SQL instance."
  }

  param "database_flag_key" {
    type        = string
    description = "The database flag to set."
    optional    = true
  }

  param "database_flag_value" {
    type        = string
    description = "The value for the database flag."
    optional    = true
  }

  step "container" "update_sql_instance_flags" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(["gcloud", "sql", "instances", "patch", param.instance_name],
    param.database_flag_key != null ? ["--database-flags", "${param.database_flag_key}=${param.database_flag_value}"] : [])
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "result" {
    description = "Result of the SQL instance patch command."
    value       = step.container.update_sql_instance_flags.stdout
  }
}
