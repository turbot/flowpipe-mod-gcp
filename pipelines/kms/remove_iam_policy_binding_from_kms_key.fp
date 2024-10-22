pipeline "remove_iam_policy_binding_from_kms_key" {
  title       = "Remove IAM Policy Binding from KMS Key"
  description = "This pipeline removes an IAM policy binding from a Google Cloud KMS key."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "key_name" {
    type        = string
    description = "The name of the KMS key."
  }

  param "key_ring_name" {
    type        = string
    description = "The name of the KMS key ring."
  }

  param "location" {
    type        = string
    description = "The location of the KMS key."
  }

  param "member" {
    type        = string
    description = "The member to remove from the IAM policy binding."
  }

  param "role" {
    type        = string
    description = "The IAM role to remove."
  }

  step "container" "remove_iam_policy_binding_from_kms_key" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = [
      "gcloud", "kms", "keys", "remove-iam-policy-binding", param.key_name,
      "--keyring", param.key_ring_name,
      "--location", param.location,
      "--member", param.member,
      "--role", param.role,
      "--format=json"
    ]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "kms_key_iam_policy_info" {
    description = "Information about the KMS key IAM policy binding removal."
    value       = jsondecode(step.container.remove_iam_policy_binding_from_kms_key.stdout)
  }
}
