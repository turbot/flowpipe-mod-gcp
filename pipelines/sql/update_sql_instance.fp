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

  param "clear_database_flags" {
    type        = bool
    description = "Whether to clear all database flags."
    optional    = true
  }

  param "backup_start_time" {
    type        = string
    description = "The time at which backups should start."
    optional    = true
  }

  param "require_ssl" {
    type        = bool
    description = "Whether to require SSL for connections."
    optional    = true
  }

  param "network" {
    type        = string
    description = "The network for the SQL instance."
    optional    = true
  }

  param "disable_public_ip" {
    type        = bool
    description = "Whether to disable the public IP."
    optional    = true
  }

  param "authorized_networks" {
    type        = list(string)
    description = "The authorized networks for the SQL instance."
    optional    = true
  }

  step "container" "update_sql_instance_flags" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(["gcloud", "sql", "instances", "patch", param.instance_name, "--quiet"],
      param.clear_database_flags == true ? ["--clear-database-flags"] : [],
      param.require_ssl == true ? ["--require-ssl"] : [],
      param.authorized_networks != null ? ["--authorized-networks", join(",", param.authorized_networks)] : [],
      param.backup_start_time != null ? ["--backup-start-time", param.backup_start_time] : [],
      param.network != null ? ["--network", param.network] : [],
      param.disable_public_ip != null ? ["--no-assign-ip"] : [],
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
