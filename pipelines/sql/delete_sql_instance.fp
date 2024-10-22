pipeline "delete_sql_instance" {
  title       = "Delete Cloud SQL Instance"
  description = "This pipeline deletes a Cloud SQL instance."

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
    description = "The name of the Cloud SQL instance to delete."
  }

  step "container" "delete_sql_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "sql", "instances", "delete", param.instance_name, "--format=json", "--quiet"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }
}
