pipeline "create_vpc_network" {
  title       = "Create VPC"
  description = "Creates a new Virtual Private Cloud (VPC) in your GCP account."

  tags = {
    type = "featured"
  }

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

  param "subnet_mode" {
    type        = string
    description = "The subnet mode for the VPC network."
  }

  param "network_name" {
    type        = string
    description = "The name of the VPC network."
  }

  step "container" "create_vpc_network" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "networks", "create", param.network_name, "--subnet-mode", param.subnet_mode, "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "network" {
    description = "Information about the created VPC network."
    value       = jsondecode(step.container.create_vpc_network.stdout)
  }
}
