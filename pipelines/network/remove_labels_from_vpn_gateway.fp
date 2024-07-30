pipeline "remove_labels_from_vpn_gateway" {
  title       = "Remove Labels from VPN Gateway"
  description = "This pipeline removes specified labels from a Google Cloud VPN Gateway."

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

  param "label_keys" {
    type        = list(string)
    description = "The GCP label keys to remove."
  }

  step "container" "remove_labels_from_vpn_gateway" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "vpn-gateways", "update", param.gateway_name, "--region", param.region, "--remove-labels", join(",", param.label_keys), "--quiet", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "gateway" {
    description = "Information about the VPN Gateway."
    value       = jsondecode(step.container.remove_labels_from_vpn_gateway.stdout)
  }
}