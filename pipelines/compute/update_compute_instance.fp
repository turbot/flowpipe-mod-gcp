pipeline "update_compute_instance" {
  title       = "Update a GCP compute instance"
  description = "This pipeline updates a GCP compute instance."

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

  step "container" "update_compute_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(["gcloud", "compute", "instances", "update", param.instance_name, "--zone", param.zone, "--format=json"],
      param.remove_labels != null ? ["--remove-labels", join(",", param.remove_labels)] : [],
      param.update_labels != null ? ["--update-labels", join(",", [for key, value in param.update_labels : "${key}=${value}"])] : []
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "instance" {
    description = "Information about the GCP compute instance."
    value       = jsondecode(step.container.update_compute_instance.stdout)
  }
}