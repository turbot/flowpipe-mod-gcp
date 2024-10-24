pipeline "add_metadata_to_compute_instance" {
  title       = "Add Metadata to Instance"
  description = "This pipeline adds metadata to a Google Compute Engine instance to block project-wide SSH keys."

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
    description = "The name of the compute instance."
  }

  param "metadata" {
    type        = string
    description = "The metadata to add to the compute instance."
    optional    = true
  }

  step "container" "add_metadata_to_compute_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = concat(["gcloud", "compute", "instances", "add-metadata", param.instance_name, "--zone", param.zone, "--format=json"],
    param.metadata != null ? ["--metadata", param.metadata]:[])
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "instance" {
    description = "Information about the updated compute instance."
    value       = jsondecode(step.container.add_metadata_to_compute_instance)
  }
}
