pipeline "delete_vpc_subnet" {
  param "application_credentials_path" {
    type        = string
    default     = var.application_credentials_path
    description = "The GCP application credentials file path."
  }

  param "project_id" {
    type        = string
    default     = var.project_id
    description = "The GCP project ID."
  }

  param "subnet_name" {
    type        = string
    description = "The name of the subnet to delete."
  }

  param "region" {
    type        = string
    description = "The GCP region for the subnet."
  }

  step "container" "delete_vpc_subnet" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "networks", "subnets", "delete", param.subnet_name, "--region", param.region]
    env = {
      GCP_CREDS      = file(param.application_credentials_path),
      GCP_PROJECT_ID = param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.delete_vpc_subnet.stdout
  }

  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.delete_vpc_subnet.stderr
  }
}
