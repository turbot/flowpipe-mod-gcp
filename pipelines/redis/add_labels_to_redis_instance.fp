pipeline "add_labels_to_redis_instance" {
  title       = "Add Labels to Redis Instance"
  description = "This pipeline adds labels to a Google Cloud Redis instance."

  param "cred" {
    type        = string
    description = "GCP credentials to use"
    default     = "default"
  }

  param "region" {
    type        = string
    description = "The GCP region."
  }

  param "project_id" {
    type        = string
    description = "The GCP project ID."
  }

  param "instance_name" {
    type        = string
    description = "The name of the Redis instance."
  }

  param "labels" {
    type        = map(string)
    description = "The GCP labels to add."
  }

  step "container" "add_labels_to_redis_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "redis", "instances", "update", param.instance_name, "--update-labels", join(",", [for k, v in param.labels : "${k}=${v}"]), "--region", param.region, "--quiet", "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "instance" {
    description = "Information about the Redis instance."
    value       = jsondecode(step.container.add_labels_to_redis_instance.stdout)
  }
}