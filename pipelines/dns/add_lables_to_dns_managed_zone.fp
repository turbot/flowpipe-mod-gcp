pipeline "add_labels_to_dns_managed_zone" {
  title       = "Add Labels to DNS Managed Zone"
  description = "This pipeline adds labels to a Google Cloud DNS managed zone."

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

  param "labels" {
    type        = map(string)
    description = "The GCP labels to add."
  }

  step "container" "add_labels_to_dns_managed_zone" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "dns", "managed-zones", "update", param.zone_name, "--update-labels", join(",", [for k, v in param.labels : "${k}=${v}"]), "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "managed_zone" {
    description = "Information about the DNS managed zone."
    value       = jsondecode(step.container.add_labels_to_dns_managed_zone.stdout)
  }
}
