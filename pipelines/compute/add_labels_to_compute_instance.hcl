pipeline "add_labels_to_compute_instance" {
  title       = "Add labels to a GCP compute instance."
  description = "This pipeline adds labels to a GCP compute instance."

  param "application_credentials_64" {
    type        = "string"
    default     = var.application_credentials_64
    description = "The GCP application credentials."
  }

  param "project_id" {
    type        = "string"
    default     = var.project_id
    description = "The GCP project ID."
  }

  param "zone" {
    type        = "string"
    description = "The GCP zone."
  }

  param "intance_name" {
    type        = "string"
    description = "The GCP instance name."
  }

  param "labels" {
    type        = "map(string)"
    description = "The GCP labels."
  }

  step "container" "add_labels_to_compute_instance" {
    image = "my-gcloud-image-latest"
    cmd = concat(
      ["compute", "instances", "add-labels", param.intance_name, "--zone", param.zone, "--labels"],
      [join(",", [for key, value in param.labels : "${key}=${value}"])]
    )
    env = {
      GCP_CREDS : param.application_credentials_64,
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.add_labels_to_compute_instance.stdout
  }
  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.add_labels_to_compute_instance.stderr
  }
}