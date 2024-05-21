pipeline "delete_compute_address" {
  title       = "Delete Compute Address"
  description = "This pipeline facilitates the deletion of Compute Engine addresses."

  param "cred" {
    type        = string
    description = "The GCP credential name."
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = "The GCP project ID."
  }

  param "address_name" {
    type        = string
    description = "The name of the address to delete."
  }

  param "region" {
    type        = string
    description = "The region or location of the address to delete."
  }

  step "container" "delete_compute_address" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(["gcloud", "compute", "addresses", "delete", param.address_name, "--quiet", "--format=json"],
    param.region != "" ? ["--region", param.region] : ["--global"])
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }
}
