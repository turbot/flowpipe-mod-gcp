pipeline "delete_vpn_gateway" {
  title       = "Delete VPN Gateway"
  description = "This pipeline deletes Google Compute Engine target VPN gateways."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "region" {
    type        = string
    description = "The GCP region."
  }

  param "vpn_gateway_name" {
    type        = string
    description = "The name of the VPN gateways to delete."
  }

  step "container" "delete_vpn_gateway" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = ["gcloud", "compute", "target-vpn-gateways", "delete",param.vpn_gateway_name,"--region", param.region, "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "vpn_gateway_deletion_info" {
    description = "Information about the deleted VPN gateways."
    value       = jsondecode(step.container.delete_vpn_gateway.stdout)
  }
}
