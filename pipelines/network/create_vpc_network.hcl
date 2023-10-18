pipeline "create_vpc_network" {
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

  param "subnet_mode" {
    type        = "string"
    description = "The subnet mode for the VPC network."
    default     = "custom"
  }

  param "network_name" {
    type        = "string"
    description = "The name of the VPC network."
    default     = "integrated-vpc"
  }

  param "region" {
    type        = "string"
    description = "The GCP region for the network and subnet."
    default     = "us-central1"
  }

  step "container" "create_vpc_network" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "networks", "create", param.network_name,"--subnet-mode", param.subnet_mode]
    env = {
      GCP_CREDS      = param.application_credentials_64,
      GCP_PROJECT_ID = param.project_id,
    }
  }

  output "stdout" {
    value = step.container.create_vpc_network.stdout
  }

  output "stderr" {
    value = step.container.create_vpc_network.stderr
  }
}
