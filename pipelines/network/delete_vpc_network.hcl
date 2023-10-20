pipeline "delete_vpc_network" {
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

  param "network_name" {
    type        = "string"
    description = "The name of the VPC network to delete."
    default     = "integrated-vpc"
  }

  step "container" "delete_vpc_network" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "networks", "delete", param.network_name]
    env = {
      GCP_CREDS      = param.application_credentials_64,
      GCP_PROJECT_ID = param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.delete_vpc_network.stdout
  }

  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.delete_vpc_network.stderr
  }
}
