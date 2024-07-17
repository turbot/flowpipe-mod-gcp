pipeline "delete_redis_instance" {
  title       = "Delete Redis Instance"
  description = "This pipeline deletes a Google Cloud Redis instance."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "region" {
    type        = string
    description = "The region where the Redis instance is located."
  }

  param "instance_name" {
    type        = string
    description = "The name of the Redis instance to delete."
  }

  step "container" "delete_redis_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = [
      "gcloud", "redis", "instances", "delete", param.instance_name,
      "--region", param.region,
      "--quiet", "--format=json"
    ]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "redis_instance_deletion_info" {
    description = "Information about the deleted Redis instance."
    value       = jsondecode(step.container.delete_redis_instance.stdout)
  }
}
