pipeline "create_compute_instance" {
  title       = "Create Compute Instance"
  description = "This pipeline facilitates the creation of Compute Engine virtual machines."

  param "cred" {
    type        = string
    description = local.creds_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "zone" {
    type        = string
    description = "The GCP zone."
  }

  param "machine_type" {
    type        = string
    description = "The GCP machine type."
  }

  param "instance_name" {
    type        = string
    description = "The GCP instance name."
  }

  param "boot_disk_size" {
    type        = string
    description = "The GCP boot disk size."
  }

  param "confidential_compute_type" {
    type        = string
    description = "The GCP confidential compute type."
    optional    = true
  }

  param "maintenance_policy" {
    type        = string
    description = "The GCP maintenance policy."
    optional    = true
  }

  step "container" "create_compute_instance" {
    image = "gcr.io/google.com/cloudsdktool/google-cloud-cli"
    cmd = concat(["gcloud", "compute", "instances", "create", param.instance_name, "--zone", param.zone, "--machine-type", param.machine_type, "--boot-disk-size", param.boot_disk_size, "--format=json"],
    param.maintenance_policy != null ? ["--maintenance-policy", param.maintenance_policy]:[],
    param.confidential_compute_type != null ? ["--confidential-compute-type", param.confidential_compute_type]:[]
    )
    env = {
      CLOUDSDK_CORE_PROJECT      = param.project_id
      CLOUDSDK_AUTH_ACCESS_TOKEN = credential.gcp[param.cred].access_token
    }
  }

  output "instance" {
    description = "Information about the created instance."
    value       = jsondecode(step.container.create_compute_instance.stdout)
  }
}
