pipeline "delete_vpc_subnet" {
  title       = "Delete a VPC subnet"
  description = "Deletes a VPC subnet in GCP."

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
}
