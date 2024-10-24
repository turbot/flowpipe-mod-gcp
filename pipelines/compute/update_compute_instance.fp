pipeline "update_compute_instance" {
  title       = "Update Compute Instance"
  description = "This pipeline updates labels and requested CPU Platform for a Compute Engine virtual machine."

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

  param "update_labels" {
    type        = map(string)
    description = "The GCP labels."
    optional    = true
  }

  param "remove_labels" {
    type        = list(string)
    description = "The GCP labels."
    optional    = true
  }

  param "instance_name" {
    type        = string
    description = "The GCP instance name."
  }

  param "shielded_vtpm" {
    type        = bool
    description = "Enable Shielded vTPM."
    optional    = true
  }

  param "shielded_integrity_monitoring" {
    type        = bool
    description = "Enable Shielded VM Integrity Monitoring."
    optional    = true
  }

  step "container" "update_compute_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(
      ["gcloud", "compute", "instances", "update", param.instance_name, "--zone", param.zone, "--format=json"],
      param.remove_labels != null ? ["--remove-labels", join(",", param.remove_labels)] : [],
      param.update_labels != null ? ["--update-labels", join(",", [for key, value in param.update_labels : "${key}=${value}"])] : [],
      param.shielded_vtpm ? ["--shielded-vtpm"] : [],
      param.shielded_integrity_monitoring ? ["--shielded-integrity-monitoring"] : []
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "instance" {
    description = "Information about the GCP compute instance."
    value       = jsondecode(step.container.update_compute_instance.stdout)
  }
}
