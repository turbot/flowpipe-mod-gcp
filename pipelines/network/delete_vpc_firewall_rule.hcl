pipeline "delete_vpc_firewall_rule" {
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
    description = "The name of the firewall rule to delete."
    default     = "integrated-rule"
  }

  step "container" "delete_vpc_firewall_rule" {
    image = "my-gcloud-image-latest"
    cmd = ["compute", "firewall-rules", "delete", param.firewall_rule_name]
    env = {
      GCP_CREDS      = param.application_credentials_64,
      GCP_PROJECT_ID = param.project_id,
    }
  }

  output "stdout" {
    value = step.container.delete_vpc_firewall_rule.stdout
  }

  output "stderr" {
    value = step.container.delete_vpc_firewall_rule.stderr
  }
}
