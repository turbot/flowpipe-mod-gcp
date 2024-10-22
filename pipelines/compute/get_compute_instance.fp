pipeline "get_compute_instance" {
  title       = "Get Compute Instance Details"
  description = "This pipeline displays all data associated with a Compute Engine virtual machine instance."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "zone" {
    type        = string
    description = "The GCP zone."
  }

  param "instance_name" {
    type        = string
    description = "The GCP instance name."
  }

  step "container" "get_compute_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "instances", "describe", param.instance_name, "--zone", param.zone, "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "instance" {
    description = "Information about the instance."
    value       = jsondecode(step.container.get_compute_instance.stdout)
  }
}
