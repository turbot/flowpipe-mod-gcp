pipeline "remove_labels_from_redis_instance" {
  title       = "Remove Labels from Redis Instance"
  description = "This pipeline removes specified labels from a Google Cloud Redis instance."

  param "cred" {
    type        = string
    description = "GCP credentials to use"
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = "The GCP project ID."
  }

  param "instance_name" {
    type        = string
    description = "The name of the Redis instance."
  }

  param "label_keys" {
    type        = list(string)
    description = "The GCP label keys to remove."
  }

  step "container" "remove_labels_from_redis_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "redis", "instances", "update", param.instance_name, "--remove-labels", join(",", param.label_keys), "--quiet", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "instance" {
    description = "Information about the Redis instance."
    value       = jsondecode(step.container.remove_labels_from_redis_instance.stdout)
  }
}