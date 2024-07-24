pipeline "remove_labels_from_dns_managed_zone" {
  title       = "Remove Labels from DNS Managed Zone"
  description = "This pipeline removes specified labels from a Google Cloud DNS managed zone."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "zone_name" {
    type        = string
    description = "The name of the DNS managed zone."
  }

  param "label_keys" {
    type        = list(string)
    description = "The GCP label keys to remove."
  }

  step "container" "remove_labels_from_dns_managed_zone" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "dns", "managed-zones", "update", param.zone_name, "--remove-labels", join(",", param.label_keys), "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "managed_zone" {
    description = "Information about the DNS managed zone."
    value       = jsondecode(step.container.remove_labels_from_dns_managed_zone.stdout)
  }
}
