pipeline "remove_labels_from_sql_instance" {
  title       = "Remove Labels from SQL Instance"
  description = "This pipeline removes specified labels from a Google Cloud SQL database instance."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "instance_name" {
    type        = string
    description = "The name of the SQL database instance."
  }

  param "label_keys" {
    type        = list(string)
    description = "The GCP label keys to remove."
  }

  step "container" "remove_labels_from_sql_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "beta", "sql", "instances", "patch", param.instance_name, "--remove-labels", join(",", param.label_keys), "--quiet", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "instance" {
    description = "Information about the SQL database instance."
    value       = jsondecode(step.container.remove_labels_from_sql_instance.stdout)
  }
}
