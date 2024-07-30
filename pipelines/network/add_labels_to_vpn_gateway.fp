pipeline "add_labels_to_vpn_gateway" {
  title       = "Add Labels to VPN Gateway"
  description = "This pipeline adds labels to a Google Cloud VPN Gateway."

  param "cred" {
    type        = string
    description = "GCP credentials to use"
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = "The GCP project ID."
  }

  param "region" {
    type        = string
    description = "The region where the VPN Gateway is located."
  }

  param "gateway_name" {
    type        = string
    description = "The name of the VPN Gateway."
  }

  param "labels" {
    type        = map(string)
    description = "The GCP labels to add."
  }

  step "container" "add_labels_to_vpn_gateway" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "vpn-gateways", "update", param.gateway_name, "--region", param.region, "--update-labels", join(",", [for k, v in param.labels : "${k}=${v}"]), "--quiet", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "gateway" {
    description = "Information about the VPN Gateway."
    value       = jsondecode(step.container.add_labels_to_vpn_gateway.stdout)
  }
}