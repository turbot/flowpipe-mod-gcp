pipeline "remove_labels_from_storage_bucket" {
  title       = "Remove Labels from Storage Bucket"
  description = "This pipeline removes labels from a Google Cloud Storage bucket using gcloud."

  param "cred" {
    type        = string
    description = "The GCP credential."
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = "The GCP project ID."
  }

  param "bucket_name" {
    type        = string
    description = "The GCP storage bucket name."
  }

  param "labels" {
    type        = list(string)
    description = "The GCP labels to remove."
  }

  step "container" "remove_labels_from_storage_bucket" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = [
      "sh", "-c",
      format("gcloud storage buckets update gs://%s --remove-labels=%s", param.bucket_name, join(",", param.labels))
    ]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "bucket" {
    description = "Information about the bucket with removed labels."
    value       = step.container.remove_labels_from_storage_bucket.stdout
  }
}
