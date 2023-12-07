pipeline "create_vpc_subnet" {
  title       = "Create VPC Subnet"
  description = "Creates a new subnet in an existing Virtual Private Cloud (VPC) in your GCP account."

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
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "subnet" {
    description = "Information about the created subnet."
    value       = jsondecode(step.container.create_vpc_subnet.stdout)
  }
}