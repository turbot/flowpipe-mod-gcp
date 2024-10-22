pipeline "update_dns_managed_zone" {
  title       = "Update DNS Managed Zone"
  description = "This pipeline updates a Google Cloud DNS managed zone to turn on DNSSEC."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "zone_name" {
    type        = string
    description = "The name of the DNS managed zone."
  }

  param "dnssec_state" {
    type        = string
    description = "The DNSSEC state to set for the managed zone."
    optional    = true
  }

  step "container" "update_dns_managed_zone" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(["gcloud", "dns", "managed-zones", "update", param.zone_name, "--format=json"],
    param.dnssec_state != null ? ["--dnssec-state", "on"] : [])
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "dns_managed_zone_info" {
    description = "Information about the updated DNS managed zone."
    value       = jsondecode(step.container.update_dns_managed_zone.stdout)
  }
}
