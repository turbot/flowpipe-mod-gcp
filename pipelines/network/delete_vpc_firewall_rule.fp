pipeline "delete_vpc_firewall_rule" {
  title       = "Delete VPC Firewall Rule"
  description = "This pipeline deletes deletes Compute Engine firewall rules."

  tags = {
    recommended = "true"
  }

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "firewall_rule_name" {
    type        = string
    description = "The name of the firewall rule to delete."
  }

  step "container" "delete_vpc_firewall_rule" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "firewall-rules", "delete", param.firewall_rule_name, "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }
}
