pipeline "create_vpc_subnet" {
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
    description = "The name of the existing VPC network."
    default     = "integrated-vpc"
  }

  param "subnet_name" {
    type        = "string"
    description = "The name of the subnet to create."
    default     = "integrated-subnet"
  }

  param "region" {
    type        = "string"
    description = "The GCP region for the subnet."
    default     = "us-central1"
  }

  step "container" "create_vpc_subnet" {
    image = "my-gcloud-image-latest"
    cmd = [
      "compute", "networks", "subnets", "create", param.subnet_name,
      "--network", param.network_name,
      "--region", param.region,
      "--range", "10.0.0.0/24", 
    ]
    env = {
      GCP_CREDS      = param.application_credentials_64,
      GCP_PROJECT_ID = param.project_id,
    }
  }

  output "stdout" {
    value = step.container.create_vpc_subnet.stdout
  }

  output "stderr" {
    value = step.container.create_vpc_subnet.stderr
  }
}