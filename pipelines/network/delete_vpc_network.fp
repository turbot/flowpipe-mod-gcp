pipeline "delete_vpc_network" {
  title       = "Delete a VPC network"
  description = "This pipeline deletes a VPC network in GCP."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
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
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "networks", "delete", param.network_name, "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }
}
