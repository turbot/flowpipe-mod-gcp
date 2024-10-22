pipeline "create_compute_disk" {
  title       = "Create Compute Disk"
  description = "This pipeline creates Compute Engine persistent disk."

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

  param "size" {
    type        = string
    description = "The GCP zone."
    optional    = true
  }

  step "container" "create_compute_disk" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(["gcloud", "compute", "disks", "create", param.disk_name, "--zone", param.zone, "--format=json"],
    param.size != null ? ["--size", param.size] : [])
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = param.conn.access_token
    }
  }

  output "disk" {
    description = "Information about the created disk."
    value       = jsondecode(step.container.create_compute_disk.stdout)
  }
}
