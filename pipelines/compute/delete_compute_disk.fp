pipeline "delete_compute_disk" {
  title       = "Delete Compute Disk"
  description = "This pipeline deletes a Compute Engine disk. A disk can be deleted only if it is not attached to any virtual machine instances."

  param "conn" {
    type        = connection.gcp
    description = local.conn_param_description
    default     = connection.gcp.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "disk_name" {
    type        = string
    description = "The GCP disk name."
  }

  param "zone" {
    type        = string
    description = "The GCP zone."
  }

  step "container" "delete_compute_disk" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "disks", "delete", param.disk_name, "--zone", param.zone, "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }
}
