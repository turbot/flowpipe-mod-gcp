pipeline "create_storage_buckets" {
  title       = "Create Storage Buckets"
  description = "This pipeline creates new storage buckets."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "bucket_urls" {
    type        = list(string)
    description = "The GCP bucket URLs."
  }

  step "container" "create_storage_buckets" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = concat(["gcloud", "storage", "buckets", "create", "--format=json"], param.bucket_urls)
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }
}
