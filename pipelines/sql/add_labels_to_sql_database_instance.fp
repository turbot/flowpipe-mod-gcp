pipeline "add_labels_to_sql_instance" {
  title       = "Add Labels to SQL Instance"
  description = "This pipeline adds labels to a Google Cloud SQL database instance."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = "The GCP project ID."
  }

  param "instance_name" {
    type        = string
    description = "The name of the SQL database instance."
  }

  param "labels" {
    type        = map(string)
    description = "The GCP labels to add."
  }

  step "container" "add_labels_to_sql_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "beta", "sql", "instances", "patch", param.instance_name, "--update-labels", join(",", [for k, v in param.labels : "${k}=${v}"]), "--quiet", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "instance" {
    description = "Information about the SQL database instance."
    value       = jsondecode(step.container.add_labels_to_sql_instance.stdout)
  }
}
