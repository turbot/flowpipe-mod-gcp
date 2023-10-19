pipeline "remove_labels_from_compute_instance" {
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
    default     = "us-central1-a"
  }

  param "intance_name" {
    type        = "string"
    description = "The GCP instance name."
    default     = "integrated-instance-2023"
  }

  param "labels" {
    type        = "map(string)"
    description = "The GCP labels."
    default = { "owner" = "1234"
      "env" = "dev"
    }
  }

  step "container" "remove_labels_from_compute_instance" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "instances", "remove-labels", param.intance_name, "--zone", param.zone, "--all"]
    env = {
      GCP_CREDS : param.application_credentials_64,
      GCP_PROJECT_ID : param.project_id,
    }
  }

  output "stdout" {
    value = step.container.remove_labels_from_compute_instance.stdout
  }
  output "stderr" {
    value = step.container.remove_labels_from_compute_instance.stderr
  }
}