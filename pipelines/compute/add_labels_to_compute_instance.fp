pipeline "add_labels_to_compute_instance" {
  title       = "Add labels to a GCP compute instance"
  description = "This pipeline adds labels to a GCP compute instance."

  param "application_credentials_path" {
    type        = string
    description = local.application_credentials_path_param_description
    default     = var.application_credentials_path
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

  param "instance_name" {
    type        = string
    description = "The GCP instance name."
  }

  param "labels" {
    type        = map(string)
    description = "The GCP labels."
  }

  step "container" "add_labels_to_compute_instance" {
    image = "my-gcloud-image-latest"
    cmd = concat(
      ["compute", "instances", "add-labels", param.instance_name, "--zone", param.zone, "--labels"],
      [join(",", [for key, value in param.labels : "${key}=${value}"])]
    )
    env = {
      GCP_CREDS : file(param.application_credentials_path),
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "instance" {
    description = "The JSON output from the GCP CLI."
    value       = jsondecode(step.container.add_labels_to_compute_instance.stdout)
  }
}