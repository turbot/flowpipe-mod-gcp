pipeline "delete_vpc_network" {
  title       = "Delete a VPC network"
  description = "This pipeline deletes a VPC network in GCP."

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

  param "network_name" {
    type        = string
    description = "The name of the VPC network to delete."
  }

  step "container" "delete_vpc_network" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "networks", "delete", param.network_name]
    env = {
      GCP_CREDS      = file(param.application_credentials_path),
      GCP_PROJECT_ID = param.project_id,
    }
  }
}
