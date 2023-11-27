pipeline "create_vpc_network" {
  title       = "Create VPC"
  description = "Creates a new Virtual Private Cloud (VPC) in your GCP account."

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

  param "subnet_mode" {
    type        = string
    description = "The subnet mode for the VPC network."
  }

  param "network_name" {
    type        = string
    description = "The name of the VPC network."
  }

  param "region" {
    type        = string
    description = "The GCP region for the network and subnet."
  }

  step "container" "create_vpc_network" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "networks", "create", param.network_name, "--subnet-mode", param.subnet_mode]
    env = {
      GCP_CREDS      = file(param.application_credentials_path),
      GCP_PROJECT_ID = param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.create_vpc_network.stdout
  }

  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.create_vpc_network.stderr
  }
}