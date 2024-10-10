pipeline "add_labels_to_storage_bucket" {
  title       = "Update Labels on Storage Bucket"
  description = "This pipeline updates labels on a Google Cloud Storage bucket using gcloud."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
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
    type        = map(string)
    description = "The GCP labels to update."
  }

  step "container" "add_labels_to_storage_bucket" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = [
      "sh", "-c",
      format("gcloud storage buckets update gs://%s --update-labels=%s", param.bucket_name, join(",", [for key, value in param.labels : "${key}=${value}"]))
    ]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }
}
