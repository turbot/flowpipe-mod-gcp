pipeline "update_access_approval_settings" {
  title       = "Update Access Approval Settings"
  description = "This pipeline updates the access approval settings for a Google Cloud project."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "enrolled_services" {
    type        = bool
    description = "The services to enroll for access approval."
    optional    = true
  }

  param "notification_emails" {
    type        = string
    description = "The email recipient for access approval requests."
    optional    = true
  }

  step "container" "update_access_approval_settings" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(
      ["gcloud", "access-approval", "settings", "update", "--project", param.project_id],
      param.enrolled_services == true ? ["--enrolled_services=all"] : [],
      param.notification_emails != null ? ["--notification_emails", param.notification_emails] : [],
      ["--format=json"]
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "access_approval_settings_info" {
    description = "Information about the updated access approval settings."
    value       = jsondecode(step.container.update_access_approval_settings.stdout)
  }
}
