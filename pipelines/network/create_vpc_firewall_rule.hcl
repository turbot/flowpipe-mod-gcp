pipeline "create_vpc_firewall_rule" {
  param "application_credentials_64" {
    type        = "string"
    default     = var.application_credentials_64
    description = "The GCP application credentials."
  }

  param "project_id" {
    type        = "string"
    default     = var.project_id
    description = "The GCP project ID."
  }

  param "firewall_rule_name" {
    type        = "string"
    description = "The name of the firewall rule to create."
    default     = "integrated-rule"
  }

  param "network_name" {
    type        = "string"
    description = "The name of the network to which the rule applies."
    default     = "integrated-vpc"
  }

  param "allowed_ports" {
    type        = "string"
    description = "Comma-separated list of allowed ports and protocols (e.g., tcp:80,udp:53)."
    default     = "tcp:80"
  }

  param "source_ranges" {
    type        = "string"
    description = "Comma-separated list of source IP ranges (CIDR format) allowed by the rule."
    default     = "0.0.0.0/0"
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
      GCP_CREDS      = param.application_credentials_64,
      GCP_PROJECT_ID = param.project_id,
    }
  }

  output "stdout" {
    value = step.container.create_vpc_firewall_rule.stdout
  }

  output "stderr" {
    value = step.container.create_vpc_firewall_rule.stderr
  }
}