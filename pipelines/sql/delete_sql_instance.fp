pipeline "delete_sql_instance" {
  title       = "Delete a Cloud SQL instance"
  description = "Delete a GCP Cloud SQL instance."

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
    description = "The name of the Cloud SQL instance to delete."
  }

  step "container" "delete_sql_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "sql", "instances", "delete", param.instance_name, "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }
}