pipeline "create_vpc_firewall_rule" {
  title       = "Create VPC Firewall Rule"
  description = "This pipeline is used to create firewall rules to allow/deny incoming/outgoing traffic."

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
    description = "The name of the firewall rule to create."
  }

  param "network_name" {
    type        = string
    description = "The name of the network to which the rule applies."
  }

  param "allowed_ports" {
    type        = list(string)
    description = "Comma-separated list of allowed ports and protocols (e.g., tcp:80,udp:53)."
    optional    = true
  }

  param "source_ranges" {
    type        = list(string)
    description = "Comma-separated list of source IP ranges (CIDR format) allowed by the rule."
    optional    = true
  }

  param "priority" {
    type        = string
    description = "Priority for the firewall rule."
    optional    = true
  }

  param "rules" {
    type        = list(string)
    description = "A list of protocols and ports to which the firewall rule will apply."
    optional    = true
  }

  param "action" {
    type        = string
    description = "The action for the firewall rule: whether to allow or deny matching traffic."
    optional    = true
  }

  param "direction" {
    type        = string
    description = "The direction of traffic to which the firewall rule applies."
    optional    = true
  }

  step "container" "create_vpc_firewall_rule" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(
      ["gcloud", "compute", "firewall-rules", "create", param.firewall_rule_name, "--network", param.network_name, "--format=json"],
      param.allowed_ports != null ? ["--allow", join(",", param.allowed_ports)] : [],
      param.source_ranges != null ? ["--source-ranges", join(",", param.source_ranges)] : [],
      param.rules != null ? ["--rules", join(",", param.rules)] : [],
      param.action != null ? ["--action", param.action] : [],
      param.priority != null ? ["--priority", param.priority] : [],
      param.direction != null ? ["--direction", param.direction] : []
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "firewall_rule" {
    description = "Information about the created firewall rule."
    value       = jsondecode(step.container.create_vpc_firewall_rule.stdout)
  }
}
