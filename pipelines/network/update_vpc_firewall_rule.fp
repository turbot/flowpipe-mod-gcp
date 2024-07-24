pipeline "update_vpc_firewall_rule" {
  title       = "Update VPC Firewall Rule"
  description = "This pipeline updates a Google Compute Engine VPC firewall rule with optional parameters."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "firewall_rule_name" {
    type        = string
    description = "The name of the firewall rule."
  }

  param "allow" {
    type        = list(string)
    description = "The list of protocols and ports to allow."
    optional    = true
  }

  param "source_ranges" {
    type        = list(string)
    description = "The list of source IP address ranges to allow."
    optional    = true
  }

  step "container" "update_vpc_firewall_rule" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(
      ["gcloud", "compute", "firewall-rules", "update", param.firewall_rule_name],
      param.allow != null ? ["--allow", join(",", param.allow)] : [],
      param.source_ranges != null ? ["--source-ranges", join(",", param.source_ranges)] : [],
      ["--format=json"]
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "firewall_rule_info" {
    description = "Information about the updated firewall rule."
    value       = jsondecode(step.container.update_vpc_firewall_rule.stdout)
  }
}
