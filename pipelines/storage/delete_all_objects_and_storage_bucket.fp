pipeline "delete_all_objects_and_storage_bucket" {
  title       = "Delete All Objects and Storage Bucket"
  description = "This pipeline deletes all objects and the bucket from Google Cloud Storage."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "bucket_url" {
    type        = string
    description = "The URL of the bucket to delete (e.g., gs://my-bucket/)."
  }

  step "container" "delete_all_objects_and_storage_bucket" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = [
      "gcloud", "storage", "rm", "--recursive", param.bucket_url,
      "--quiet", "--format=json"
    ]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "storage_deletion_info" {
    description = "Information about the deleted storage bucket and its objects."
    value       = jsondecode(step.container.delete_all_objects_and_storage_bucket.stdout)
  }
}
