pipeline "delete_vpc_subnet" {
  title       = "Delete a VPC subnet"
  description = "Deletes a VPC subnet in GCP."

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

  param "subnet_name" {
    type        = string
    description = "The name of the subnet to delete."
  }

  param "region" {
    type        = string
    description = "The GCP region for the subnet."
  }

  step "container" "delete_vpc_subnet" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "networks", "subnets", "delete", param.subnet_name, "--region", param.region, "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }
}
