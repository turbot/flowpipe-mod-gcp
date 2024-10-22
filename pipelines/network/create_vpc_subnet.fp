pipeline "create_vpc_subnet" {
  title       = "Create VPC Subnet"
  description = "This pipeline define a subnetwork for a network in custom subnet mode. Subnets must be uniquely named per region."

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
    description = "The name of the existing VPC network."
  }

  param "subnet_name" {
    type        = string
    description = "The name of the subnet to create."
  }

  param "region" {
    type        = string
    description = "The GCP region for the subnet."
  }

  param "range" {
    type        = string
    description = "The GCP region for the subnet."
  }

  step "container" "create_vpc_subnet" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = [
      "gcloud", "compute", "networks", "subnets", "create", param.subnet_name,
      "--network", param.network_name,
      "--region", param.region,
      "--range", param.range,
      "--format=json"
    ]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "subnet" {
    description = "Information about the created subnet."
    value       = jsondecode(step.container.create_vpc_subnet.stdout)
  }
}
