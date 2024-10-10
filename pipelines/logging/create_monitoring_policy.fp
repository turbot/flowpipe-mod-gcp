pipeline "create_monitoring_policy" {
  title       = "Create Monitoring Policy"
  description = "This pipeline creates a monitoring policy in Google Cloud."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "policy" {
    type        = string
    description = "The monitoring policy in JSON format."
  }

  step "container" "create_monitoring_policy" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "alpha", "monitoring", "policies", "create", "--policy", param.policy, "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "monitoring_policy_info" {
    description = "Information about the created monitoring policy."
    value       = jsondecode(step.container.create_monitoring_policy.stdout)
  }
}
