pipeline "detach_compute_instance_from_disk" {
  title       = "Detach Compute Instance from Disk"
  description = "This pipeline is used to detach disks from virtual machines."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
    default     = var.project_id
  }

  param "instance_name" {
    type        = string
    description = "The GCP instance name."
  }

  param "disk_name" {
    type        = string
    description = "The GCP disk name."
  }

  param "zone" {
    type        = string
    description = "The GCP zone."
  }

  step "container" "detach_compute_instance_from_disk" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd   = ["gcloud", "compute", "instances", "detach-disk", param.instance_name, "--disk", param.disk_name, "--zone", param.zone, "--format=json"]
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "instance" {
    description = "Information about the instance."
    value       = jsondecode(step.container.detach_compute_instance_from_disk.stdout)
  }
}