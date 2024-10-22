pipeline "delete_vpc_subnet" {
  title       = "Delete VPC Subnet"
  description = "This pipeline deletes one or more Google Cloud subnetworks. Subnetworks can only be deleted when no other resources, such as VM instances, refer to them."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
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
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }
}
