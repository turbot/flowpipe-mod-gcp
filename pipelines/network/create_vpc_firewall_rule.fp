pipeline "create_vpc_firewall_rule" {
  title       = "Create a VPC firewall rule"
  description = "Creates a firewall rule in GCP VPC network."

  param "application_credentials_path" {
    type        = string
    description = local.application_credentials_path_param_description
    default     = var.application_credentials_path
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
    default     = var.project_id
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
    type        = string
    description = "Comma-separated list of allowed ports and protocols (e.g., tcp:80,udp:53)."
  }

  param "source_ranges" {
    type        = string
    description = "Comma-separated list of source IP ranges (CIDR format) allowed by the rule."
  }

  step "container" "create_vpc_firewall_rule" {
    image = "my-gcloud-image-latest"
    cmd = [
      "compute", "firewall-rules", "create", param.firewall_rule_name,
      "--network", param.network_name,
      "--allow", param.allowed_ports,
      "--source-ranges", param.source_ranges,
    ]
    env = {
      GCP_CREDS      = file(param.application_credentials_path),
      GCP_PROJECT_ID = param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.create_vpc_firewall_rule.stdout
  }

  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.create_vpc_firewall_rule.stderr
  }
}