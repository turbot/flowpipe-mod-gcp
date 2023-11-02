pipeline "delete_vpc_firewall_rule" {
  title       = "Delete a VPC firewall rule"
  description = "This pipeline deletes a VPC firewall rule in your GCP account."

  param "application_credentials_path" {
    type        = string
    default     = var.application_credentials_path
    description = "The GCP application credentials file path."
  }

  param "project_id" {
    type        = string
    default     = var.project_id
    description = "The GCP project ID."
  }

  param "firewall_rule_name" {
    type        = string
    description = "The name of the firewall rule to delete."
  }

  step "container" "delete_vpc_firewall_rule" {
    image = "my-gcloud-image-latest"
    cmd   = ["compute", "firewall-rules", "delete", param.firewall_rule_name]
    env = {
      GCP_CREDS      = file(param.application_credentials_path),
      GCP_PROJECT_ID = param.project_id,
    }
  }

  output "stdout" {
    description = "The JSON output from the GCP CLI."
    value       = step.container.delete_vpc_firewall_rule.stdout
  }

  output "stderr" {
    description = "The error output from the GCP CLI."
    value       = step.container.delete_vpc_firewall_rule.stderr
  }
}
