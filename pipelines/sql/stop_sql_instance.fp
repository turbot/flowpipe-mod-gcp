pipeline "stop_sql_instance" {
  title       = "Stop SQL Instance"
  description = "This pipeline stops a Google Cloud SQL instance by setting its activation policy to NEVER."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "instance_name" {
    type        = string
    description = "The name of the SQL instance."
  }

  step "container" "stop_sql_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "sql", "instances", "patch", param.instance_name, "--activation-policy=NEVER", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "sql_instance_info" {
    description = "Information about the stopped SQL instance."
    value       = jsondecode(step.container.stop_sql_instance.stdout)
  }
}
