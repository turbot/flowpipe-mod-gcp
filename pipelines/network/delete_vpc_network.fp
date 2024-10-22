pipeline "delete_vpc_network" {
  title       = "Delete VPC Network"
  description = "This pipeline deletes Compute Engine networks. Networks can only be deleted when no other resources (e.g., virtual machine instances) refer to them."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
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
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }
}
