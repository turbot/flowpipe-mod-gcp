pipeline "list_compute_disks" {
  title       = "List Compute Disks"
  description = "This pipeline displays all Google Compute Engine disks in a project."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  step "container" "list_compute_disks" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "disks", "list", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "disks" {
    description = "Information about the created disks."
    value       = jsondecode(step.container.list_compute_disks.stdout)
  }
}
