pipeline "add_iam_policy_binding_to_kms_key" {
  title       = "Add IAM Policy Binding to KMS Key"
  description = "This pipeline adds an IAM policy binding to a Google Cloud KMS key."

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
    description = "The member to add to the IAM policy binding."
  }

  param "role" {
    type        = string
    description = "The IAM role to add."
  }

  step "container" "add_iam_policy_binding_to_kms_key" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = [
      "gcloud", "kms", "keys", "add-iam-policy-binding", param.key_name,
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
    description = "Information about the added IAM policy binding to the KMS key."
    value       = jsondecode(step.container.add_iam_policy_binding_to_kms_key.stdout)
  }
}
