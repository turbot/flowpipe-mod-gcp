pipeline "remove_metadata_from_compute_instance" {
  title       = "Remove Metadata from Instance"
  description = "This pipeline removes specific metadata from a Google Compute Engine instance."

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

  param "metadata_key" {
    type        = string
    description = "The metadata key to remove."
    optional    = true
  }

  step "container" "remove_metadata_from_compute_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = concat(["gcloud", "compute", "instances", "remove-metadata", param.instance_name, "--zone", param.zone, "--format=json"],
      param.metadata_key != null ? ["--keys", param.metadata_key]:[])
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "instance_metadata" {
    description = "Information about the updated compute instance metadata."
    value       = step.container.remove_metadata_from_compute_instance.stdout
  }
}
